<%@ page import="board.ContentDAO" %>
<%@ page import="java.io.PrintWriter" %><%--
  Created by IntelliJ IDEA.
  User: skyzz
  Date: 2018-09-21
  Time: 오전 1:08
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<% request.setCharacterEncoding("UTF-8"); %>

<%
	// 세션을 통해 글쓴 아이디 찾아옴
	PrintWriter script = response.getWriter();
	String userId = null;

	if (session.getAttribute("userId") != null) {
		userId = (String) session.getAttribute("userId");
	}

	if (userId == null) {
		script.println("<script>alert('로그인 후 사용 가능합니다.')</script>");
		script.println("<script>location.href = '/board/'</script>");
	}

	int contentNum = 0;
	if (request.getParameter("contentNum") != null) {
		contentNum = Integer.parseInt(request.getParameter("contentNum"));
	}

	if (contentNum == 0) {
		script.println("<script>alert('유효하지 않는 게시물입니다')</script>");
		script.println("<script>location.href = '/board/'</script>");
	}

	ContentDAO contentDAO = ContentDAO.getInstance();
	int result = contentDAO.contentDelete(contentNum);
	if (result == -1) {
		script.println("<script>alert('글 삭제에 실패하였습니다')</script>");
		script.println("<script>history.back()</script>");
	} else {
		script.println("<script>location.href = '/board/'</script>");
	}
%>
<html lang="ko">
<head>
	<%@include file="/partials/head.jsp" %>
	<title>Board Delete Page</title>
</head>

<body>

<%@include file="/partials/nav.jsp" %>


<div class="container">

	<div class="starter-template">
		<h1>게시판 글 삭제 페이지</h1>

	</div>

</div><!-- /.container -->


<%@include file="/partials/script.jsp" %>

</body>
</html>