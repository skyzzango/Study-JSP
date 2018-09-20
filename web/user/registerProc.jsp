<%@ page import="user.UserDAO" %>
<%@ page import="java.io.PrintWriter" %><%--
  Created by IntelliJ IDEA.
  User: skyzz
  Date: 2018-09-20
  Time: 오후 4:33
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<% request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="user" class="user.UserVo" scope="page"/>
<jsp:setProperty name="user" property="userId"/>
<jsp:setProperty name="user" property="userPw"/>
<jsp:setProperty name="user" property="userName"/>

<%
	PrintWriter script = response.getWriter();
	if (!request.getParameter("userPw").equals(request.getParameter("userPw-repeat"))) {
		script.println("<script>alert('비밀번호가 일치 하지 않습니다.')</script>");
		script.println("<script>history.back()</script>");
	} else {
		UserDAO userDAO = UserDAO.getInstance();
		int result = userDAO.register(user);
		if (result == 1) {
			System.out.println("유저 가입: " + user.getUserId());
			script.println("<script>location.href = '/'</script>");
		} else if (result == -1) {
			script.println("<script>alert('이미 존재하는 아이디 입니다')</script>");
			script.println("<script>history.back()</script>");
		}
	}
%>

<html lang="ko">
<head>
	<%@include file="/partials/head.jsp" %>
	<title>Register Proc</title>
</head>

<body>

<%@include file="/partials/nav.jsp" %>


<div class="container">

	<div class="starter-template">
		<h1>회원 가입 처리 페이지</h1><br>

	</div>


</div><!-- /.container -->


<%@include file="/partials/script.jsp" %>

</body>
</html>
