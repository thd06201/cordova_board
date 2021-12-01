
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/functions" prefix = "fn" %>

<!DOCTYPE html>
<html lang="kr">
<head>
<meta charset="utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no" />
<meta name="description" content="" />
<meta name="author" content="" />
<title>게시판</title>

<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>


<link href="https://cdn.jsdelivr.net/npm/simple-datatables@latest/dist/style.css"
rel="stylesheet" />
<link rel="stylesheet" type="text/css"
	href='<c:url value="/resources/css/styles.css"/>'>
<script src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/js/all.min.js"></script>
</head>
<body>

		<div id="layoutSidenav_content">
			 <main>
                    <div class="container-fluid px-4">
                    <div class="row">
                     <a class="dropdown-item" href="/member/signout" >Logout</a>
           		    </div>
           		    
                        <h1 class="mt-4">게시판</h1>
                        <ol class="breadcrumb mb-4">
                            <li class="breadcrumb-item bg-light"><a href="/board/listPageSearch?num=1">게시물 목록</a></li>
                            <li class="breadcrumb-item active bg-light">목록</li>
                        </ol><div style="height: 100vh">
	
	
					<div id ="root">
					
					<div class="card mb-4">
						<div class="card-header">
							<div align="right">
							<button class="btn btn-primary" type="button" onclick="location.href='/board/write'">글 작성</button>
                             </div>             
						</div>
						<div class="panel panel-default">
							

							<!-- Table -->
							<table class="table">
							<tr>
								<th>NO.</th>
								<th>작성자</th>
								<th>제목</th>
								<th>작성일</th>
								
								<tbody>
									<c:forEach items="${list}" var="boardlist" varStatus="status">
									<tr>
										<td>${fn:length(list) - status.index}</td>
										<td>${boardlist.userId}</td>
										<td><a href="view?bno=${boardlist.bno}">${boardlist.title}</a></td>
										<td><fmt:formatDate value="${boardlist.regDate}"
												pattern="yyyy-MM-dd" /></td>
									</tr>
									</c:forEach>

								</tbody>
							</table>
							
							<div class="btn-toolbar">
								<c:if test="${page.prev}">
 								[ <a href="listPageSearch?num=${page.startPageNum - 1}${page.searchTypeKeyword}">이전</a> ]
								</c:if>

								<c:forEach begin="${page.startPageNum}" end="${page.endPageNum}"
									var="num">
									<span> <c:if test="${select != num}">
											<a href="listPageSearch?num=${num}${page.searchTypeKeyword}">${num}</a>
										</c:if> <c:if test="${select == num}">
											<b>${num}</b>
										</c:if>

									</span>
								</c:forEach>

								<c:if test="${page.next}">
 [ <a
										href="listPageSearch?num=${page.endPageNum + 1}${page.searchTypeKeyword}">다음</a> ]
</c:if>
							</div>
						</div></div>
						<div class="dropdown">
							<select name="searchType">
								<option class="btn btn-default dropdown-toggle" value="title"
									<c:if test="${page.searchType eq 'title'}">selected</c:if>>제목</option>
								<option value="writer"
									<c:if test="${page.searchType eq 'writer'}">selected</c:if>>작성자</option>
							</select> <input type="search" name="keyword" value="${page.keyword}" />

							<button class="btn btn-primary" type="button" id="searchBtn">검색</button>
						</div>

						<script>
							document.getElementById("searchBtn").onclick = function() {

								let searchType = document
										.getElementsByName("searchType")[0].value;
								let keyword = document
										.getElementsByName("keyword")[0].value;

								location.href = "listPageSearch?num=1"
										+ "&searchType=" + searchType
										+ "&keyword=" + keyword;

							};
						</script>
						<div>
						 <input type="date">
						</div>
							
							
						</div>

					</div>
				</div>
			</main>
			
		</div>
	</div>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.1/dist/js/bootstrap.bundle.min.js"></script>
	<script src='<c:url value="/resources/js/scripts.js"/>'> </script>
	<script src="https://cdn.jsdelivr.net/npm/simple-datatables@latest"></script>
	<script src='<c:url value="/resources/js/datatables-simple-demo.js"/>'> </script>
</body>
</html>
