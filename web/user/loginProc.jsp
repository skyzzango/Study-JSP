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
<jsp:useBean id="user" class="user.UserVo" scope="page"/>
<jsp:setProperty name="user" property="userId"/>
<jsp:setProperty name="user" property="userPw"/>

<%
	PrintWriter script = response.getWriter();
	UserDAO userDAO = UserDAO.getInstance();
	int result = userDAO.login(user.getUserId(), user.getUserPw());
	if( result == 1 ){
		System.out.println("유저 로그인: " + user.getUserId());
		session.setAttribute("userId", user.getUserId());
		response.getWriter().println("<script>location.href = '/'</script>");
	} else if ( result == 0 ){
		script.println("<script>alert('패스워드가 일치하지 않습니다')</script>");
		script.println("<script>history.back()</script>");
	} else if ( result == -1 ){
		script.println("<script>alert('존재하지 않는 아이디 입니다')</script>");
		script.println("<script>history.back()</script>");
	} else if ( result == -2 ){
		script.println("<script>alert('DB 오류 발생')</script>");
		script.println("<script>history.back()</script>");
	}
%>

<html lang="ko">
<head>
	<%@include file="/partials/head.jsp" %>
	<title>Login Proc</title>
</head>

<body>

<%@include file="/partials/nav.jsp" %>


<div class="container">

	<div class="starter-template">
		<h1>로그인 처리 페이지</h1>

	</div>

</div><!-- /.container -->


<%@include file="/partials/script.jsp" %>

</body>
</html>