<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page errorPage="errorPage.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Edit Name</title>
<link href="css/style_Edit_Pw.css" rel="stylesheet" type="text/css">
</head>
<body>
	<jsp:include page="header.jsp"/>
    <h1 class="title">이름 변경</h1>
	
	<%
		String result = request.getParameter("result");
		if(result==null){
		} else{
		%>
			<script>
			alert("전과 같은 이름을 입력하셨습니다.");
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
			String sql = "select name from member where id ='"+session_id+"'";
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql);
			
			if(rs.next()){
				String name = rs.getString("name");
	%>
	
    <form action="Edit_Name_Process.jsp" method="post">
    	<table class="info_Form">
    		<caption class="bottom">
            	<button class="inputBtn">이름 변경</button>
    		</caption>
    		<tr>
    			<td class="infoTitle">현재 이름</td>
    			<td class="info"><%=name %></td>
    		</tr>
    		<tr>
    			<td><label for="user_name">변경할 이름</label></td>
    			<td>
    				<input type="text" id="user_name" name="user_name" 
    				onkeypress="CheckChar()" autofocus required>
    			</td>
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
    </form>
</body>
</html>