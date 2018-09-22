<%@ page import="content.ContentDTO" %>
<%@ page import="content.ContentDAO" %><%--
  Created by IntelliJ IDEA.
  User: skyzz
  Date: 2018-09-22
  Time: 오후 5:49
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@include file="/partials/loginCheck.jsp" %>

<%
	if (request.getParameter("title") == null) {
		script.println("<script>alert('정상적인 접근이 아닙니다.')</script>");
		script.println("<script>history.back()</script>");
	}
	ContentDTO content = ContentDAO.getInstance().getContent(request.getParameter("title"));
	System.out.println(content);
%>

<html lang="ko">
<head>
	<%@include file="/partials/head.jsp" %>
	<title>Content Detail View Page</title>
</head>

<body>

<%@include file="/partials/nav.jsp" %>


<div class="container">

	<div class="starter-template">
		<h1>게시물 내용 보기 페이지</h1>
		<div class="container-fluid">
			<div class="low">
				<div class="col-lg-4 mt-4"></div>

				<div class="col-lg-8 mt-4">
					<div class="row">
						<div class="col-lg-8">
							<%=content.getTitle()%>
						</div>
					</div>

					<div class="row">
						<div class="col-lg-8 mt-2">
							<img src="<%=content.getPicture()%>" class="img-circle" width="32px"
							     height="27px">
							&nbsp;<%=content.getWriteId()%>&nbsp;
							<small>
								<%=content.getWriteDate()%>
							</small>
						</div>
					</div>

					<div class="row">
						<div class="col-lg-8 mt-3">
							<img src="/uploadImage/<%=content.getFileRealName()%>" width="640px" height="360px">
						</div>
					</div>

					<div class="row">
						<div class="col-lg-8 mt-3">
							<%=content.getContent()%>
						</div>
					</div>

					<div class="row">
						<div class="col-lg-8 mt-3">
							금액<span style="color: red;"><%=content.getCoinAmount()%></span>
							추천<span style="color: red;"><%=content.getLikeAmount()%></span>
							댓글<span style="color: red;"><%=content.getCommentAmount()%></span>
							감사<span style="color: red;"><%=content.getReportAmount()%></span>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>

</div><!-- /.container -->


<%@include file="/partials/script.jsp" %>

</body>
</html>