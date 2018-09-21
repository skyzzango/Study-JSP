<%@ page import="board.BoardDTO" %>
<%@ page import="board.BoardDAO" %>
<%@ page import="java.io.PrintWriter" %>
<%--
  Created by IntelliJ IDEA.
  User: skyzz
  Date: 2018-09-21
  Time: 오전 12:36
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<% request.setCharacterEncoding("UTF-8"); %>

<%
	PrintWriter script = response.getWriter();
	String userId = null;
	if (session.getAttribute("userId") != null) {
		userId = (String) session.getAttribute("userId");
	}
	if (userId == null) {
		script.println("<script>alert('로그인 후 사용 가능합니다.')</script>");
		script.println("<script>location.href = 'login.jsp'</script>");
	}
	int contentNum = 0;
	if (request.getParameter("contentNum") != null) {
		contentNum = Integer.parseInt(request.getParameter("contentNum"));
	}
	if (contentNum == 0) {
		script.println("<script>alert('유효하지 않는 게시물입니다')</script>");
		script.println("<script>location.href = 'boardDTO.jsp'</script>");
	}
	BoardDTO boardDTO = BoardDAO.getInstance().getContent(contentNum);
	if (request.getParameter("contentTitle") == null || request.getParameter("contentDetail") == null || request.getParameter("contentTitle").equals("") || request.getParameter("contentDetail").equals("")) {
		script.println("<script>alert('입력이 안 된 부분이 있습니다')</script>");
		script.println("<script>history.back()</script>");
	} else {
		BoardDAO boardDao = BoardDAO.getInstance();
		int result = boardDao.contentUpdate(contentNum, request.getParameter("contentTitle"), request.getParameter("contentDetail"));
		if (result == -1) {
			script.println("<script>alert('글 수정에 실패하였습니다')</script>");
			script.println("<script>history.back()</script>");
		} else {
			script.println("<script>location.href = '/board/boardView.jsp?contentNum=" + contentNum + "'</script>");
		}
	}
%>

<html lang="ko">
<head>
	<%@include file="/partials/head.jsp" %>
	<title>Board Update Proc</title>
</head>

<body>

<%@include file="/partials/nav.jsp" %>


<div class="container">

	<div class="starter-template">
		<h1>게시판 글 수정 처리 페이지</h1>

	</div>

</div><!-- /.container -->


<%@include file="/partials/script.jsp" %>

</body>
</html>