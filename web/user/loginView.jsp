<%--
  Created by IntelliJ IDEA.
  User: skyzz
  Date: 2018-09-20
  Time: 오후 6:20
  To change this template use File | Settings | File Templates.
--%>

<form class="modal-content animate" method="post"
      action="${pageContext.request.contextPath}/user/loginProc.jsp">
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
