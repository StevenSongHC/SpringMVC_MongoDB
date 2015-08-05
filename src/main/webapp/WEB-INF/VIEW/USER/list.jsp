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
<title>User Says Hi</title>
<jsp:include page="../include.jsp" flush="true" />
<script type="text/javascript">
$(document).ready(function() {
	// bind "ENTER" key pressed event
	$("#input-new-username").keypress(function (e) {
		if (e.keyCode == 13) {
			createUser();
		}
	});
});

function createUser() {
	var username = $("#input-new-username").val().trim();
	if (username.length > 0) {
		$.ajax( {
			url: "<%=basepath%>/user/create",
			type: "POST",
			dataType: "JSON",
			data: {
				username: username
			}
		}).done(function(json) {
			switch (json.status) {
				case -1: 
					alert("Existed Username!");
					break;
				case 1:
					$("#input-new-username").val("");
					$("#user-list>tbody>tr:last").before("<tr><td>" + json.newUser.id + "</td><td>" + json.newUser.name + "</td><td>* NEW *</td></tr>");
					break;
				default:
					alert("Error???");
			}
		}).fail(function() {
			console.log("Ajax Fail!!!");
		});
	}
	else {
		alert("Empty Username!!!");
	}
}
function preUpdateUser(uid) {
	var e = $("#user-list tr[data-id='" + uid + "']");
	$(e).find(".username").hide();
	$(e).find("input.form-control").show();
	$(e).find(".p").hide();
	$(e).find(".d").hide();
	$(e).find(".u").show();
	$(e).find(".c").show();
}
function cancelUpdateUser(uid) {
	var e = $("#user-list tr[data-id='" + uid + "']");
	var oUsername = $(e).find(".username").html();
	$(e).find(".username").show();
	$(e).find("input.form-control").val(oUsername).hide();
	$(e).find(".p").show();
	$(e).find(".d").show();
	$(e).find(".u").hide();
	$(e).find(".c").hide();
}
function updateUser(uid) {
	var e = $("#user-list tr[data-id='" + uid + "']");
	var username = $(e).find("input.form-control").val().trim();
	if (uid != undefined && uid.length > 0 && username != undefined && username.length > 0) {
		$.ajax( {
			url: "<%=basepath%>/user/update",
			type: "POST",
			dataType: "JSON",
			data: {
				uid: uid,
				username: username
			}
		}).done(function(json) {
			switch (json.status) {
				case -2:
					alert("Such Username Has Been Used");
					break;
				case -1: 
					alert("User Does Not Existed");
					break;
				case 0: 
					alert("Illegal Parameter");
					break;
				case 1:
					$(e).find("input.form-control").hide();
					$(e).find(".username").html(username);
					$(e).find(".username").show();
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
		alert("User Info Not Correct");
	}
}
function deleteUser(uid) {
	if (confirm("Are You Sure?")) {
		var e = $("#user-list tr[data-id='" + uid + "']");
		if (uid != undefined && uid.length > 0) {
			$.ajax( {
				url: "<%=basepath%>/user/delete",
				type: "POST",
				dataType: "JSON",
				data: {
					uid: uid
				}
			}).done(function(json) {
				switch (json.status) {
				case -1: 
					alert("Such User Does Not Existed");
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
			alert("User Info Not Correct");
		}
	}
}
</script>
</head>
<body>
<img alt="default img" src="<%=basepath%>/images/default.png">
<hr>
<div style="width: 50%; margin: auto;">
	<table class="table table-hover" id="user-list">
		<thead>
			<tr>
				<th width="25%">Id</th>
				<th width="50%">Name</th>
				<th width="25%">function</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${userList}" var="u">
				<tr class="item" data-id=${u.id}>
					<td class="uid">${u.id}</td>
					<td>
						<span><a href="<%=basepath%>/user/u/${u.name}" target="_blank" class="username">${u.name}</a></span>
						<input type="text" class="form-control" value="${u.name}" style="display: none;" />
					</td>
					<td>
						<button type="button" class="btn btn-primary btn-sm p" onclick="javascript:preUpdateUser('${u.id}')">update</button>
						<button type="button" class="btn btn-danger btn-sm d" style="float: right;" onclick="javascript:deleteUser('${u.id}')">delete</button>
						<button type="button" class="btn btn-success btn-sm u" style="display: none;" onclick="javascript:updateUser('${u.id}')">confirm</button>
						<button type="button" class="btn btn-warning btn-sm c" style="display: none;" onclick="javascript:cancelUpdateUser('${u.id}')">cancel</button>
					</td>
				</tr>
			</c:forEach>
			<c:forEach items="${userPage.dataItems}" var="u">
				<tr class="item" data-id=${u.id}>
					<td class="uid">${u.id}</td>
					<td>
						<span><a href="<%=basepath%>/user/u/${u.name}" target="_blank" class="username">${u.name}</a></span>
						<input type="text" class="form-control" value="${u.name}" style="display: none;" />
					</td>
					<td>
						<button type="button" class="btn btn-primary btn-sm p" onclick="javascript:preUpdateUser('${u.id}')">update</button>
						<button type="button" class="btn btn-danger btn-sm d" style="float: right;" onclick="javascript:deleteUser('${u.id}')">delete</button>
						<button type="button" class="btn btn-success btn-sm u" style="display: none;" onclick="javascript:updateUser('${u.id}')">confirm</button>
						<button type="button" class="btn btn-warning btn-sm c" style="display: none;" onclick="javascript:cancelUpdateUser('${u.id}')">cancel</button>
					</td>
				</tr>
			</c:forEach>
			<tr>
				<td></td>
				<td><input type="text" class="form-control" id="input-new-username"></td>
			</tr>
		</tbody>
	</table>
	<nav style="text-align: center;">
		<ul class="pagination">
			<c:if test="${userPage.firstPage.visible == true}">
				<li><a href="<%=basepath%>/${userPage.firstPage.url}">&laquo;</a></li>
			</c:if>
			<c:if test="${userPage.previousPage.visible == true}">
				<li><a href="<%=basepath%>/${userPage.previousPage.url}">&lt;</a></li>
			</c:if>
			<c:forEach items="${userPage.pageIndexes}" var="pi">
				<li
					<c:if test="${pi.isCurrentPage == true}">
						class="active"
					</c:if>
				><a href="<%=basepath%>/${pi.url}">${pi.value}</a></li>
			</c:forEach>
			<c:if test="${userPage.nextPage.visible == true}">
				<li><a href="<%=basepath%>/${userPage.nextPage.url}">&gt;</a></li>
			</c:if>
			<c:if test="${userPage.lastPage.visible == true}">
				<li><a href="<%=basepath%>/${userPage.lastPage.url}">&raquo;</a></li>
			</c:if>
		</ul>
	</nav>
	<button type="button" class="btn btn-default" style="float: right; margin-bottom: 100px;" onclick="javascript:createUser()">Add New User</button>
</div>
</body>
</html>