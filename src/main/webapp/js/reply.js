/**
 * 
 */

function getContextPath() {
	var hostIndex = location.href.indexOf( location.host ) + location.host.length;
	return location.href.substring( hostIndex, location.href.indexOf('/', hostIndex + 1) );
};

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
	
	$(".modalDelBtn").on("click", function () { 

		var reply_no = $(this).parent().parent().find("#rno").val();
		
		console.log(reply_no);
		
		// AJAX통신 : DELETE 
		$.ajax({ 
			type : "POST", 
			url : "getContextPath()/deleteReply/" + reply_no, 
			headers : { "Content-type" : "application/json", "X-HTTP-Method-Override" : "POST" }, 
			dataType : "text", 
			success : function (result) { 
				console.log("result : " + result); 
				if (result == "delSuccess") {
					alert("댓글 삭제 완료!"); 
					/* $("#modifyModal").modal('hide'); // Modal 닫기  */
					getReplies(); // 댓글 목록 갱신 
				} 
			} 
		}); 
	});

	$(".modalModBtn").on("click", function () { 
		// 댓글 선택자 
		var reply = $(this).parent().parent(); // 댓글번호 
		var reply_no = reply.find("#rno").val(); // 수정한 댓글내용 
		var reply_text = reply.find("#content").val();

		
		console.log(reply_no + " " + reply_text);
		
		// AJAX통신 : PUT
		$.ajax({ 
			type : "POST", 
			url : "getContextPath()/updateReply/" + reply_no, 
			headers : { "Content-type" : "application/json", "X-HTTP-Method-Override" : "POST" }, 
			data : JSON.stringify( {content : reply_text} ), 
			dataType : "text", 
			success : function (result) { 
				console.log("result : " + result);
				if (result == "modSuccess") {
					alert("댓글 수정 완료!");
					/* $("#modifyModal").modal('hide'); // Modal 닫기  */
					getReplies(); // 댓글 목록 갱신 
				} 
			} 
		}); 
	});


	
		$(document).ready(function(){
			(function() {
				let bno = '<c:out value="${boardDTO.no}"/>';
				
				$.getJSON("getContextPath()/getAttachList", {bno: bno}, function(arr) {
					console.log(arr);
					
					let str = "";
					
					$(arr).each(function(i, attach) {
						if(attach.image) {
							let fileCallPath = encodeURIComponent( attach.uploadPath + "/" + attach.uuid + "_" + attach.fileName);
							
							str += "<li  data-path='" + attach.uploadPath + "' data-uuid='" + attach.uuid + "' data-filename='" +
									attach.fileName + "' data-image='" + attach.image + "'><div>" + 
									"<img src='${contextPath}/display?fileName=" + fileCallPath + "'>" +
									"</div></li>";
						} else {
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
			
			function showImage(fileCallPath) {
				//alert(fileCallPath);
				
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
	