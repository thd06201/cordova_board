<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html lang="kr">
<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1">    
  <title>로그인</title>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/js/all.min.js" crossorigin="anonymous"></script>
   
     <link rel="stylesheet" href='<c:url value="/resources/css/styles.css"/>'>
    </head>
    <body class="primary">
                <main>
                    <div class="container">
                        <div class="row justify-content-center">
                            <div class="col-lg-5">
                                <div class="card shadow-lg border-0 rounded-lg mt-5">
                                    <div class="card-header"><h3 class="text-center font-weight-light my-4">Login</h3></div>
                                    <div class="card-body">
                                        <form method="post"role="form">
                                        <c:if test="${member == null}">
                                            <div class="form-floating mb-3">
                                                <input class="form-control" id="userId" name="userId" type="text" required="required"/>
                                                <label for="inputEmail">ID</label>
                                            </div>
                                            <div class="form-floating mb-3">
                                                <input class="form-control" id="userPass" name="userPass" type="password" required="required" />
                                                <label for="inputPassword">Password</label>
                                            </div>
                                            <div class="d-flex align-items-center justify-content-between mt-5 mb-0">
                                                <a class="small"></a>
                                                <button class="btn btn-primary" type="submit" id="signup_btn" name="signup_btn">Login</button>
                                            </div>
                                            </c:if>
                                            <c:if test="${msg == false }">
                                            <p class="d-flex align-items-center justify-content-between mt-0 mb-0" style="color:red;">로그인 실패! 다시 입력하세요.</p>
                                            </c:if>
                                            
                                        </form>
                                    </div>
                                    <div class="card-footer text-center py-3">
                                        <div class="small">&nbsp</div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </main>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.1/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
        <script src="/resources/js/scripts.js"></script>
    </body>
</html>
