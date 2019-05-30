<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<!-- jQuery library -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.0/jquery.min.js"></script>
<script type="text/javascript">
	$(function() {
		$("#id").blur(function() {
			//1. xhttprequset 생성
			var xhttp;
			if(window.XMLHttpRequest){
				xhttp=new XMLHttpRequest();
			}else {
				xhttp= new ActiveXObject("Microsoft.XMLHTTP");				
			}
			
			//2. 요청 정보 기록
			xhttp.open("POST", "../member/idCheck", true);
			xhttp.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
			//3. 전송
			xhttp.send("id="+$("#id").val());
			
			//4. response 처리
			xhttp.onreadystatechange=function(){
				if(this.readyState==4 && this.status==200){
					if(this.responseText.trim()=='1'){
						$("#result").html("사용가능한 ID 입니다.");
						$("#result").css("color", "blue");
					}else {
						$("#result").html("사용 불가능한 ID 입니다.");
						$("#result").css("color", "red");
						$("#id").val("").focus();
						
					}
				}
			}
			
		});
	});
</script>
</head>
<body>
	<input type="text" id="id">
	<div id="result"></div>
</body>
</html>