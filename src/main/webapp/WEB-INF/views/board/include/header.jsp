<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>


<nav class="navbar navbar-expand-lg navbar-dark bg-secondary">
  <div class="container-fluid">
    <a class="navbar-brand" style="color:white;">현장실습 미니프로젝트_송예은</a>

      <ul class="navbar-nav">
        <li class="nav-item">
          <a class="nav-link" href="/board/listPageSearch?num=1">Home</a>
        </li>
      </ul>
      
       <ul class="navbar-nav ml-auto">
        <li class="nav-item">
        <c:if test="${member == null}">
        <a class="nav-link" href="/member/signin">LOGIN</a>
        </c:if>
        <c:if test="${member != null}">
          <a class="nav-link" href="/member/signout">LOGOUT</a>
         </c:if>
        </li>
      </ul>
      
  </div>
</nav>