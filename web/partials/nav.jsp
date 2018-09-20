<%--
  Created by IntelliJ IDEA.
  User: skyzz
  Date: 2018-09-20
  Time: 오전 10:52
  To change this template use File | Settings | File Templates.
--%>
<nav class="navbar navbar-expand-md navbar-dark bg-dark fixed-top">
	<a class="navbar-brand" href="#">Navbar</a>
	<button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarsExampleDefault"
	        aria-controls="navbarsExampleDefault" aria-expanded="false" aria-label="Toggle navigation">
		<span class="navbar-toggler-icon"></span>
	</button>

	<div class="collapse navbar-collapse" id="navbarsExampleDefault">
		<ul class="navbar-nav mr-auto">
			<li class="nav-item active">
				<a class="nav-link" href="/">Home <span class="sr-only">(current)</span></a>
			</li>
			<li class="nav-item">
				<a class="nav-link disabled" href="#">Link</a>
			</li>
			<li class="nav-item">
				<a class="nav-link disabled" href="#">Disabled</a>
			</li>
			<li class="nav-item dropdown">
				<a class="nav-link dropdown-toggle disabled" href="http://example.com" id="dropdown01"
				   data-toggle="dropdown"
				   aria-haspopup="true" aria-expanded="false">Dropdown</a>
				<div class="dropdown-menu" aria-labelledby="dropdown01">
					<a class="dropdown-item" href="#">Action</a>
					<a class="dropdown-item" href="#">Another action</a>
					<a class="dropdown-item" href="#">Something else here</a>
				</div>
			</li>
		</ul>
		<div style="margin-right: 2rem">
			<% if (session.getAttribute("userId") == null) { %>
			<button onclick="document.getElementById('id01').style.display='block'" style="width:auto;">Sign In</button>
			<% } else { %>
			<button onclick="location.href='/user/logoutProc.jsp'" style="width:auto;">Sign Out</button>
			<% } %>
			<button onclick="document.getElementById('id02').style.display='block'" style="width:auto;">Sign Up</button>
		</div>
		<form class="form-inline my-2 my-lg-0">
			<input class="form-control mr-sm-2" type="text" placeholder="Search" aria-label="Search">
			<button class="btn btn-outline-success my-2 my-sm-0 disabled" type="submit">Search</button>
		</form>
	</div>
</nav>
<div id="id01" class="modal">
	<%@include file="/user/loginView.jsp" %>
</div>

<div id="id02" class="modal">
	<%@include file="/user/registerView.jsp" %>
</div>
