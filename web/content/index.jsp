<%@ page import="content.ContentDAO" %>
<%@ page import="content.ContentDTO" %>
<%@ page import="java.util.List" %><%--
  Created by IntelliJ IDEA.
  User: skyzz
  Date: 2018-09-21
  Time: 오후 6:12
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>

<%
	List<ContentDTO> contentList = ContentDAO.getInstance().getContentList();
%>

<html lang="ko">
<head>
	<%@include file="/partials/head.jsp" %>
	<title>Content List View Page</title>
</head>

<body>

<%@include file="/partials/nav.jsp" %>


<div class="container">

	<div class="starter-template">
		<h1>게시물 목록 보기 페이지</h1><br>
		<%@include file="nav.jsp" %>

		<% for (ContentDTO content : contentList) { %>
		<div class="row">
			<div class="col-lg-9">
				<div class="card bg-light mt-3">
					<div class="card-header bg-light">
						<div class="row">
							<div class="col-8 text-left">
								<img src="<%=content.getPicture()%>" class="img-circle" width="32px"
								     height="27px">&nbsp;<%=content.getWriteId()%>&nbsp;
								<small>
									<%=content.getWriteDate()%>
								</small>
							</div>
							<div class="col-4 text-right"></div>
						</div>
					</div>
					<div class="card-body">
						<div class="row">
							<div class="col-3">
								<img src="/uploadImage/<%=content.getFileRealName()%>" width="150px" height="100px">
							</div>
							<div class="col-9">
								<a class="card-title"
								   href="./contentDetailView.jsp?title=<%=content.getTitle()%>"><%=content.getTitle()%>
								</a>
								<p class="card-text">
									<%=content.getContent()%>
								</p>
								<div class="row">
									<div class="col-9 text-left">
										금액
										<span style="color: red;">
											<%=content.getCoinAmount()%>
										</span>
										추천
										<span style="color: red;">
											<%=content.getLikeAmount()%>
										</span>
										댓글
										<span style="color: red;">
											<%=content.getCommentAmount()%>
										</span>
										감사
										<span style="color: red;">
											<%=content.getReportAmount()%>
										</span>
									</div>
									<div class="col-3 text-right">
										<a onclick="return confirm('추천 하시겠습니까?')" href="./likeAction.jsp?evaluationId=">추천</a>
										<a onclick="return confirm('신고 하시겠습니까?')" href="./likeAction.jsp?evaluationId=">신고</a>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		<% } %>

	</div>


</div><!-- /.container -->


<%@include file="/partials/script.jsp" %>

</body>
</html>
