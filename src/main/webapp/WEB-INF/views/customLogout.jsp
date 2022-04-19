<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="${contextPath}/css/bootstrap.css">
<style>
.conteiner {
	width:300px;
    height:300px;
    position:absolute;
    left:50%;
    top:50%;
    margin-left:-150px;
    margin-top:-150px;
}
</style>
</head>
<body>
	<div class="conteiner">
		<div class="login-panel panel panel-default">
			<div class="panel-heading">
				<h3 class="panel-title">로그아웃 페이지</h3>
			</div>
			
			<div class="panel-body">
				<form action="${contextPath}/customLogout" method="post">
					<fieldset>
						<button class="byn btn-lg btn-info btn-block">로그아웃</button>
					</fieldset>
					<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
				</form>
			</div>
		</div>	

	</div>
</body>
</html>