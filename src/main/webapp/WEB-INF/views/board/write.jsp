<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>  
<%@ taglib uri = "http://java.sun.com/jsp/jstl/functions" prefix = "fn" %>

<!DOCTYPE html>
<html lang="kr">
    <head>
        <meta charset="utf-8" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge" />
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
        <meta name="description" content="" />
        <meta name="author" content="" />
        <title>게시판 작성</title>

		<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
		<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>
		<link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">

        <link href="https://cdn.jsdelivr.net/npm/simple-datatables@latest/dist/style.css" rel="stylesheet" />
		<link rel="stylesheet" type="text/css" href='<c:url value="/resources/css/styles.css"/>'>
		<script src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/js/all.min.js"></script>
		<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
		<script src="/resources/ckeditor/ckeditor.js"></script>
		
    </head>
    <body>
    
	<div id="header">
		<jsp:include page="include/header.jsp"></jsp:include>
	</div>
	
	<div class="jumbotron text-center" style="margin-bottom:0">
 		 <h1>게시판</h1>
 		 <p>등록</p>
	</div>

<br><br>

	<div id="layoutSidenav_content">
		<main>
			<div class="container">
				<div style="height: 100vh">

					<c:if test="${member == null }">
						<script>
        alert("로그인 후 이용해 주세요.");
     	window.location.href = "/board/listPageSearch?num=1";
 	</script>
					</c:if>

					<c:if test="${member != null}">
						<form role="form" method="post" autocomplete="off"
							enctype="multipart/form-data">

							<table class="table">
								<tr>
									<td>제목</td>
									<td><input type="text" class="form-control" name="title" /></td>
								</tr>
								
								<tr>
									<td width="100">작성자</td>
									<td><input type="text" class="form-control"
										name="writer" readonly="readonly"
										value="${sessionScope.member.getUserId()}" /></td>
								</tr>
								
								<tr>
									<td width="100">내용</td>
									<td><textarea class="form-control" rows="13" id="content" name="content"></textarea></td>
									<script>
									 var ckeditor_config = {
									   resize_enaleb : false,
									   enterMode : CKEDITOR.ENTER_BR,
									   shiftEnterMode : CKEDITOR.ENTER_P,
									   filebrowserUploadUrl : "/board/ckUpload"
									 };
									 
									 CKEDITOR.replace("content", ckeditor_config);
									</script>
								</tr>


								<tr>
									<c:if test="${write eq null}">
										<td>첨부파일</td>
										<td><input class="form-control" class="img-fluid"
											type="file" id="gdsImg" name="file" /></td>
									</c:if>
								</tr>



								<c:if test="${write ne null}">
										<button type="button" onClick="cameraTakePicture()">
											<i class="fa fa-camera" aria-hidden="true"></i>
										</button>
										<button type="button" onClick="getPhoto()">
											<i class="fa fa-folder" aria-hidden="true"></i>
										</button>
									</c:if>

								<tr>
								<td></td>
								<td>
									<div class="select_img">
										<img class="img-fluid" id="myImage"></img>
									</div>
								</td>
								</tr>
								</table>	

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

									
									
									
							<input type="hidden" id="file" name="file"> <br> <br>
							<div class="inputArea">
								<button class="btn btn-secondary btn float-right"
									onclick="test()">등록</button>
								<script>
									function test() {
										if (!confirm("등록하시겠습니까?")) {
											alert("취소를 누르셨습니다.");
										} else {
											alert("등록이 완료되었습니다.");
										}
									}
								</script>
							</div>
						</form>
					</c:if>
					<script>
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
			</div>
		</main>
	</div>

	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.1/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
         <script src='<c:url value="/resources/js/scripts.js"/>'> </script>

</body>
</html>
