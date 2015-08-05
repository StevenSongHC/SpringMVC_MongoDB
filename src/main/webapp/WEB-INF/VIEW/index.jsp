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
<title>Hello World</title>
<jsp:include page="include.jsp" flush="true" />
</head>
<body>
SpringMVC + MongoDB Demo
<div class="well">
	<a href="<%=basepath%>/user/list" target="_blank">USER</a>
</div>
<div class="well">
	<a href="<%=basepath%>/game/list" target="_blank">GAME</a>
</div>
<div class="well">
	<a href="<%=basepath%>/users_games" target="_blank">User's Game Collection</a>
</div>
</body>
</html>