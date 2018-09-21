<%--
  Created by IntelliJ IDEA.
  User: skyzz
  Date: 2018-09-20
  Time: 오전 10:54
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<html lang="ko">
<head>
	<%@include file="/partials/head.jsp" %>
	<title>Main Page</title>
</head>

<body>

<%@include file="/partials/nav.jsp" %>

<div class="container">

	<div class="starter-template">
		<h1>메인 화면</h1>
		<br>
		<% if (session.getAttribute("userId") == null) { %>
		<button onclick="document.getElementById('id01').style.display='block'" style="width:auto;">Sign In</button>
		<% } else { %>
		<button onclick="location.href='/user/logoutProc.jsp'" style="width:auto;">Sign Out</button>
		<% } %>
		<button onclick="document.getElementById('id02').style.display='block'" style="width:auto;">Sign Up</button>

		<button onclick="location.href='/board/'" style="width:auto;">게시판</button>
		<button onclick="location.href='/content/'" style="width:auto;">파일 게시판</button>

	</div>

</div><!-- /.container -->


<%@include file="/partials/script.jsp" %>

</body>
</html>