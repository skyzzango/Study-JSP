<%--
  Created by IntelliJ IDEA.
  User: skyzz
  Date: 2018-09-20
  Time: 오후 6:20
  To change this template use File | Settings | File Templates.
--%>

<span onclick="document.getElementById('id02').style.display='none'" class="close" title="Close Modal">&times;</span>
<form class="modal-content" method="post"
      action="${pageContext.request.contextPath}/user/registerProc.jsp">
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

		<label for="UpUserName"><b>Name</b></label>
		<input type="text" placeholder="Enter Name" id="UpUserName" name="userName" required>

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