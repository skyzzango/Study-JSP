<%@ page import="content.ContentDAO" %>
<%--
  Created by IntelliJ IDEA.
  User: skyzz
  Date: 2018-09-27
  Time: 오후 8:00
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@include file="/partials/loginCheck.jsp" %>

<%
	if (request.getParameter("contentNum") == null) {
		script.println("<script>alert('정상적인 접근이 아닙니다.')</script>");
		script.println("<script>history.back()</script>");
	}

	int result = ContentDAO.getInstance().deleteContent((String) request.getAttribute("contentNum"));

	script.println("<script>");
	switch (result) {
		case 1:
			script.println("alert('삭제가 완료 되었습니다')");
			script.println("location.href='index.jsp'");
			break;

		default:
			script.println("alert('오류! 삭제 실패!')");
			script.println("history.back()");
	}
	script.println("</script>");
	script.close();
%>

<html lang="ko">
<head>
	<%@include file="/partials/head.jsp" %>
	<title>Content Delete Proc Page</title>
</head>

<body>

<%@include file="/partials/nav.jsp" %>


<div class="container">

	<div class="starter-template">
		<h1>게시물 삭제 처리 페이지</h1><br>

	</div>


</div><!-- /.container -->


<%@include file="/partials/script.jsp" %>

</body>
</html>
