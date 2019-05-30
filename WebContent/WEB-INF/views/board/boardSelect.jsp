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
		var curPage=1;
		/////////////////////////////////////
		$("#updateBtn").click(function() {
			var contents= $("#updateContents").val();
			var cnum=  $("#cnum").val();
			$.post("../comments/commentsUpdate",{
				contents:contents,
				cnum:cnum
			}, function(data) {
				data = data.trim();
				if(data=="1"){
					alert("Success");
					//getList(1);
					$("#c"+cnum).html(contents);
				}else {
					alert("Fail");
				}
			});
			
			
		});
		
		//////////////////////////
		$("#commentsList").on("click", ".update", function(){
			var id=$(this).attr("title");
			var con= $("#c"+id).html();
			$("#updateContents").val(con);
			$("#cnum").val(id);
			
		});
		
		
		
		/////
		$("#more").click(function() {
			curPage++;
			getList(curPage);
			
		});
		
		//////////////////////////////////
		$("#btn").click(function() {
			var writer = $("#writer").val();
			var contents = $("#contents").val();
			var num = '${dto.num}';
			$.post("../comments/commentsWrite",{
				writer:writer,
				contents:contents,
				num:num
			}, function(data) {
				data = data.trim();
				if(data=="1"){
					alert("success");
					getList(1);
				}else {
					alert("Fail");
				}
			});
			
			
		});
		
		//
		function getList(count) {
			$.get("../comments/commentsList?num=${dto.num}&curPage="+count, function(data) {
				data = data.trim();
				if(count==1){
					$("#commentsList").html(data);
				}else {
					$("#commentsList").append(data);
				}
			});
		}
		
		/////
		$("#commentsList").on("click", ".del", function() {
			var cnum = $(this).attr("id");
			var check=confirm("삭제 할거냐?");
			if(check){
				$.get("../comments/commentsDelete?cnu="+cnum, function(data) {
					data = data.trim();
					if(data=="1"){
						alert("Delete Success");
						getList(1);
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
		<h1>Contetns :</h1>
		<div>${dto.contents}</div>
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
				<button id="more">더보기</button>
			</div>
		
		</div>
	</c:if>
	<div class="container">
	  <!-- Modal -->
	  <div class="modal fade" id="myModal" role="dialog">
	    <div class="modal-dialog">
	    
	      <!-- Modal content-->
	      <div class="modal-content">
	        <div class="modal-header">
	          <h4 class="modal-title">${member.id}</h4>
	        </div>
	        <div class="modal-body">
		         <div class="form-group">
				  <label for="contents">Contents:</label>
				  <textarea class="form-control" rows="10" id="updateContents" name="contents"></textarea>
				  <input type="hidden" id="cnum">
				</div>
	        </div>
	        <div class="modal-footer">
			   <button class="btn btn-danger" id="updateBtn" data-dismiss="modal">Update</button>
	           <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
	        </div>
	      </div>
	      
	    </div>
	  </div>
	</div>
	
	<a href="./${board}Update?num=${dto.num}">GO Update</a>
</body>
</html>






