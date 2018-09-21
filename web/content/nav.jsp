<%--
  Created by IntelliJ IDEA.
  User: skyzz
  Date: 2018-09-21
  Time: 오후 6:31
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<nav class="navbar navbar-default bg-primary navbar-fixed-top">
	<div class="container-fluid">
		<div class="navbar-header">
			<a class="navbar-brand text-white" href="index.jsp">게시판</a>
		</div>

		<ul class="nav justify-content-center">
			<li class="nav-item"><a class="nav-link text-white" href="#">대세글</a></li>
			<li class="nav-item"><a class="nav-link text-white" href="#">최신글</a></li>
			<li class="nav-item"><a class="nav-link text-white" href="#">인기글</a></li>
		</ul>

		<ul class="nav justify-content-end">
			<li class="nav-item"><a class="nav-link text-white" href="./contentWrite.jsp">글쓰기</a></li>
			<li class="nav-item"><a class="nav-link text-white disabled" href="#">로그인+회원가입</a></li>
		</ul>
	</div>
</nav>