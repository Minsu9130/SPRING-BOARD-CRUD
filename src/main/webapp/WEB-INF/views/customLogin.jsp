<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="${contextPath}/css/bootstrap.css">
<title>Insert title here</title>
</head>
<style>
.container .jumbotron {
    padding-left: 60px;
    padding-right: 60px;
    margin-top: 100px;
}    
.container {
    margin-top: 20px;
}
.form-group {
	 text-align:center;
}
{
	margin-top : 20px;
	margin-bottom : 20px; 
}
</style>
<body>
<%@ include file="commons/header.jsp" %>
  <div class="container">
		<div class="container">
			<div class="col-lg-4"></div>
			<div class="col-lg-4">
				<div class="jumbotron" style="padding-top: 20px;">
					<form method='post' action="${contextPath}/login">
						<h3 style="text-align:center;">로그인 화면</h3>
						<div class="form-group">
							 <input type='text' name='username' placeholder='아이디' class="form-control" >
						</div>
						<div class="form-group">
							<input type='password' name='password' placeholder='비밀번호' class="form-control"></br>
							<input type="checkbox" name="remember-me"> 로그인 상태 유지
						</div>
					
  						<div class="form-group">
							<input type="submit" class="btn btn-info form-control" value="로그인">
						</div>
						<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
  
					</form>
					<div class="links" style="text-align : center;">
           			 	아이디 찾기 | 비밀번호 찾기 | 회원가입
        			</div>
				</div>
			</div>
			<div class="col-lg-4"></div>
		</div>
	</div>
	
	
	<script type="text/javascript" src="<c:url value="/webjars/jquery/3.6.0/dist/jquery.js" />"></script>
	<script src="js/bootstrap.js"></script>
<%@ include file="commons/footer.jsp" %>
</body>
</html>