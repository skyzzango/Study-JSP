<%@ page import="user.UserDAO" %>
<%@ page import="java.io.PrintWriter" %><%--
  Created by IntelliJ IDEA.
  User: skyzz
  Date: 2018-09-20
  Time: 오전 11:51
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<% request.setCharacterEncoding("UTF-8"); %>

<%
	System.out.println("유저 로그아웃: " + session.getAttribute("userId"));
	session.invalidate(); // 세션 초기화
	response.getWriter().println("<script>location.href = '/'</script>");
%>

<html lang="ko">
<head>
	<%@include file="/partials/head.jsp" %>
	<title>Logout Proc</title>
</head>

<body>

<%@include file="/partials/nav.jsp" %>


<div class="container">

	<div class="starter-template">
		<h1>로그아웃 처리 페이지</h1>

	</div>

</div><!-- /.container -->


<%@include file="/partials/script.jsp" %>

</body>
</html>