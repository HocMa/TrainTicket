<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page errorPage="errorPage.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Find PW</title>
<link href="css/style_Edit_Pw.css" rel="stylesheet" type="text/css">
</head>
<body>
	<jsp:include page="header.jsp"/>
	<h1 class="title">비밀번호 찾기</h1>
	
	<%
		String result = request.getParameter("result");
		if(result==null){
		} else if(result.equals("fname")){
		%>
			<script>
			alert("등록되지 않은 이름입니다.");
			</script>
		<%	
		} else if(result.equals("frrn")){
		%>
			<script>
			alert("주민등록번호가 잘못 되었습니다.");
			</script>
		<%	
		} else if(result.equals("fid")){
		%>
			<script>
			alert("등록되지 않은 아이디입니다.");
			</script>
		<%	
		}
	%>
	
    <form action="Find_Pw_Process.jsp" method="post">
    	<table class="info_Form">
    		<caption class="bottom">
    			<ul>
		            <li><a href="Find_Id.jsp">아이디 찾기</a></li>
            		<li><a href="Signup.jsp">회원가입</a></li>
            		<button class="inputBtn">비밀번호 찾기</button>
		        </ul>
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
    				<input type="text" id="user_id" name="user_id" 
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
    	</table>
    </form>
</body>
</html>