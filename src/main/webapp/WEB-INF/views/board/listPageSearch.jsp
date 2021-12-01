<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/functions" prefix = "fn" %>
<jsp:useBean id="now" class="java.util.Date"/>

<!DOCTYPE html>
<html lang="kr">
	<head>
		<meta charset="utf-8" />
		<meta http-equiv="X-UA-Compatible" content="IE=edge" />
		<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
		<meta name="description" content="" />
		<meta name="author" content="" />
		<title>게시판</title>

		<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
		<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>
		<link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">

		<link href="https://cdn.jsdelivr.net/npm/simple-datatables@latest/dist/style.css" rel="stylesheet" />
		<link rel="stylesheet" type="text/css" href='<c:url value="/resources/css/styles.css"/>'>
		<script src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/js/all.min.js"></script>
		
		<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script> 
		<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.22.2/moment.min.js"></script>
		<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/tempusdominus-bootstrap-4/5.0.1/js/tempusdominus-bootstrap-4.min.js"></script>
		<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/tempusdominus-bootstrap-4/5.0.1/css/tempusdominus-bootstrap-4.min.css" />
		<link rel="stylesheet" href="https://netdna.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.css" />
		<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
		
	</head>
	<body>

	<div id="header">
		<jsp:include page="include/header.jsp"></jsp:include>
	</div>
	
	<div class="jumbotron text-center" style="margin-bottom:0">
 		 <h1>게시판</h1>
 		 <p>목록</p> 
	</div>	
			
	<br><br>		
	<div class="container">
	<div class="row">
		<div class="d-flex">
		<div class="ml-auto">
			<form class="form-inline">
				<div class="col-xs-4">
				
				<input type="search" placeholder="검색어를 입력하세요" name="keyword" value="${page.keyword}"> 
				</div>
				
				
				<div class="col-xs-4">
				
				
				<fmt:formatDate value="${now}" pattern="yyyy-MM-dd" var="today"/>
				<fmt:parseDate value="${page.regDate}" pattern="yyyy-MM-dd" var="regDate"/>
			
				<c:if test="${regDate ne null }">
				<input type="date" id="" name="regDate" value="${page.regDate}" >
				</c:if>
				
				<c:if test="${regDate eq null }">
				<input type="date" id="" name="regDate" value="${today}" >
				</c:if>
			
				</div>	
						<div class="col-xs-4">
				<button class="btn btn-secondary btn-sm" style="color:white" type="button" id="searchBtn">검색</button>
				</div>
			</form>
		</div>
		</div>
	</div>
	<script>
		document.getElementById("searchBtn").onclick = function() {
			let keyword = document.getElementsByName("keyword")[0].value;
			let regDate = document.getElementsByName("regDate")[0].value;
			
			location.href = "listPageSearch?num=1"+"&keyword=" + keyword + "&regDate=" + regDate;
		};

	</script>
	
		<div class="card mb-4">
			<!-- Table -->
			<table class="table text-center table-hover ">
				<tr>
					<th>NO.</th>
					<th>작성자</th>
					<th>제목</th>
					<th>작성일</th>
				<tbody>
					<c:forEach items="${list}" var="boardlist" varStatus="status">
						<tr style = "cursor:pointer;" onClick = " location.href='view?bno=${boardlist.bno}' ">
							<td>${(page.count - status.index) - ( (select - 1)  *  page.postNum ) }</td>
							<td>${boardlist.userId}</td>
							<td>${boardlist.title}</td>
							<td><fmt:formatDate value="${boardlist.regDate}" pattern="yyyy-MM-dd" /></td>
						</tr>
					</c:forEach>

				</tbody>
			</table>
				
				<div>
				<button class="btn btn-secondary btn-sm btn float-right" style="color:white; type="button" onclick="location.href='/board/write'">작성</button>
				</div>
				
					
				<div class="d-flex">
					<div class="mx-auto">
						
	
						<c:forEach begin="${page.startPageNum}" end="${page.endPageNum}" var="num">
							<c:if test="${select != num}">
							
								<button type="button" class="btn btn-secondary ml-1" onClick="location.href='listPageSearch?num=${num}&keyword=${page.keyword}&regDate=${page.regDate}'">${num}</button>
							</c:if>
							
							<c:if test="${select == num}">
								<button type="button" class="btn btn-secondary ml-1">${num}</button>
							</c:if>
						</c:forEach>
	
						
					</div>
				</div>
				<br>
				<br>

				</div>
			<br><br>
			
			</div>
			
	


	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.1/dist/js/bootstrap.bundle.min.js"></script>
	<script src='<c:url value="/resources/js/scripts.js"/>'> </script>
	<script src="https://cdn.jsdelivr.net/npm/simple-datatables@latest"></script>
	<script src='<c:url value="/resources/js/datatables-simple-demo.js"/>'> </script>
</body>
</html>
