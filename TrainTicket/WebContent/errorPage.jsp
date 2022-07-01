<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page isErrorPage="true" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
	#errorDiv{
		width:100%;
		height:600px;
	}
	#errorDiv img{
		width:100%;
		height:100%;
	}
	#more{
		display:block;
		text-align:right;
		font-size:25px;
	}
	#more:visited{
		color:black;
	}
	#errorMsg{
		width:700px;
		margin: auto;
		font-size:25px;
	}
	.hide{
		display:none;
	}
	.show{
		visibility:visible;
	}
</style>
<script>
	function toggleShow(){
		if($("#errorMsg").hasClass("hide")){
			$("#errorMsg").removeClass("hide");
			$("#errorMsg").addClass("show");
		} else{
			$("#errorMsg").removeClass("show");
			$("#errorMsg").addClass("hide");
		}
			
	}
</script>
</head>
<body>
	<jsp:include page="header.jsp"/>
	<%
		String errorType = request.getParameter("errorType");
		String errorMsg = request.getParameter("errorMsg");
	%>
	<div id="errorDiv">
		<img src="css/images/errorImg.png" alt="error_Picture">
	</div>
	<a href="#" id="more" onclick="toggleShow(); return false;">+ 자세히 보기</a>
	<div id="errorMsg" class="hide">
		<%
			if(errorType == null && errorMsg == null){
		%>
				<p>예외 유형 : <%=exception.getClass().getName() %></p>
				<p>오류 메세지 : <%=exception.getMessage() %><p>
		<%
			}else{
		%>
				<p>예외 유형 : <%=errorType%></p>
				<p>오류 메세지 : <%=errorMsg%><p>
		<%	
			}
		%>
	</div>
</body>
</html>