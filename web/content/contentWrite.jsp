<%--
  Created by IntelliJ IDEA.
  User: skyzz
  Date: 2018-09-21
  Time: 오후 5:19
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@include file="/partials/loginCheck.jsp"%>
<html lang="ko">
<head>
	<%@include file="/partials/head.jsp" %>
	<title>Content Write Form Page</title>
</head>

<body>

<%@include file="/partials/nav.jsp" %>


<div class="container">

	<div class="starter-template">
		<h1>게시물 쓰기 페이지</h1><br>
		<%@include file="nav.jsp" %>

		<div class="container-fluid">
			<div class="row">
				<div class="col-lg-3"></div>
				<div class="col-lg-6 mt-5">
					<div class="panel-group">
						<div class="panel panel-default">
							<div class="panel-body">
								<form role="form" method="post" action="./contentWriteAction.jsp" enctype="multipart/form-data">
									<div class="form-group">
										<label for="title">제목:</label>
										<input type="text" class="form-control" name="title" id="title">
									</div>

									<div class="form-group">
										<label for="comment">내용:</label>
										<textarea class="form-control" rows="5" name="comment" id="comment"></textarea>
									</div>

									<%--이미지 불러와서 미리보기--%>
									<div id="imagePreview"></div><br>
									<input id="image" type="file" name="file" onchange="inputImage();">

									<div class="form-group">
										<label>이미지 파일(.jpg .gif .png)</label>
									</div>

									<div class="form-group mt-5">
										<button type="submit" class="btn btn-primary mr-3">글쓰기</button>
										<button type="submit" class="btn btn-primary mr-3">지우기</button>
									</div>
								</form>
							</div>
						</div>
					</div>
				</div>
				<div class="col-lg-3"></div>
			</div>
		</div>

	</div>


</div><!-- /.container -->


<%@include file="/partials/script.jsp" %>

<script type="text/javascript">
	const inputImage = (function loadImageFile() {
		if (window.FileReader) {
			let imagePre;
			let imageReader = new window.FileReader();
			let fileType = /^(?:image\/bmp|image\/gif|image\/jpeg|image\/png|image\/x\-xwindowdump|image\/x\-portable\-bitmap)$/i;

			imageReader.onload = function (Event) {
				if (!imagePre) {
					let newPreview = document.getElementById("imagePreview");
					imagePre = new Image();
					imagePre.style.width = "200px";
					imagePre.style.height = "140px";
					newPreview.appendChild(imagePre);
				}
				imagePre.src = Event.target.result;
			};
			return function () {
				const img = document.getElementById("image").files;
				if (!fileType.test(img[0].type)) {
					alert("이미지 파일을 업로드 하세요.");
					return;
				}
				imageReader.readAsDataURL(img[0]);
			}
		}
		document.getElementById("imagePreview").src = document.getElementById("image").value;
	})();
</script>
</body>
</html>
