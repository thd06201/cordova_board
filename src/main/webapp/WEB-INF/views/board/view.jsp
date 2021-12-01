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
        <title>게시물</title>

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
	
	<div class="jumbotron text-center" style="margin-bottom:0">
 		 <h1>게시판</h1>
 		 <p>게시글</p>
	</div>
	
	<br><br>

	<div id="layoutSidenav_content">
		<main>
			<div class="container">
				<div style="height: 100vh">
					<div id="root">

						<form role="form" method="post" autocomplete="off">
							<input type="hidden" name="bno" value="${view.bno}" /> <br>
							<br>
							<table class="table">
								<tr>
									<td>제목</td>
									<td><input type="text" class="form-control"
										readonly="readonly" name="title" value="${view.title}" /></td>
								</tr>
								
								<tr>
									<td width="100">작성자</td>
									<td><input type="text" class="form-control"
										readonly="readonly" name="writer" value="${view.userId}" /></td>
								</tr>
								
								<tr>
									<td>내용</td>
									<td><textarea rows="13" name="content" class="form-control" readonly="readonly">${view.content}</textarea></td>
								</tr>

								<tr>
									<c:if test="${view.gdsImg ne '' && view.gdsImg ne null}">
									<td>첨부파일</td>
									<td><img class="img-fluid" readonly="readonly" src='<c:url value="/resources/imgUpload/${view.gdsImg}"/>' /></td>
									</c:if>
								</tr>


								<c:if test="${view.gdsImg eq '' && view.gdsImg eq null}">
								<div class="select_img">
									<img class="img-fluid" src='<c:url value="/resources/imgUpload/white.png"/>' />
								</div>
								
							</c:if>
								
							
							
							</table>
							
							<div class="d-grid gap-2 d-md-flex justify-content-md-end">
							<div style="float: left;">
								<c:if test="${sessionScope.member.userId eq view.userId}">
									<button class="btn btn-secondary me-md-2" type="button" id="modify_btn" onclick="testt()">수정</button>
									<script>
										function testt() {
											if (!confirm("수정하시겠습니까?")) {
												alert("취소를 누르셨습니다.");
											} else {
												location.href = 'modify?bno=${view.bno}';
											}
										}
									</script>

									<button class="btn btn-secondary" type="button" id="delete_btn" onclick="test()">삭제</button>
									<script>
										function test() {
											if (!confirm("삭제하시겠습니까?")) {
												alert("취소를 누르셨습니다.");
											} else {
												location.href = 'delete?bno=${view.bno}';
												alert("삭제가 완료되었습니다.");
											}
										}
									</script>
								</c:if>
							</div>
						  </div>
						<br><br></form>
					</div>
				</div>
			</div>
		</main>
	</div>


	

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.1/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
         <script src='<c:url value="/resources/js/scripts.js"/>'> </script>

</body>
</html>
