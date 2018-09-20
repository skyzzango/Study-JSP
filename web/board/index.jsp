<%@ page import="board.Content" %>
<%@ page import="board.ContentDAO" %>
<%@ page import="java.util.List" %><%--
  Created by IntelliJ IDEA.
  User: skyzz
  Date: 2018-09-20
  Time: 오후 6:45
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<% request.setCharacterEncoding("UTF-8"); %>

<%
	String userId = null;
	if (session.getAttribute("userId") != null) {
		userId = (String) session.getAttribute("userId");
	}
	int pageNumber = 1;
	if (request.getParameter("pageNumber") != null) {
		pageNumber = Integer.parseInt(request.getParameter("pageNumber"));
	}
	ContentDAO contentDAO = ContentDAO.getInstance();
	List<Content> list = contentDAO.getList(pageNumber);
%>

<html lang="ko">
<head>
	<%@include file="/partials/head.jsp" %>
	<title>Board Page</title>
</head>

<body>

<%@include file="/partials/nav.jsp" %>


<div class="container">

	<div class="starter-template">
		<h1>게시판 메인 페이지</h1><br>
		<table class="table table-hover">
			<thead>
			<tr>
				<th>번호</th>
				<th>제목</th>
				<th>글쓴이</th>
				<th>작성일</th>
			</tr>
			</thead>
			<tbody>
			<% for (Content content : list) { %>
			<tr>
				<td><%=content.getContentNum()%>
				</td>
				<td>
					<a href="${pageContext.request.contextPath}/board/boardView.jsp?contentNum=<%=content.getContentNum()%>">
						<%=content.getContentTitle()%>
					</a>
				</td>
				<td><%=content.getContentUser()%>
				</td>
				<td><%=
				content.getContentDate().substring(0, 11) +
						content.getContentDate().substring(11, 13) + "시 " +
						content.getContentDate().substring(14, 16) + "분"
				%>
				</td>
			</tr>
			<% } %>
			</tbody>
		</table>
		<% if (pageNumber != 1) { %>
		<a href="${pageContext.request.contextPath}/board/?pageNumber=<%=pageNumber - 1%>"
		   class="btn btn-success btn-arraw-left">이전</a>
		<% } else { %>
		<a href="${pageContext.request.contextPath}/board/?pageNumber=<%=pageNumber - 1%>"
		   class="btn btn-success btn-arraw-left disabled">이전</a>
		<% } %>

		<% if (contentDAO.nextPage(pageNumber + 1)) { %>
		<a href="${pageContext.request.contextPath}/board/?pageNumber=<%=pageNumber + 1%>"
		   class="btn btn-success btn-arraw-left">다음</a>
		<% } else { %>
		<a href="${pageContext.request.contextPath}/board/?pageNumber=<%=pageNumber + 1%>"
		   class="btn btn-success btn-arraw-left disabled">다음</a>
		<% } %>
		<a href="${pageContext.request.contextPath}/board/boardWrite.jsp" class="btn btn-primary pull-right">글쓰기</a>
	</div>


</div><!-- /.container -->


<%@include file="/partials/script.jsp" %>

</body>
</html>
