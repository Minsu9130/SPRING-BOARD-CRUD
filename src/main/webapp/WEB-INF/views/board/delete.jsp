<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<div class="container">
		<div class="row">
			<form method="post">
				<table class="table table-striped"
					style="text-align: center; border: 1px solid #dddddd">
					<th colspan="3" style="background-color: #eeeeee; text-align: center;">게시물 삭제</th>
					<tr>
						<th>글 번호</th>
						<td>${vn}<input type="hidden" name="no" value="${no}"
							readonly=readonly></td>
					</tr>
					<tr>
						<th>비밀번호</th>
						<td><input type="password" name="password"
							required="required" autofocus="autofocus" class="form-control" placeholder="처음 글 작성시 입력했던 비밀번호를 재 입력하세요"/>
						</td>
					</tr>
					<tr>
						<td colspan="2" align="center"><input type="submit"
							value="삭제" class="btn btn-info pull-right" /></td>
					</tr>
				</table>
				<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
			</form>
		</div>
	</div>
</body>
</html>