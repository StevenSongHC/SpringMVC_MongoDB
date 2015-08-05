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
<title>${game.name}'s detail page</title>
<jsp:include page="../include.jsp" flush="true" />
</head>
<body style="margin: 100px 0 100px 50px;">
<div class="page-header">
	<h2>${game.name} <small>$${game.price}</small></h2>
</div>
<div style="margin-left: 100px; width: 30%;">
	<h4>Owner List <span class="badge">${userCount}</span></h4>
	<div class="list-group">
		<c:forEach items="${userList}" var="u">
			<a href="<%=basepath%>/user/u/${u.name}" target="_blank" class="list-group-item">${u.name}</a>
		</c:forEach>
	</div>
</div>
</body>
</html>