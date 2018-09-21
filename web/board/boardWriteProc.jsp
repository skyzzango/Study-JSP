<%@ page import="board.BoardDAO" %>
<%@ page import="java.io.PrintWriter" %>
<%--
  Created by IntelliJ IDEA.
  User: skyzz
  Date: 2018-09-20
  Time: 오후 7:22
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<% request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="boardDTO" class="board.BoardDTO" scope="page"/>
<jsp:setProperty name="boardDTO" property="contentTitle"/>
<jsp:setProperty name="boardDTO" property="contentDetail"/>

<%
	String userId = null;
	if (session.getAttribute("userId") != null) {
		userId = (String) session.getAttribute("userId");
	}

	PrintWriter script = response.getWriter();
	if (boardDTO.getContentTitle() == null || boardDTO.getContentDetail() == null) {
		script.println("<script>alert('입력이 안된 부분이 있습니다')</script>");
		script.println("<script>history.back()</script>");
	} else {
		BoardDAO boardDAO = BoardDAO.getInstance();
		int result = boardDAO.write(boardDTO.getContentTitle(), userId, boardDTO.getContentDetail());
		if (result == -1) {
			script.println("<script>alert('글쓰기에 실패하였습니다')</script>");
			script.println("<script>history.back()</script>");
		} else {
			script.println("<script>location.href = '/board/'</script>");
		}
	}
%>


<html lang="ko">
<head>
	<%@include file="/partials/head.jsp" %>
	<title>Board Write Proc</title>
</head>

<body>

<%@include file="/partials/nav.jsp" %>


<div class="container">

	<div class="starter-template">
		<h1>게시판 글쓰기 처리 페이지</h1><br>

	</div>


</div><!-- /.container -->


<%@include file="/partials/script.jsp" %>

</body>
</html>
