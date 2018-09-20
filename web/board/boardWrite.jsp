<%@ page import="com.oreilly.servlet.MultipartRequest" %>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="java.util.Enumeration" %><%--
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

<%--<%--%>
	<%--String path = request.getRealPath("fileFolder"); // 이클립스 서버쪽에 프로젝트의 해당폴더--%>
	<%--System.out.println(path); // path 를 출력해서 확인(fileFolder 없으면 생성해주자!!!)--%>

	<%--int size = 1024 * 1024 * 10; // 파일사이즈 최대 크기 10M--%>
	<%--String file = ""; // 중복때문에 뒤에 1,2,3,4 붙은 파일명--%>
	<%--String originFile = ""; // 내가 업로드한 실제 파일명--%>

	<%--try {--%>
		<%--// 업로드 파일 정보를 업로드 장소에 크기 및 파일 업로드 수행할 수 있게 함--%>
		<%--MultipartRequest multi = new MultipartRequest(request, path, size, "UTF-8", new DefaultFileRenamePolicy());--%>

		<%--Enumeration files = multi.getFileNames();--%>
		<%--String str = (String)files.nextElement();--%>

		<%--// 이 file 과 originFile 로 S3를 사용하든 DB를 사용하든 하면된다 !!!--%>
		<%--file = multi.getFilesystemName(str);--%>
		<%--originFile = multi.getOriginalFileName(str);--%>
	<%--} catch (Exception e){--%>
		<%--e.printStackTrace();--%>
	<%--}--%>
<%--%>--%>

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
		<form method="post" action="boardWriteProc.jsp" enctype="multipart/form-data">
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
				<tr>
					<td>
						<input type="file" class="form-control-file" name="contentFile" id="contentFile">
					</td>
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
