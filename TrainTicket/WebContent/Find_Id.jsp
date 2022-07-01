<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page errorPage="errorPage.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="css/style_Find_Id.css" rel="stylesheet" type="text/css">
<title>Find ID</title>
</head>
<body>
	<jsp:include page="header.jsp"/>
    <h1 class="title">아이디 찾기</h1>
    
    <%
		String result = request.getParameter("result");
		if(result==null){
		} else if(result.equals("fail")){
		%>
			<script>
			alert("이름이나 주민등록번호가 잘못되었습니다.");
			</script>
		<%	
		}
	%>	
    
    <form action="Find_Id_Process.jsp" method="post">
    	<table id="info_Form">
    		<caption class="bottom">
    			<ul>
		            <li><a href="Find_Pw.jsp">비밀번호 찾기</a></li>
           			<li><a href="Signup.jsp">회원가입</a></li>
            		<button>아이디 찾기</button>
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
    			<td><label for="user_rrn1">주민등록번호</label></td>
    			<td>
    				<div id="rrn">
	    				<input type="text" id="user_rrn1" name="user_rrn1" 
	    				minlength="6" maxlength="6" autocomplete="off" onkeypress="CheckNum()" required>
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