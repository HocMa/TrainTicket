<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page errorPage="errorPage.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Edit Pw</title>
<link href="css/style_Edit_Pw.css" rel="stylesheet" type="text/css">
</head>
<body>
	<jsp:include page="header.jsp"/>
    <h1 class="title">비밀번호 변경</h1>
	<%
		String result = request.getParameter("result");
		if(result==null){
		} else{
		%>
			<script>
			alert("전과 같은 비밀번를 입력하셨습니다.");
			</script>
		<%	
		}
	%>
    <form action="Edit_Pw_Process.jsp" method="post">
    	<table class="info_Form">
    		<caption class="bottom">
            	<button class="inputBtn" onclick="PwChk()">비밀번호 변경</button>
    		</caption>
    		<tr>
    			<td><label for="user_pw">비밀번호</label></td>
    			<td>
    				<input type="password" id="user_pw" name="user_pw" 
    				minlength="6" maxlength="12" autofocus required>
    			</td>
    		</tr>
    		<tr>
    			<td><label for="user_pwchk">비밀번호 확인</label></td>
    			<td>
    				<input type="password" id="user_pwchk" name="user_pwchk" 
    				minlength="6" maxlength="12" required>
    			</td>
    		</tr>
    	</table>
    </form>
</body>
</html>