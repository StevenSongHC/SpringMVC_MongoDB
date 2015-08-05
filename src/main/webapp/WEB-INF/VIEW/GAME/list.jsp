<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% 
String basepath = request.getContextPath();
%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Games</title>
<jsp:include page="../include.jsp" flush="true" />
<script type="text/javascript">
$(document).ready(function() {
	// RegEx for price
	floatReg = /^\d+(\.\d+)?$/;
	
	// bind "ENTER" key pressed event
	$("#input-new-gamename,#input-new-gameprice").keypress(function (e) {
		if (e.keyCode == 13) {
			createGame();
		}
	});
});

function createGame() {
	var gamename = $("#input-new-gamename").val().trim();
	var gameprice = $("#input-new-gameprice").val().trim();
	if (gamename.length > 0 && floatReg.test(gameprice)) {
		$.ajax( {
			url: "<%=basepath%>/game/create",
			type: "POST",
			dataType: "JSON",
			data: {
				gamename: gamename,
				gameprice: gameprice
			}
		}).done(function(json) {
			switch (json.status) {
				case -1: 
					alert("Existed Gamename!");
					break;
				case 1:
					$("#input-new-gamename").val("");
					$("#input-new-gameprice").val("");
					$("#input-new-gamename").focus();
					$("#game-list>tbody>tr:last").before("<tr><td>" + json.newGame.id + "</td><td>" + json.newGame.name + "</td><td>" + json.newGame.price + "</td><td>* NEW *</td></tr>");
					break;
				default:
					alert("Error???");
			}
		}).fail(function() {
			console.log("Ajax Fail!!!");
		});
	}
	else {
		alert("Illegal Game Item");
	}
}
function preUpdateGame(gid) {
	var e = $("#game-list tr[data-id='" + gid + "']");
	$(e).find(".gamename").hide();
	$(e).find(".gameprice").hide();
	$(e).find("input.input-gamename").show();
	$(e).find("input.input-gameprice").show();
	$(e).find(".p").hide();
	$(e).find(".d").hide();
	$(e).find(".u").show();
	$(e).find(".c").show();
}
function cancelUpdateGame(gid) {
	var e = $("#game-list tr[data-id='" + gid + "']");
	var oGamename = $(e).find(".gamename").html();
	var oGameprice = $(e).find(".gameprice").html();
	$(e).find(".gamename").show();
	$(e).find(".gameprice").show();
	$(e).find("input.input-gamename").val(oGamename).hide();
	$(e).find("input.input-gameprice").val(oGameprice).hide();
	$(e).find(".p").show();
	$(e).find(".d").show();
	$(e).find(".u").hide();
	$(e).find(".c").hide();
}
function updateGame(gid) {
	var e = $("#game-list tr[data-id='" + gid + "']");
	var gamename = $(e).find("input.input-gamename").val().trim();
	var gameprice = $(e).find("input.input-gameprice").val().trim();
	if (gid != undefined && gid.length > 0 && gamename != undefined && gamename.length > 0 && gameprice != undefined && gameprice.length > 0) {
		$.ajax( {
			url: "<%=basepath%>/game/update",
			type: "POST",
			dataType: "JSON",
			data: {
				gid: gid,
				gamename: gamename,
				gameprice: gameprice
			}
		}).done(function(json) {
			switch (json.status) {
			case -1: 
				alert("Game Does Not Existed");
				break;
			case 0: 
				alert("Illegal Parameter");
				break;
			case 1:
				$(e).find("input.input-gamename").hide();
				$(e).find("input.input-gameprice").hide();
				$(e).find(".gamename").html(gamename);
				$(e).find(".gameprice").html(gameprice);
				$(e).find(".gamename").show();
				$(e).find(".gameprice").show();
				$(e).find(".p").show();
				$(e).find(".d").show();
				$(e).find(".u").hide();
				$(e).find(".c").hide();
				break;
			default:
				alert("Error???");
		}
		}).fail(function() {
			console.log("Ajax Fail!!!");
		});
	}
	else {
		alert("Game Info Not Correct");
	}
}
function deleteGame(gid) {
	if (confirm("Are You Sure?")) {
		var e = $("#game-list tr[data-id='" + gid + "']");
		if (gid != undefined && gid.length > 0) {
			$.ajax( {
				url: "<%=basepath%>/game/delete",
				type: "POST",
				dataType: "JSON",
				data: {
					gid: gid
				}
			}).done(function(json) {
				switch (json.status) {
				case -1: 
					alert("Such Game Does Not Existed");
					break;
				case 0: 
					alert("Illegal Parameter");
					break;
				case 1:
					$(e).remove();
					break;
				default:
					alert("Error???");
			}
			}).fail(function() {
				console.log("Ajax Fail!!!");
			});
		}
		else {
			alert("Game Info Not Correct");
		}
	}
}
</script>
</head>
<body>
<div style="width: 50%; margin: auto; margin-top: 100px;">
	<table class="table table-hover" id="game-list">
		<thead>
			<tr>
				<th width="25%">Id</th>
				<th width="40%">Name</th>
				<th width="15%">Price</th>
				<th width="20%">function</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${gameList}" var="g">
				<tr class="item" data-id=${g.id}>
					<td class="gid">${g.id}</td>
					<td>
						<a href="<%=basepath%>/game/g/${g.name}" target="_blank"><span class="gamename">${g.name}</span></a>
						<input type="text" class="form-control input-gamename" value="${g.name}" style="display: none;" />
					</td>
					<td>
						<span class="gameprice">${g.price}</span>
						<input type="text" class="form-control input-gameprice" value="${g.price}" style="display: none;" />
					</td>
					<td>
						<button type="button" class="btn btn-primary btn-sm p" onclick="javascript:preUpdateGame('${g.id}')">update</button>
						<button type="button" class="btn btn-danger btn-sm d" style="float: right;" onclick="javascript:deleteGame('${g.id}')">delete</button>
						<button type="button" class="btn btn-success btn-sm u" style="display: none;" onclick="javascript:updateGame('${g.id}')">confirm</button>
						<button type="button" class="btn btn-warning btn-sm c" style="display: none;" onclick="javascript:cancelUpdateGame('${g.id}')">cancel</button>
					</td>
				</tr>
			</c:forEach>
			<c:forEach items="${gamePage.dataItems}" var="g">
				<tr class="item" data-id=${g.id}>
					<td class="gid">${g.id}</td>
					<td>
						<a href="<%=basepath%>/game/g/${g.name}" target="_blank"><span class="gamename">${g.name}</span></a>
						<input type="text" class="form-control input-gamename" value="${g.name}" style="display: none;" />
					</td>
					<td>
						<span class="gameprice">${g.price}</span>
						<input type="text" class="form-control input-gameprice" value="${g.price}" style="display: none;" />
					</td>
					<td>
						<button type="button" class="btn btn-primary btn-sm p" onclick="javascript:preUpdateGame('${g.id}')">update</button>
						<button type="button" class="btn btn-danger btn-sm d" style="float: right;" onclick="javascript:deleteGame('${g.id}')">delete</button>
						<button type="button" class="btn btn-success btn-sm u" style="display: none;" onclick="javascript:updateGame('${g.id}')">confirm</button>
						<button type="button" class="btn btn-warning btn-sm c" style="display: none;" onclick="javascript:cancelUpdateGame('${g.id}')">cancel</button>
					</td>
				</tr>
			</c:forEach>
			<tr>
				<td></td>
				<td><input type="text" class="form-control" id="input-new-gamename"></td>
				<td><input type="text" class="form-control" id="input-new-gameprice"></td>
			</tr>
		</tbody>
	</table>
	<nav style="text-align: center;">
		<ul class="pagination">
			<c:if test="${gamePage.firstPage.visible == true}">
				<li><a href="<%=basepath%>/${gamePage.firstPage.url}">&laquo;</a></li>
			</c:if>
			<c:if test="${gamePage.previousPage.visible == true}">
				<li><a href="<%=basepath%>/${gamePage.previousPage.url}">&lt;</a></li>
			</c:if>
			<c:forEach items="${gamePage.pageIndexes}" var="gi">
				<li
					<c:if test="${gi.isCurrentPage == true}">
						class="active"
					</c:if>
				><a href="<%=basepath%>/${gi.url}">${gi.value}</a></li>
			</c:forEach>
			<c:if test="${gamePage.nextPage.visible == true}">
				<li><a href="<%=basepath%>/${gamePage.nextPage.url}">&gt;</a></li>
			</c:if>
			<c:if test="${gamePage.lastPage.visible == true}">
				<li><a href="<%=basepath%>/${gamePage.lastPage.url}">&raquo;</a></li>
			</c:if>
		</ul>
	</nav>
	<button type="button" class="btn btn-default" style="float: right; margin-bottom: 100px;" onclick="javascript:createGame()">Add New Game</button>
</div>
</body>
</html>