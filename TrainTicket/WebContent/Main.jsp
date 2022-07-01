<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page errorPage="errorPage.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Main</title>
<link href="css/style_Main.css" rel="stylesheet" type="text/css">
</head>
<body>
	<!-- 메인 메뉴 -->
	<jsp:include page="header.jsp"/>
	
	<%
		String result = request.getParameter("result");
		if(result==null){
		} else{
		%>
			<script>
			alert("회원 탈퇴가 완료되었습니다.");
			</script>
		<%	
		}
	%>
	
	<!-- 메인 슬라이드 -->
	<div id="slideShow">
        <div class="inner_list">
			<div class="inner">
				<img src="css/images/slide0.jpg" alt="Train Picture">
			</div>
			<div class="inner">
				<img src="css/images/slide1.jpg" alt="Train Picture">
			</div>
			<div class="inner">
				<img src="css/images/slide2.jpg" alt="Train Picture">
			</div>
			<div class="inner">
				<img src="css/images/slide3.jpg" alt="Train Picture">
			</div>
		</div>
        <ul class="slideState">
            <button class="beforeBtn"><</button>
            <li class="on"></li>
            <li></li>
            <li></li>
            <li></li>
            <button class="nextBtn">></button>
        </ul> 
    </div>
    
    <!--공지사항-->
    <div id="announce">
        <fieldset>
            <legend>공지사항</legend>
            <table id="anc">
            	<caption class="bottom"><a href="./BoardListAction.do" id="toAnc">+더보기</a></caption>
            	<%@ include file="dbconn.jsp" %>
            	<%
	            	ResultSet rs = null;
	        		Statement stmt = null;
	        		
	        		try{
	        			String sql = "SELECT * FROM board ORDER BY num DESC limit 6";
	        			stmt = conn.createStatement();
	        			rs = stmt.executeQuery(sql);
	
	        			while(rs.next()){
	        			%>
							<tr>
								<td><a href="./BoardViewAction.do?num=<%=rs.getString("num")%>&pageNum=1">※&nbsp;<%=rs.getString("subject")%></a></td>
								<td><%=rs.getString("regist_day") %></td>
							</tr>
						<%
	        			}
	        		} catch (SQLException ex){
	        			// 에러페이지
	        		} finally{
	        			if(rs != null)
	        				rs.close();
	        			if(stmt != null)
	        				stmt.close();
	        			if(conn != null)
	        				conn.close();
	        		}
            	%>
            </table>
        </fieldset>
    </div>
        
    <!--로그인-->
    <div id="member">
    <%
	    String userChk = (String)session.getAttribute("user");
		
		if(userChk == null){
			%>
			<form action="Login_Process.jsp" method="post">
	            <fieldset id="memberLogIn">
	                <legend>회원 로그인</legend>
	                <table id="login_form">
	                    <caption class="bottom">
	                        <ul>
	                            <li><a href="Find_Id.jsp">아이디 찾기</a></li>
	                            <li><a href="Find_Pw.jsp">비밀번호 찾기</a></li>
	                            <li><a href="Signup.jsp">회원가입</a></li>
	                        </ul>
	                    </caption>
	                    <tr>
	                        <td>
	                            <input type="text" id="user_id" name="user_id" 
	                            minlength="4" maxlength="10" placeholder="아이디" onkeypress="CheckSpecial()" required>
	                        </td>
	                        <td rowspan="2">
	                            <button id="logIn">로<br>그<br>인</button>
	                        </td>
	                    </tr>
	                    <tr>
	                        <td>
	                            <input type="password" id="user_pw" name="user_pw" 
	                            minlength="6" maxlength="12" placeholder="비밀번호" required>
	                        </td>
	                    </tr>
	                </table>
	            </fieldset>
	        </form>
			<%
		} else{
    	%>
	    	<form action="delete_session.jsp" method="post">
	            <fieldset id="memberLogIn">
	                <legend>회원 정보</legend>
	                <table id="logout_form">
	                    <tr>
	                        <td>
	                            <h1><%=userChk %>님</h1>
	                        </td>
	                        <td rowspan="2">
	                            <button id="logout">로<br>그<br>아<br>웃</button>
	                        </td>
	                    </tr>
	                    <tr>
	                        <td>
	                            <h1>환영합니다!!</h1>
	                        </td>
	                    </tr>
	                </table>
	            </fieldset>
	        </form>
    <%
		}
    %>
        
    </div>
</body>
</html>