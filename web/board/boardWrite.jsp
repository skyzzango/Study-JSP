<%@ page import="java.io.PrintWriter" %><%--
  Created by IntelliJ IDEA.
  User: skyzz
  Date: 2018-09-20
  Time: 오후 7:00
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>

<%
	PrintWriter script = response.getWriter();
	if (session.getAttribute("userId") == null) {
		script.println("<script>alert('로그인 후 사용 가능합니다.')</script>");
		script.println("<script>history.back()</script>");
	}
%>
<html lang="ko">
<head>
	<%@include file="/partials/head.jsp" %>
	<title>Board Write</title>
</head>

<body>

<%@include file="/partials/nav.jsp" %>


<div class="container">

	<div class="starter-template">
		<h1>게시판 글쓰기 페이지</h1><br>
		<form method="post" action="boardWriteProc.jsp">
			<table class="table table-hover">
				<tbody>
				<tr>
					<td>
						<input type="text" class="form-control" placeholder="글 제목" name="contentTitle" maxlength="40">
					</td>
				</tr>
				<tr>
					<td>
						<textarea type="text" class="form-control" placeholder="글 내용을 작성하세요" name="contentDetail"
						          maxlength="1024" style="height: 400px;"></textarea></td>
				</tr>
				</tbody>
			</table>
			<input type="submit" class="btn btn-primary pull-right" value="글쓰기">
		</form>
	</div>


</div><!-- /.container -->


<%@include file="/partials/script.jsp" %>

</body>
</html>
