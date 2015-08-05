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
<title>Game Mapping For Users</title>
<jsp:include page="include.jsp" flush="true" />
</head>
<div class="page-header">
	<h2>User's Game Collection</h2>
</div>
<body style="width: 30%; margin: auto; margin-bottom: 100px;">
<c:forEach items="${users}" var="u">
	<div class="panel panel-success">
		<div class="panel-heading">
			<h3 class="panel-title"><a href="<%=basepath%>/user/u/${u.name}" target="_blank" class="thumbnail">${u.name}</a></h3>
			<div class="panel-body">
				<ul class="list-group">
					<c:forEach items="${u.games}" var="g">
						<a href="<%=basepath%>/game/g/${g.name}" target="_blank" class="list-group-item">${g.name}</a>
					</c:forEach>
				</ul>
			</div>
		</div>
	</div>
</c:forEach>
<c:forEach items="${collectionPage.dataItems}" var="u">
	<div class="panel panel-success">
		<div class="panel-heading">
			<h3 class="panel-title"><a href="<%=basepath%>/user/u/${u.name}" target="_blank" class="thumbnail">${u.name}</a></h3>
			<div class="panel-body">
				<ul class="list-group">
					<c:forEach items="${u.games}" var="g">
						<a href="<%=basepath%>/game/g/${g.name}" target="_blank" class="list-group-item">${g.name}</a>
					</c:forEach>
				</ul>
			</div>
		</div>
	</div>
</c:forEach>
<nav style="text-align: center;">
	<ul class="pagination">
		<c:if test="${collectionPage.firstPage.visible == true}">
			<li><a href="<%=basepath%>/${collectionPage.firstPage.url}">&laquo;</a></li>
		</c:if>
		<c:if test="${collectionPage.previousPage.visible == true}">
			<li><a href="<%=basepath%>/${collectionPage.previousPage.url}">&lt;</a></li>
		</c:if>
		<c:forEach items="${collectionPage.pageIndexes}" var="pi">
			<li
				<c:if test="${pi.isCurrentPage == true}">
					class="active"
				</c:if>
			><a href="<%=basepath%>/${pi.url}">${pi.value}</a></li>
		</c:forEach>
		<c:if test="${collectionPage.nextPage.visible == true}">
			<li><a href="<%=basepath%>/${collectionPage.nextPage.url}">&gt;</a></li>
		</c:if>
		<c:if test="${collectionPage.lastPage.visible == true}">
			<li><a href="<%=basepath%>/${collectionPage.lastPage.url}">&raquo;</a></li>
		</c:if>
	</ul>
</nav>
</body>
</html>