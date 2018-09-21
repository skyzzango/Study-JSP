<%@ page import="board.BoardDTO" %>
<%@ page import="board.BoardDAO" %>
<%@ page import="java.io.PrintWriter" %>
<%--
  Created by IntelliJ IDEA.
  User: skyzz
  Date: 2018-09-20
  Time: 오후 10:31
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<% request.setCharacterEncoding("UTF-8"); %>

<%
	String userId = null;
	if (session.getAttribute("userId") != null) {
		userId = (String) session.getAttribute("userId");
	}
	int contentNum = 0;
	if (request.getParameter("contentNum") != null) {
		contentNum = Integer.parseInt(request.getParameter("contentNum"));
	}
	if (contentNum == 0) {
		PrintWriter script = response.getWriter();
		script.println("<script>alert('유효하지 않는 게시물입니다')</script>");
		script.println("<script>location.href = '/board/'</script>");
	}
	BoardDTO boardDTO = BoardDAO.getInstance().getContent(contentNum);
%>

<html lang="ko">
<head>
	<%@include file="/partials/head.jsp" %>
	<title>Board View Page</title>
</head>

<body>

<%@include file="/partials/nav.jsp" %>


<div class="container">

	<div class="starter-template">
		<h1>게시판 글 보기 페이지</h1><br>
		<table class="table table-hover">
			<tbody>
				<tr>
					<td>글 제목</td>
					<!-- 글 제목 악성 스크립트 공격 막기 위해서 -->
					<td><%= boardDTO.getContentTitle().replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\n", "<br>") %></td>
				</tr>
				<tr>
					<td>작성자</td>
					<td><%= boardDTO.getContentUser() %></td>
				</tr>
				<tr>
					<td>작성일자</td>
					<td><%= boardDTO.getContentDate().substring(0, 11) + boardDTO.getContentDate().substring(11, 13) + "시 " + boardDTO.getContentDate().substring(14, 16) + "분 " %></td>
				</tr>
				<tr>
					<td style="height: 400px">글 내용</td>
					<!-- 출력 시 공백이나 < > 줄바꿈 우리 눈에 보여주기 하기 위해서(html 태그로 인식해서 안되기 때매) -->
					<td><%= boardDTO.getContentDetail().replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\n", "<br>") %></td>
				</tr>
			</tbody>
		</table>

		<!-- 목록으로 돌아가기와 작성자이면 수정할 수 있게 하기 -->
		<a href = "${pageContext.request.contextPath}/board/" class="btn btn-primary">목록</a>
		<% if (userId != null && userId.equals(boardDTO.getContentUser())) { %>
		<a href="${pageContext.request.contextPath}/board/boardUpdate.jsp?contentNum=<%=contentNum %>" class="btn btn-info">수정</a>
		<a onclick="return confirm('정말로 삭제 하시겠습니까?')" href="boardDeleteProc.jsp?contentNum=<%=contentNum %>" class="btn btn-danger">삭제</a>
		<% } %>
	</div>


</div><!-- /.container -->


<%@include file="/partials/script.jsp" %>

</body>
</html>
