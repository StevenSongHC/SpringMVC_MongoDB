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
<title>${user.name} - set game collection</title>
<jsp:include page="../include.jsp" flush="true" />
<script type="text/javascript">
$(document).ready(function() {
	
});

function saveCollection(uid) {
	var gamesArr = new Array();
	$("input[type=checkbox][name='games']:checked").each(function() {
		gamesArr.push($(this).val());
	});
	$.ajax( {
		url: "<%=basepath%>/user/set_game_collection",
		type: "POST",
		dataType: "JSON",
		data: {
			uid: uid,
			"gamesArr[]": gamesArr
		}
	}).done(function(json) {
		switch (json.status) {
			case -1: 
				alert("Illegal User ID");
				break;
			case 1:
				alert("Collection Saved");
				break;
			default:
				alert("Error???");
		}
	}).fail(function() {
		console.log("Ajax Fail!!!");
	});
}
</script>
</head>
<body style="margin: 100px;">
<div class="page-header">
	<h2>${user.name}</h2>
</div>
<div id="game-list" style="width: 30%; margin-left: 30px;">
	<form class="form-horizontal">
			<c:forEach items="${gameList}" var="g">
			<div class="form-group">
				<div class="input-group">
					<div class="input-group-addon">
						<label>
							<input type="checkbox" name="games" value="${g.id}"
								<c:forEach items="${user.games}" var="ug">
									<c:if test="${g.id eq ug.id}">
										checked="checked"
									</c:if>
								</c:forEach>
							>
						</label>
					</div>
					<input type="text" class="form-control" value="${g.name}" disabled>
				</div>
			</div>
		</c:forEach>
	</form>
</div>
<button type="button" class="btn btn-default btn-lg" onclick="javascript:saveCollection('${user.id}')">Save Collection</button>
</body>
</html>