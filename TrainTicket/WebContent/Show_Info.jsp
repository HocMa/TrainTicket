<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page errorPage="errorPage.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Show Info</title>
<link href="css/style_Edit_Pw.css" rel="stylesheet" type="text/css">
</head>
<body>
	<jsp:include page="header.jsp"/>
    <h1 class="title">회원 정보 수정</h1>
	
	<%
		String result = request.getParameter("result");
    	if(result==null){}
    	else if(result.equals("trans_name")){
		%>
			<script>
			alert("이름이 변경되었습니다.");
			</script>
		<%	
		} else if(result.equals("trans_pw")){
		%>
			<script>
			alert("비밀번호가 변경되었습니다.");
			</script>
		<%	
		} 
	%>
	
	<%@ include file="dbconn.jsp" %>
	<%
		ResultSet rs = null;
		Statement stmt = null;
		String session_id = (String)session.getAttribute("user");
		try{
			String sql = "select * from member where id ='"+session_id+"'";
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql);
			
			if(rs.next()){
				String id = rs.getString("id");
				String name = rs.getString("name");
				String rrn = rs.getString("rrn");
				String pw = rs.getString("pw");	
	%>
	
   	<table class="info_Form">
   		<tr>
   			<td class="infoTitle">이름</td>
   			<td class="info"><%=name %></td>
   			<td><a href="Edit_Name.jsp"><button class="editBtn">이름 변경</button></a>
   		</tr>
   		<tr>
   			<td class="infoTitle">아이디</td>
   			<td class="info"><%=id %></td>
    		</tr>
   		<tr>
   			<td class="infoTitle">주민등록번호</td>
   			<td class="info"><%=rrn %></td>
   		</tr>
   		<tr>
   			<td></td>
   			<td><a href="Edit_Pw.jsp"><button class="editBtn_Pw">비밀번호 변경</button></a></td>
   			<td><a href="Delete_Member.jsp"><button class="editBtn">회원 탈퇴</button></a></td>
   		</tr>
   	</table>
	<%
			}
		} catch (SQLException ex){
		%>
			<jsp:forward page="errorPage.jsp">
				<jsp:param name="errorType" value="<%=ex%>"/>
				<jsp:param name="errorMsg" value="<%=ex.getMessage()%>"/>
			</jsp:forward>
		<%
		} finally{
			if(rs != null)
				rs.close();
			if(stmt != null)
				stmt.close();
			if(conn != null)
				conn.close();
		}
	%>
</body>
</html>