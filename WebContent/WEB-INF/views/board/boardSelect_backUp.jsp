<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>      
<!DOCTYPE html>
<html>
<head>

<meta charset="UTF-8">
<title>Insert title here</title>
<c:import url="../temp/bootstrap.jsp"/>
<script type="text/javascript">
	$(function() {
		getList();
		
		$("#btn").click(function() {
			var writer = $("#writer").val();
			var contents = $("#contents").val();
			var num = '${dto.num}';
			
			//post ajax
			//1. XMLHttpRequest 생성
			var xhttp;
			if(window.XMLHttpRequest){
				xhttp = new XMLHttpRequest();
			}else {
				xhttp = new ActiveXObject("Microsoft.XMLHTTP");
			}
			//2. 연결정보
			xhttp.open("POST", "../comments/commentsWrite", true);
			xhttp.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
			//3. 전송
			xhttp.send("num="+num+"&writer="+writer+"&contents="+contents);
			//4. 결과처리
			xhttp.onreadystatechange=function(){
				if(this.readyState==4&&this.status==200){
					var result = this.responseText.trim();
					if(result=="1"){
						alert("성공");
						location.reload();
					}else {
						alert("실패");
					}
				}
			}
		});
		
		//
		function getList() {
			var xhttp;
			if(window.XMLHttpRequest){
				xhttp = new XMLHttpRequest();
			}else {
				xhttp = new ActiveXObject("Microsoft.XMLHTTP");
			}
			
			xhttp.open("GET", "../comments/commentsList", true);
			
			xhttp.send();
			
			xhttp.onreadystatechange=function(){
				if(this.readyState==4&&this.status==200){
					$("#commentsList").append(this.responseText);
				}
			}
		}
		
		/////
		$("#commentsList").on("click", ".del", function() {
			var cnum = $(this).attr("id");
			var check=confirm("삭제 할거냐?");
			if(check){
				$.get("../comments/commentsDelete?cnum="+cnum, function(data) {
					data = data.trim();
					if(data=="1"){
						alert("Delete Success");
						location.reload();
					}else {
						alert("Delete Fail");
					}
				});
				
			}
			
		});
		
	});
</script>
</head>
<body>
<c:import url="../temp/header.jsp" />
	
	<div class="container">
		<h1>Notice Select Page</h1>
		<h1>Title : ${dto.title} </h1>
		<h1>Contetns : ${dto.contents} </h1>
		<h1>Writer : ${dto.writer}</h1>
		<h1>Param    : ${param.num ge dto.num}</h1>
		<h1>Writer : ${dto.writer ne 'test'}</h1>
		<c:catch>
		<c:forEach items="${upload}" var="up">
		<h1>Upload : <a href="../upload/${up.fname}">${up.oname}</a></h1>
		</c:forEach>
		</c:catch>
	
	</div>
	<c:if test="${board ne 'notice'}">
		<div class="container">
			<!-- 댓글입력폼 -->
			<div class="row">
				<div class="form-group">
		      <label for="writer">Writer:</label>
		      <input type="text" class="form-control" id="writer" name="writer">
		    </div>
		    <div class="form-group">
			  <label for="contents">Contents:</label>
			  <textarea class="form-control" rows="10" id="contents" name="contents"></textarea>
			   <button class="btn btn-danger" id="btn">Write</button>
			</div>
			</div>
			
			<!-- 댓글리스트 -->
			<div class="row">
				<table class="table table-bordered" id="commentsList">
					
				</table>
			</div>
		
		</div>
	</c:if>
	
	<a href="./${board}Update?num=${dto.num}">GO Update</a>
</body>
</html>






