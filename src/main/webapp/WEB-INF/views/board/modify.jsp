<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<!DOCTYPE html>
<html lang="kr">
<head>
<meta charset="utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no" />
<meta name="description" content="" />
<meta name="author" content="" />
<title>게시판 수정</title>

	<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>
	<link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">

	<link href="https://cdn.jsdelivr.net/npm/simple-datatables@latest/dist/style.css" rel="stylesheet" />
	<link rel="stylesheet" type="text/css" href='<c:url value="/resources/css/styles.css"/>'>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/js/all.min.js"></script>
	<script src="/resources/ckeditor/ckeditor.js"></script>
	
</head>
<body>

	<div id="header">
		<jsp:include page="include/header.jsp"></jsp:include>
	</div>

	<div class="jumbotron text-center" style="margin-bottom: 0">
		<h1>게시판</h1>
		<p>수정</p>
	</div>

	<br>
	<br>

	<div id="layoutSidenav_content">
		<main>
			<div class="container">
				<div style="height: 100vh">

					<form role="form" method="post" autocomplete="off"
						enctype="multipart/form-data">

						<div id="root">
						
							<input type="hidden" name="bno" value="${view.bno}" /> <br>
							<table class="table">
								<tr>
									<td>제목</td>
								 	<td><input type="text" class="form-control" name="title" value="${view.title}" /></td>
								</tr>
								
								<tr>
									<td width="100">작성자</td> 
									<td><input type="text" readonly="readonly" class="form-control" name="userId" value="${view.userId}" /></td>
								</tr>
								
								<tr>
									<td width="100">내용</td>
									<td><textarea class="form-control" rows="13" name="content">${view.content}</textarea></td>
								</tr>
								
								<script>
										CKEDITOR.replace('content');
								</script>


								<tr>
								<c:if test="${write eq null}">
									<td>첨부파일</td>
									<td>	<input type="file" class="form-control" id="gdsImg" name="file" /> </td>
									<td>	<input type="hidden" class="img-fluid" name="gdsImg" value="${view.gdsImg}" /> </td>
								</c:if>
								</tr>

								<c:if test="${write ne null}">
									<button type="button" onClick="cameraTakePicture()">
										<i class="fa fa-camera" aria-hidden="true"></i>
									</button>
									<button type="button" onClick="getPhoto()">
										<i class="fa fa-folder" aria-hidden="true"></i>
									</button>
									<input type="hidden" id="file" name="file">
									<input type="hidden" class="img-fluid" name="gdsImg" value="${view.gdsImg}" />
								</c:if>

								<!-- 이미지가 있을때 -->
								<c:if test="${view.gdsImg ne null && view.gdsImg ne ''}">
								<tr>
									<td></td>
									<td>
								
										<div class="select_img">
										<img class="img-fluid" id="myImage" src='<c:url value="/resources/imgUpload/${view.gdsImg}"/>' />
										</div>
									</td>
									</tr>
								</c:if>
								
								<c:if test="${view.gdsImg eq null && view.gdsImg eq ''}">
								<tr>
									<td></td>
									<td>
										<div class="select_img">
										<img class="img-fluid" id="myImage" src='<c:url value="/resources/imgUpload/white.png"/>' />
										</div>
									</td>
								</tr>
								</c:if>
									
								<script>
 								 	$("#gdsImg").change(function(){
   										if(this.files && this.files[0]) {
    										var reader = new FileReader;
    										reader.onload = function(data) {
     											$(".select_img img").attr("src", data.target.result);       
    										}
    										reader.readAsDataURL(this.files[0]);
   										}
  									});
								</script>
							
							</table>


							<br>
							<button class="btn btn-secondary btn float-right" type="submit"
								onclick="test()">수정</button>
							<script>
								function test() {
									if (!confirm("수정하시겠습니까?")) {
										alert("취소를 누르셨습니다.");
									} else {
										alert("수정이 완료되었습니다.");
									}
								}

								$(document).ready(function() {
						        	document.addEventListener('deviceready', onDeviceReady, false);
						
						            function onDeviceReady() {
						
						         	}
						         
						         var ua = window.navigator.userAgent.toLowerCase();
						         	console.log(ua);
						         if (ua.indexOf('cordova') > 0) {
						            var s = document.createElement("script");
						            s.type = "text/javascript";
						            s.src = "<c:url value='/resources/js/mobile/cordova/cordova.js'/>";
						            $("head").append(s);
						         }
						        });
			      
								 function cameraTakePicture() { 
								 	navigator.camera.getPicture(onSuccess, onFail, {  
										quality: 100, 
									    destinationType: Camera.DestinationType.DATA_URL 
							     });  
				   
							     function onSuccess(imageData) { 
							     	var image = document.getElementById('myImage'); 
							     	document.getElementById('file').value = imageData;
							     	image.src = "data:image/jpeg;base64," + imageData; 
							   	 }  
							   
							  	 function onFail(message) { 
							     	alert('Failed because: ' + message); 
							     } 
							}
			 
								 function getPhoto() {
							     	navigator.camera.getPicture(onSuccess, onFail, {  
								    	quality: 100, 
										destinationType: Camera.DestinationType.DATA_URL, 
								        sourceType: Camera.PictureSourceType.PHOTOLIBRARY 
									   
							     });  
				 
				 
								 function onSuccess(imageData) { 
									var image = document.getElementById('myImage');
										document.getElementById('file').value = imageData;
										image.src = "data:image/jpeg;base64," + imageData;
								 }

								 function onFail(message) {
								 	alert('Failed because: ' + message);
								 }
								 }
							</script>
						</div>
					<br><br><br><br></form>
				</div>
			</div>
		</main>
	</div>

	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.1/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
	<script src='<c:url value="/resources/js/scripts.js"/>'> </script>

</body>
</html>