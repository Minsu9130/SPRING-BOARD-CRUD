<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<style type="text/css">
a, a:hover {
	color: #000000;
	text-decoration: none;
}
th {
	background-color: #eeeeee; 
	text-align:center;
}
</style>
</head>
<body>
	<div class="container">	
		<div class="row">
			<table class="table table-striped" style="text-align: center; border: 1px solid #dddddd">
				<h2 style="text-align: center;">게시물 리스트</h2>
				<tr>
					<td colspan="5" style="background-color: #eeeeee;">현재 페이지 : ${pg} / 전체 페이지 : ${pageCount}</td>
				</tr>
				<tr>
					<th>번호</th>
					<th>제목</th>
					<th>작성자</th>
					<th>작성일</th>
					<th>조회수</th>
				</tr>
				<c:forEach items="${list}" var="dto" varStatus="vs">
					<tr>
						<td>${recordCount - vs.index - ((pg-1) * pageSize)}</td>
						<td><a href="${contextPath}/detail/${dto.no}/${pg}?vn=${recordCount - vs.index - ((pg-1) * pageSize)}">${dto.title}</a></td>
						<td>${dto.name}</td>
						<td>${dto.regdate}</td>
						<td>${dto.readcount}</td>
					</tr>
				</c:forEach>
				<tr>
					<td colspan="5">
						<c:if test="${startPage != 1}">
							<a href="list?pg=${startPage -1}" class="btn btn-link btn-arraw-left">이전</a>
						</c:if> 
						<c:forEach begin="${startPage}" end="${endPage}" var="p">
							<c:if test="${p == pg}">${p}</c:if>
							<c:if test="${p != pg}">
								<a href="list?pg=${p}" class="btn btn-link">${p}</a>
							</c:if>
						</c:forEach> 
						<c:if test="${endPage != pageCount}">
							<a href="list?pg=${endPage + 1}" class="btn btn-link btn-arraw-left">다음</a>
						</c:if>
					</td>
				</tr>
			</table>
			<br /> 
			<div class="card-footer"> 
				<div class="row"> 
					<div class="form-group col-sm-2"> 
						<select class="form-control" name="searchType" id="searchType"> 
							<option value="n" <c:out value="${searchCriteria.searchType == null ? 'selected' : ''}"/>>:::::: 선택 ::::::</option> 
							<option value="t" <c:out value="${searchCriteria.searchType eq 't' ? 'selected' : ''}"/>>제목</option> 
							<option value="c" <c:out value="${searchCriteria.searchType eq 'c' ? 'selected' : ''}"/>>내용</option> 
							<option value="w" <c:out value="${searchCriteria.searchType eq 'w' ? 'selected' : ''}"/>>작성자</option> 
							<option value="tc" <c:out value="${searchCriteria.searchType eq 'tc' ? 'selected' : ''}"/>>제목+내용</option> 
							<option value="cw" <c:out value="${searchCriteria.searchType eq 'cw' ? 'selected' : ''}"/>>내용+작성자</option> 
							<option value="tcw" <c:out value="${searchCriteria.searchType eq 'tcw' ? 'selected' : ''}"/>>제목+내용+작성자</option> 
						</select> 
					</div> 
					<div class="form-group col-sm-10"> 
						<div class="input-group"> 
							<input type="text" class="form-control" name="keyword" id="keywordInput" value="${searchCriteria.keyword}" placeholder="검색어"> 
							<span class="input-group-btn"> 
								<button type="button" class="btn btn-info btn-flat" id="searchBtn"> 
									<i class="fa fa-search"></i> 검색 
								</button> 
							</span>
						</div> 
					</div> 
				</div>
			</div>
			<a href="${contextPath}/insert" class="btn btn-info pull-right">글쓰기</a>
		</div>
	</div>
</body>
</html>