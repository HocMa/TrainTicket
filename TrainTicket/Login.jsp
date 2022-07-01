<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page errorPage="errorPage.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Log In</title>
<link href="css/style_Login.css" rel="stylesheet" type="text/css">
</head>
<body>
	<jsp:include page="header.jsp"/>
    <h1 class="title">로그인</h1>
    
    <%
		String result = request.getParameter("result");
    	if(result==null){}
    	else if(result.equals("signup_scs")){
		%>
			<script>
			alert("회원 가입이 완료되었습니다.");
			</script>
		<%	
		} else if(result.equals("fail_login_pw")){
		%>
			<script>
			alert("잘못된 비밀번호입니다.");
			</script>
		<%	
		} else if(result.equals("fail_login_id")){
		%>
			<script>
			alert("잘못된 아이디입니다.");
			</script>
		<%	
		} else if(result.equals("find_id")){
			String value = request.getParameter("value");
		%>
			<script>
			alert("아이디는  <%=value %>입니다.");
			</script>
		<%	
		} else if(result.equals("find_pw")){
			String value = request.getParameter("value");
		%>
			<script>
			alert("비밀번호는  <%=value %>입니다.");
			</script>
		<%	
		}
	%>
    
    <form action="Login_Process.jsp" method="post">
    	<table id="login_Form">
    		<caption class="bottom">
    			<ul>
		            <li><a href="Find_Id.jsp">아이디 찾기</a></li>
		            <li><a href="Find_Pw.jsp">비밀번호 찾기</a></li>
		            <li><a href="Signup.jsp">회원가입</a></li>
		        </ul>
    		</caption>
    		<tr>
    			<td><label for="user_id">아이디</label></td>
    			<td>
    				<input type="text" id="user_id" name="user_id" autofocus
    				minlength="4" maxlength="10" onkeypress="CheckSpecial()" required>
    			</td>
    			<td rowspan="2">
    				<button>로<br>그<br>인</button>
    			</td>
    		</tr>
    		<tr>
    			<td><label for="user_pw">비밀번호</label></td>
    			<td>
    				<input type="password" id="user_pw" name="user_pw" 
    				minlength="6" maxlength="12" required>
    			</td>
    		</tr>
    	</table>
    </form>
</body>
</html>