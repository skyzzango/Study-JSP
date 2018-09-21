<%@ page import="board.BoardDTO" %>
<%@ page import="board.BoardDAO" %>
<%@ page import="java.io.PrintWriter" %><%--
  Created by IntelliJ IDEA.
  User: skyzz
  Date: 2018-09-21
  Time: 오전 12:17
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
	BoardDTO boardDTO = BoardDAO.getInstance().getContent(contentNum);
%>

<html lang="ko">
<head>
	<%@include file="/partials/head.jsp" %>
	<title>Board Update Page</title>
</head>

<body>

<%@include file="/partials/nav.jsp" %>


<div class="container">

	<div class="starter-template">
		<h1>게시판 글 수정 페이지</h1>
		<form method="post" action="boardUpdateProc.jsp?contentNum=<%=contentNum%>">
			<table class="table table-hover">
				<tbody>
				<tr>
					<%--자신의 글을 수정하려면 이전의 값을 보여줘야하기 때문에 value 에 이전 값을 출력해준다.--%>
					<td>
						<input type="text" class="form-control" placeholder="글 제목" name="contentTitle" maxlength="40"
						       value="<%=boardDTO.getContentTitle()%>">
					</td>
				</tr>
				<tr>
					<td>
						<textarea class="form-control" placeholder="글 내용을 작성하세요" name="contentDetail"
						          maxlength="1024" style="height: 400px;">
						<%=boardDTO.getContentDetail()%>
					</textarea>
					</td>
				</tr>
				</tbody>
			</table>
			<input type="submit" class="btn btn-primary pull-right" value="글 수정">
		</form>
	</div>

</div><!-- /.container -->


<%@include file="/partials/script.jsp" %>

</body>
</html>