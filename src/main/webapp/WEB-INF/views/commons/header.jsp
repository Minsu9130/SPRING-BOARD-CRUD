<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="${contextPath}/css/bootstrap.css">
<link rel="stylesheet" href="${contextPath}/css/custom.css">
<link rel="stylesheet" href="${contextPath}/css/file.css" />
</head>
<body>
<div class="container">
	<nav class="navbar navbar-default">
		<div class="navbar-header">
			<button type="button" class="navbar-toggle collapsed" data-toggle="collapse"
				data-target="#bs-example-navbar-collapse-1" aria-expanded="false">
				<span class="icon-bar"></span>
				<span class="icon-bar"></span>
				<span class="icon-bar"></span>
			</button>
			<a class="navbar-brand" href="${contextPath}/list?pg=${pg}">스프링 게시판</a>
		</div>
		<div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
			<ul class="nav navbar-nav">
				
			</ul>
			<ul class="nav navbar-nav navbar-right">		
				<sec:authorize access="isAnonymous()"> 		
					<li><a href="${contextPath}/customLogin">로그인</a></li>
					<li><a>회원가입</a></li>	
				</sec:authorize>
				<sec:authorize access="isAuthenticated()"> 
					<sec:authentication property="principal" var="pinfo" />
					<li><a href="">${pinfo.member.userName}님</a></li>
					<li><a href="${contextPath}/customLogout">로그아웃</a></li>
				</sec:authorize>
							
			</ul>
		</div>
	</nav>
</div>	
</body>