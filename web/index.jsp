<%--
  Created by IntelliJ IDEA.
  User: skyzz
  Date: 2018-09-20
  Time: 오전 10:54
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<html lang="ko">
<head>
	<%@include file="/partials/head.jsp" %>
	<title>Main Page</title>
</head>

<body>

<%@include file="/partials/nav.jsp" %>


<div class="container">

	<div class="starter-template">
		<h1>메인 화면</h1>
		<br>
		<button onclick="document.getElementById('id01').style.display='block'" style="width:auto;">Login</button>
		<button onclick="document.getElementById('id02').style.display='block'" style="width:auto;">Sign Up</button>

		<div id="id01" class="modal">
			<form class="modal-content animate" method="post"
			      action="${pageContext.request.contextPath}/user/userProc.jsp">
				<div class="imgcontainer">
					<span onclick="document.getElementById('id01').style.display='none'" class="close"
					      title="Close Modal">&times;</span>
					<%--<img src="${pageContext.request.contextPath}/image/img_avatar2.png" alt="Avatar" class="avatar">--%>
				</div>

				<div class="container">
					<label for="InUserId"><b>Username</b></label>
					<input type="text" placeholder="Enter Username" id="InUserId" name="userId" required>

					<label for="InUserPw"><b>Password</b></label>
					<input type="password" placeholder="Enter Password" id="InUserPw" name="userPw" required>

					<button type="submit">Login</button>
					<label>
						<input type="checkbox" checked="checked" name="remember"> Remember me
					</label>
				</div>

				<div class="container" style="background-color:#f1f1f1">
					<button type="button" onclick="document.getElementById('id01').style.display='none'"
					        class="cancelbtn">Cancel
					</button>
					<span class="psw">Forgot <a href="#">password?</a></span>
				</div>
			</form>
		</div>

		<div id="id02" class="modal">
			<span onclick="document.getElementById('id02').style.display='none'" class="close" title="Close Modal">&times;</span>
			<form class="modal-content" action="#">
				<div class="container">
					<h1>Sign Up</h1>
					<p>Please fill in this form to create an account.</p>
					<hr>
					<label for="UpUserId"><b>Email</b></label>
					<input type="text" placeholder="Enter Email" id="UpUserId" name="userId" required>

					<label for="UpUserPw"><b>Password</b></label>
					<input type="password" placeholder="Enter Password" id="UpUserPw" name="userPw" required>

					<label for="UpUserPw-re"><b>Repeat Password</b></label>
					<input type="password" placeholder="Repeat Password" id="UpUserPw-re" name="userPw-repeat" required>

					<label>
						<input type="checkbox" checked="checked" name="remember" style="margin-bottom:15px"> Remember me
					</label>

					<p>By creating an account you agree to our <a href="#" style="color:dodgerblue">Terms & Privacy</a>.
					</p>

					<div class="clearfix">
						<button type="button" onclick="document.getElementById('id02').style.display='none'"
						        class="cancelbtn">Cancel
						</button>
						<button type="submit" class="signupbtn">Sign Up</button>
					</div>
				</div>
			</form>
		</div>

	</div>

</div><!-- /.container -->


<%@include file="/partials/script.jsp" %>

</body>
</html>