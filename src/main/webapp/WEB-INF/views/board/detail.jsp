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
<meta name="viewport" content="width=device-width, initial-scale=1">
<style type="text/css">
a, a:hover {
	color: #000000;
	text-decoration: none;
}

th {
	text-align: center;
}
</style>
</head>
<body>
	<div class="container">
		<div class="row">
			<div class="col-lg-12">
				<div class="panel panel-default">
					<div class="panel-heading" colspan="2"
						style="background-color: #eeeeee; text-align: center;">게시판
						상세보기</div>
					<div class="panel-body">
						<div class="form-group">
							<label>번호</label> 
							<input type="text" name="title" autofocus="autofocus" value="${vn}" required="required" class="form-control" readonly="readonly" />
						</div>
						<div class="form-group">
							<label>제목</label> 
							<input type="text" name="title" autofocus="autofocus" value="${boardDTO.title}" required="required" class="form-control" readonly="readonly" />
						</div>
						<div class="form-group">
							<label>작성자</label> 
							<input type="text" name="name" required="required" value="${boardDTO.name}" class="form-control" readonly="readonly" />
						</div>
						<div class="form-group">
							<label>내용</label>
							<textarea name="content" rows="5" cols="40" required="required" class="form-control" readonly="readonly">${boardDTO.content}</textarea>
						</div>
						<div class="form-group">
							<label>작성일</label> 
							<input type="text" name="date" required="required" value="${boardDTO.regdate}" class="form-control" readonly="readonly">
						</div>
						<div class="form-group">
							<label>조회수</label> 
							<input type="text" name="name" required="required" value="${boardDTO.readcount}" class="form-control" readonly="readonly" />
						</div>
						<div class="form-group uploadDiv">
							<label>첨부 파일</label>
							<div class="uploadResult">
								<ul>
								</ul>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>

	<div class='bigPictureWrapper'>
		<div class='bigPicture'></div>
	</div>

	<!-- 게시글 작성자만 수정,삭제 버튼이 보이도록 처리 -->
	<sec:authentication property="principal" var="pinfo" />
		<sec:authorize access="isAuthenticated()">
			<c:if test="${pinfo.member.userName eq boardDTO.name}">
				<a href="${contextPath}/delete/${boardDTO.no}?vn=${vn}"
					class="btn btn-default pull-right" style="margin-left: 5px;">삭제</a>
				<a href="${contextPath}/update/${boardDTO.no}/${pg}?vn=${vn}"
					 class="btn btn-default pull-right">수정</a>
			</c:if>
		</sec:authorize>
	
	<!-- 댓글 입력, 목록 화면 -->
	<div class="container">
		<div class="card-body">
			<form method="post" role='form'>
				<div class="row" style="margin-top: 40px;">
					<div class="form-group col-sm-8">
						<input class="form-control input-sm" id="newReplyText" type="text"
							placeholder="댓글 입력...">
					</div>
					<div class="form-group col-sm-2">
						<sec:authorize access="isAuthenticated()">
							<input class="form-control input-sm" id="newReplyWriter" value="${pinfo.member.userName}" placeholder="${pinfo.member.userName}" readonly="readonly">					
						</sec:authorize>
						<sec:authorize access="isAnonymous()">
							<input class="form-control input-sm" id="newReplyWriter" value="익명" placeholder="익명" readonly="readonly">
						</sec:authorize>				
					</div>
					<div class="form-group col-sm-2">
						<button type="button"
							class="btn btn-info btn-sm btn-block replyAddBtn">
							<i class="fa fa-save"></i> 저장
						</button>
					</div>
				</div>
			</form>
			<div class="card-footer">
				<ul id="replies">
				</ul>
			</div>
			<div class="card-footer">
				<nav aria-label="Contacts Page Navigation">
					<ul
						class="pagination pagination-sm no-margin justify-content-center m-0">
					</ul>
				</nav>
			</div>
		</div>
	</div>
	
	<!-- 댓글 수정 modal -->
	<div class="modal fade" id="modifyModal" role="dialog">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">&times;</button>
					<h4 class="modal-title">댓글 수정창</h4>
				</div>
				<div class="modal-body">
					<div class="form-group">
						<label for="rno">댓글 번호</label> <input class="form-control"
							id="rno" name="rno" readonly>
					</div>
					<div class="form-group">
						<label for="content">댓글 내용</label> <input class="form-control"
							id="content" name="content" placeholder="댓글 내용을 입력해주세요">
					</div>
					<div class="form-group">
						<label for="writer">댓글 작성자</label> <input
							class="form-control" id="writer" name="writer"
							readonly>
					</div>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default pull-left"
						data-dismiss="modal">닫기</button>
					<button type="button" class="btn btn-success modalModBtn">수정</button>
					<button type="button" class="btn btn-danger modalDelBtn">삭제</button>
				</div>
			</div>
		</div>
	</div> 
	
	<script type="text/javascript" src="<c:url value="/webjars/jquery/3.6.0/dist/jquery.js" />"></script>
	<script type="text/javascript">
	
	var csrfHeaderName = "${_csrf.headerName}";
	var csrfTokenValue = "${_csrf.token}";
	
	$(document).ready(function() {
		
		// 댓글 등록 함수
		$(".replyAddBtn").on("click",function() { 
			// 화면으로부터 입력 받은 변수값의 처리 
			var reply_bno = ${boardDTO.no};
			var reply_text = $("#newReplyText"); 
			var reply_writer = $("#newReplyWriter"); 
			var reply_textVal = reply_text.val(); 
			var reply_writerrVal = reply_writer.val(); 
			// AJAX 통신 : POST
			
			console.log(reply_writerrVal);
			
			if ( reply_writerrVal != "익명" ) {
				$.ajax({ 
					type : "POST", 
					url : "${contextPath}/replyInsert", 
					beforeSend: function(xhr) {
						xhr.setRequestHeader(csrfHeaderName, csrfTokenValue)
					},
					headers : { "Content-type" : "application/json", "X-HTTP-Method-Override" : "POST" },
					dataType : "text", 
					data : JSON.stringify({bno : reply_bno, content : reply_textVal, writer : reply_writerrVal }), 
					success : function (result) { 
						// 성공적인 댓글 등록 처리 알림 
						if (result == "regSuccess") { 
							console.log("댓글 등록 완료!"); 
						} 
						getReplies(); // 댓글 목록 출력 함수 호출 
						reply_text.val(""); // 댓글 내용 초기화 
						reply_writer.val(""); // 댓글 작성자 초기화 
					} 
				}); 
			}
			else {
				alert("익명의 사용자는 댓글 등록이 불가능 합니다");
			}
		});
	});
	
	// 댓글 작성자를 저장하는 변수
	const replyer = document.getElementById("newReplyWriter").value;

	
	getReplies();
	
	// 댓글 목록을 불러오는 함수
	function getReplies() {
		$.getJSON("${contextPath}/replyList/" + ${boardDTO.no}, function (data) {
			console.log(data);
			var str = "";
			
			
			$(data).each(function () {					
				if(this.writer === replyer) {
					str += "<li data-reply_no='" + this.rno + "' class='replyLi'>"
					+ "<p class='reply_text'>" + this.content + "</p>" 
					+ "<p class='reply_writer'> 작성자 : " + this.writer + "</p>" 
					+ "<button type='button' class='btn btn-xs btn-info' data-toggle='modal' data-target='#modifyModal'>댓글 수정</button>"
					+ "</li>" 
					+ "<hr/>"; 
				}
				else {
					str += "<li data-reply_no='" + this.rno + "' class='replyLi'>"
					+ "<p class='reply_text'>" + this.content + "</p>" 
					+ "<p class='reply_writer'> 작성자 : " + this.writer + "</p>" 
					+ "</li>" 
					+ "<hr/>"; 
				}
			}); 
			$("#replies").html(str);
		}); 
	}
	

	$("#replies").on("click", ".replyLi button", function () {
		var reply = $(this).parent();
		var reply_no = reply.attr("data-reply_no");
		var reply_text = reply.find(".reply_text").text();
		var reply_writer = reply.find(".reply_writer").text();
		
		console.log(reply_no + " ");
		
		$("#rno").val(reply_no); 
		$("#content").val(reply_text); 
		$("#writer").val(reply_writer); 
	});
	
	// 댓글 삭제 함수
	$(".modalDelBtn").on("click", function () { 

		var reply_no = $(this).parent().parent().find("#rno").val();
		
		console.log(reply_no);
		
		$.ajax({ 
			type : "POST", 
			url : "${contextPath}/deleteReply/" + reply_no,
			beforeSend: function(xhr) {
				xhr.setRequestHeader(csrfHeaderName, csrfTokenValue)
			},
			headers : { "Content-type" : "application/json", "X-HTTP-Method-Override" : "POST" }, 
			dataType : "text", 
			success : function (result) { 
				console.log("result : " + result); 
				if (result == "delSuccess") {
					console.log("댓글 삭제 완료!"); 
					$("#modifyModal").modal('hide'); // Modal 닫기  
					getReplies(); // 댓글 목록 갱신 
				} 
			} 
		}); 
	});

	// 댓글 수정 함수
	$(".modalModBtn").on("click", function () { 
		// 댓글 선택자 
		var reply = $(this).parent().parent(); // 댓글번호 
		var reply_no = reply.find("#rno").val(); // 수정한 댓글내용 
		var reply_text = reply.find("#content").val();

		
		console.log(reply_no + " " + reply_text);
		
		$.ajax({ 
			type : "POST", 
			url : "${contextPath}/updateReply/" + reply_no, 
			beforeSend: function(xhr) {
				xhr.setRequestHeader(csrfHeaderName, csrfTokenValue)
			},
			headers : { "Content-type" : "application/json", "X-HTTP-Method-Override" : "POST" }, 
			data : JSON.stringify( {content : reply_text} ), 
			dataType : "text", 
			success : function (result) { 
				console.log("result : " + result);
				if (result == "modSuccess") {
					console.log("댓글 수정 완료!");
					$("#modifyModal").modal('hide'); // Modal 닫기  
					getReplies(); // 댓글 목록 갱신 
				} 
			} 
		}); 
	});
 

	$(document).ready(function(){
		
		// 상세페이지에서 업로드된 파일을 화면에 보여지도록 하는 함수
		(function() {
			let bno = '<c:out value="${boardDTO.no}"/>';
			
			$.getJSON("${contextPath}/getAttachList", {bno: bno}, function(arr) {
				console.log(arr);
				
				let str = "";
				
				$(arr).each(function(i, attach) {
					
					if(attach.image) { // 퍼알이 이미지일 경우
						let fileCallPath = encodeURIComponent( attach.uploadPath + "/" + attach.uuid + "_" + attach.fileName);
						
						str += "<li  data-path='" + attach.uploadPath + "' data-uuid='" + attach.uuid + "' data-filename='" +
								attach.fileName + "' data-image='" + attach.image + "'><div>" + 
								"<img src='${contextPath}/display?fileName=" + fileCallPath + "'>" +
								"</div></li>";
					} else { // 파일이 이미지가 아닐 경우
						str += "<li  data-path='" + attach.uploadPath + "' data-uuid='" + attach.uuid + "' data-filename='" +
								attach.fileName + "' data-image='" + attach.fileType + "'><div>" +  
								"<img src='${contextPath}/resources/img/attach.png'></a><br>"  +
								"<span> " + attach.fileName + "</span>" +
								"</div></li>";
					}
				});
				$(".uploadResult ul").html(str);
			});
		})();
		
		// 파일 클릭시 이미지는 원본 이미지 확인, 이미지 제외 파일은 다운로드
		$(".uploadResult").on("click", "li", function(e) {
			
			console.log("view image");
			
			let liobj = $(this);
			let path = encodeURIComponent( liobj.data("path") + "/" + liobj.data("uuid") + "_" + liobj.data("filename"));
			
			if(liobj.data("image") == true) {
				showImage(path.replace(new RegExp(/\\/g), "/"));
			}
			else {
				self.location = "${contextPath}/download?fileName="+ path
			}				
		});
		
		// 이미지를 화면에 띄우고 애니메이션 설정 함수
		function showImage(fileCallPath) {
			$(".bigPictureWrapper").css("display", "flex").show();
			
			$(".bigPicture")
			.html("<img src='${contextPath}/display?fileName=" + fileCallPath +"'>")
			.animate({width : '100%', height : '100%'}, 1000);
		}
		
		$(".bigPictureWrapper").on("click", function(e) {
			$(".bicPicture").animate({width : '0%', height : '0%'}, 1000);
			setTimeout(function(){
				$('.bigPictureWrapper').hide();
			}, 700);
		});
	});
	</script>
	
	<script src="${contextPath}/js/bootstrap.js"></script>
</body>
</html>