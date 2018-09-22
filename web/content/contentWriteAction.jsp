<%@ page import="com.oreilly.servlet.MultipartRequest" %>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>
<%@ page import="content.ContentDAO" %>
<%@ page import="content.ContentDTO" %>
<%@ page import="user.UserDAO" %><%--
  Created by IntelliJ IDEA.
  User: skyzz
  Date: 2018-09-21
  Time: 오후 5:47
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>

<%
	request.setCharacterEncoding("UTF-8");
	ContentDTO content = new ContentDTO();

	content.setWriteId((String) session.getAttribute("userId"));
	content.setPicture(UserDAO.getInstance().getUserPicture((String) session.getAttribute("userId")));

	// 폴더 경로 설정
	String uploadDir = this.getClass().getResource("").getPath();
	uploadDir = uploadDir.substring(1, uploadDir.indexOf(".IntelliJIdea2018.2")) + "IdeaProjects/Study-JSP/web/uploadImage";
	System.out.println("절대 경로: " + uploadDir);

	// 총 100M 까지 저장 가능하게 함
	int maxSize = 1024 * 1024 * 100;
	String encoding = "UTF-8";

	// 사용자가 전송한 파일 정보 토대로 업로드 경로에 크기 및 파일 업로드 수행할 수 있게
	MultipartRequest multipartRequest = new MultipartRequest(request, uploadDir, maxSize, encoding, new DefaultFileRenamePolicy());

	// 이전 클래스 name = "file" 실제 사용자가 저장한 실제 네임
	content.setFileName(multipartRequest.getOriginalFileName("file"));
	// 실제 서버에 업로드 된 파일시스템 네임
	content.setFileRealName(multipartRequest.getFilesystemName("file"));

	// enctype = "multipart/form-data" 에서 request.getParameter null 문제
	// request.getParameter 대신에 multi 객체 .getParameter 로 받아야 null 이 안뜬다.
	// 제목과 내용 입력이 되었다면 변수로 데이터값을 넣어줌
	if (multipartRequest.getParameter("title") != null) {
		content.setTitle(multipartRequest.getParameter("title"));
	}
	if (multipartRequest.getParameter("comment") != null) {
		content.setContent(multipartRequest.getParameter("comment"));
	}
	content.setCoinAmount(4);
	content.setLikeAmount(5);
	content.setCommentAmount(6);
	content.setReportAmount(7);

	// 디비에 업로드 메소드
	int result = ContentDAO.getInstance().writeContent(content);
	if (result == 1) {
		response.getWriter().println("<script>alert('글 등록 완료')</script>");
		response.getWriter().println("<script>location.href='./'</script>");
	} else {
		response.getWriter().println("<script>alert('글 등록 실패')</script>");
		response.getWriter().println("<script>location.href='./'</script>");
	}
%>

<html lang="ko">
<head>
	<%@include file="/partials/head.jsp" %>
	<title>Content Write Proc Page</title>
</head>

<body>

<%@include file="/partials/nav.jsp" %>


<div class="container">

	<div class="starter-template">
		<h1>게시물 쓰기 처리 페이지</h1><br>

	</div>


</div><!-- /.container -->


<%@include file="/partials/script.jsp" %>

</body>
</html>
