<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page errorPage="errorPage.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Delete Member</title>
<link href="css/style_Edit_Pw.css" rel="stylesheet" type="text/css">
</head>
<body>
	<jsp:include page="header.jsp"/>
    <h1 class="title">회원 탈퇴</h1>

	<%
		String result = request.getParameter("result");
		if(result==null){
		} else{
		%>
			<script>
			alert("비밀번호가 틀렸습니다.");
			</script>
		<%	
		}
	%>

    <form action="Delete_Member_Process.jsp" method="post">
    	<table class="info_Form">
    		<caption class="bottom">
            	<button class="inputBtn" onclick="Sure()">회원 탈퇴</button>
    		</caption>
    		<tr>
    			<td><label for="user_pw">비밀번호</label></td>
    			<td>
    				<input type="password" id="user_pw" name="user_pw" 
    				minlength="6" maxlength="12" autofocus required>
    			</td>
    		</tr>
    	</table>
    </form>
</body>
</html>