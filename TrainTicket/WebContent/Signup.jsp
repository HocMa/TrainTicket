<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page errorPage="errorPage.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Sign Up</title>
<link href="css/style_Edit_Pw.css" rel="stylesheet" type="text/css">
</head>
<body>
	<jsp:include page="header.jsp"/>
	<h1 class="title">회원 가입</h1>
	<%
		String result = request.getParameter("result");
		if(result==null){
		} else if(result.equals("fid")){
		%>
			<script>
			alert("같은 아이디가 있습니다.\n다른 아이디를 입력하세요");
			</script>
		<%	
		} else if(result.equals("frrn")){
		%>
			<script>
			alert("같은 주민등록번호가 있습니다.\n다른 주민등록번호를 입력하세요");
			</script>
		<%	
		}
	%>
    <form action="Signup_Process.jsp" method="post">
    	<table class="info_Form">
    		<caption class="bottom">
            	<button class="inputBtn" onclick="PwChk()">회원 가입</button>
    		</caption>
    		<tr>
    			<td><label for="user_name">이름</label></td>
    			<td>
    				<input type="text" id="user_name" name="user_name" 
    				onkeypress="CheckChar()" autofocus required>
    			</td>
    		</tr>
    		<tr>
    			<td><label for="user_id">아이디</label></td>
    			<td>
					<input type="text" id="user_id" name="user_id" placeholder="4~10자리"
   					minlength="4" maxlength="10" onkeypress="CheckSpecial()" required>
   				</td>
    		</tr>
    		<tr>
    			<td><label for="user_rrn1">주민등록번호</label></td>
    			<td>
    				<div id="rrn">
	    				<input type="text" id="user_rrn1" name="user_rrn1" 
	    				minlength="6" maxlength="6" onkeypress="CheckNum()" autocomplete="off" required>
	    				<span style="font-size:40px; font-weight:bold;">-</span>
	    				<input type="password" id="user_rrn2" name="user_rrn2" 
	    				minlength="7" maxlength="7" onkeypress="CheckNum()" required>
    				</div>
    			</td>
    		</tr>
    		<tr>
    			<td><label for="user_pw">비밀번호</label></td>
    			<td>
    				<input type="password" id="user_pw" name="user_pw" 
    				placeholder="6~12자리" minlength="6" maxlength="12" required>
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