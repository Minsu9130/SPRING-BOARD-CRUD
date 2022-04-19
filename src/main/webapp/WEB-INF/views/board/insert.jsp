<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
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
    		<div class="col-lg-12">
    			<div class="panel panel-default">
            		<div class="panel-heading" colspan="2"
								style="background-color: #eeeeee; text-align: center;"> 게시판 글쓰기 </div>
						<div class="panel-body">
							<form role="form" method="post" action="insert">						
								<div class="form-group">
			                        <label>제목</label>
			                        <input type="text" name="title" autofocus="autofocus" required="required" class="form-control" />
			                    </div>
			                    <div class="form-group">
			                        <label>작성자</label>
			                        <input type="text" name="name" value="<sec:authentication property='principal.member.userName'/>"
			                         readonly="readonly" class="form-control" />
			                    </div>
			                    <div class="form-group">
			                        <label>비밀번호</label>
			                        <input type="password" name="password" required="required" class="form-control" />
			                    </div>
			                    <div class="form-group">
			                        <label>내용</label>
			                        <textarea name="content" rows="5" cols="40" required="required" class="form-control"></textarea>
			                    </div>		                
								<div class="form-group uploadDiv">
									<label>첨부 파일</label>
									<input type='file' name='uploadFile' multiple>
								</div>
								<div class="uploadResult">
									<ul>
									</ul>
								</div>
								<input type="submit" class="btn btn-info pull-right" value="글쓰기" />
								<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
							</form>
						</div>
				</div>
			</div>
		</div>
	</div>


	<script type="text/javascript"
		src="<c:url value="/webjars/jquery/3.6.0/dist/jquery.js" />"></script>
	<script src="js/bootstrap.js"></script>

	<script>
	
	
	$(document).ready(function(e) {
		let formObj = $("form[role='form']");
		
		$("input[type='submit']").on("click", function(e) {
			e.preventDefault();
			
			console.log("submit clicked");
			
			let str = "";
			
			$(".uploadResult ul li").each(function(i, obj) {
				
				let jobj = $(obj);
			
				console.dir(jobj);
			
				str += "<input type='hidden' name='attachList["+i+"].fileName' value='"+jobj.data("filename")+"'>";
				str += "<input type='hidden' name='attachList["+i+"].uuid' value='"+jobj.data("uuid")+"'>";
				str += "<input type='hidden' name='attachList["+i+"].uploadPath' value='"+jobj.data("path")+"'>";
				str += "<input type='hidden' name='attachList["+i+"].image' value='"+jobj.data("image")+"'>";
			});
			formObj.append(str).submit();
		});
		
		let regex = new RegExp("(.*?)\.(exe|sh|zip|alz)$");
		let maxSize = 5242880 ; //5MB
		
		function checkExtension(fileName, fileSize) {
			if(fileSize >= maxSize){
				alert("파일 사이즈 초과");
				return false;
			}//end if
			if(regex.test(fileName)){
				alert("해당 종류 파일 업로드 불가");
				return false;
			}//end if
			return true;
		}
		
		function showUploadedFile(uploadResultArr) {
			
			if(!uploadResultArr || uploadResultArr.length == 0) { return; }
			
			let uploadUL = $(".uploadResult ul");
			let str = "";
			
			$(uploadResultArr).each(
				function(i, obj) {
					
					if (!obj.image) {
						let fileCallPath = encodeURIComponent( obj.uploadPath + "/" + obj.uuid + "_" + obj.fileName);
						
						let fileLink = fileCallPath.replace(new RegExp(/\\/g), "/");
						
						str += "<li data-path='" + obj.uploadPath + "' data-uuid='" + obj.uuid + "' data-filename='" + obj.fileName + "' data-image='" + obj.image + "'>" + 
								"<div><span> " + obj.fileName + "</span>" + 
								"<button type='button' data-file=\'" + fileCallPath + "\' data-type='file' class='btn-circle'><i class='fa fa-times'> X </i></button><br>" +
								"<img src='${contextPath}/resources/img/attach.png'></a>" +
								"</div></li>";
					}
					else {
						let fileCallPath = encodeURIComponent( obj.uploadPath + "/s_" + obj.uuid + "_" + obj.fileName);
						let originPath = obj.uploadPath + "\\" + obj.uuid + "_" + obj.fileName;
						
						originPath = originPath.replace(new RegExp(/\\/g), "/");
						
						str += "<li  data-path='" + obj.uploadPath + "' data-uuid='" + obj.uuid + "' data-filename='" + obj.fileName + "' data-image='" + obj.image + "'><div>" + 
								"<span> " + obj.fileName + "</span>" + 
								"<button type='button' data-file=\'" + fileCallPath + "\' data-type='file' class='btn-circle'><i class='fa fa-times'> X </i></button><br>" +
								"<img src='${contextPath}/display?fileName=" + fileCallPath + "'>" +
								"</div></li>";
					}
				});
			
			uploadUL.append(str);
		}
		
		var csrfHeaderName = "${_csrf.headerName}";
		var csrfTokenValue = "${_csrf.token}";
		$("input[type='file']").change(function(e) {
			
			let formData = new FormData();
			let inputFile = $("input[name='uploadFile']");
			let files = inputFile[0].files;
			console.log(files);
			
			for(let i=0; i < files.length; i++) {
				//파일 종류 및 크기 체크
				if( !checkExtension(files[i].name, files[i].size ) ){
					return false;
				}
				formData.append("uploadFile", files[i]);	
			}		
			
			$.ajax({
				url : 'uploadAjaxAction',
				processData: false,
				contentType: false,
				beforeSend: function(xhr) {
					xhr.setRequestHeader(csrfHeaderName, csrfTokenValue)
				},
				data: formData,
				type : 'POST',
				dataType : 'json',
				success:function(result) {
					alert("업로드 완료")
					console.log(result);
					showUploadedFile(result);
					//$(".uploadDiv").html(cloneObj.html());
				}
			});
		});
		
		$(".uploadResult").on("click", "button", function(e) {
			console.log("delete file")
			
			let targetFile = $(this).data("file");
			let type = $(this).data("type");
			let temp = $(this).parents("li")
		
			console.log(targetFile);
			
			$.ajax({
				url: 'deleteFile',
				beforeSend: function(xhr) {
					xhr.setRequestHeader(csrfHeaderName, csrfTokenValue)
				},
				data: {fileName:targetFile, type:type},
				dataType: 'text',
				type: 'POST',
				success: function(result) {
					temp.remove();
					alert(result);
				}
			});
		});
	});
	
	</script>
	
	<script type="text/javascript"
		src="<c:url value="/webjars/jquery/3.6.0/dist/jquery.js" />"></script>
	<script src="js/bootstrap.js"></script>

</body>
</html>