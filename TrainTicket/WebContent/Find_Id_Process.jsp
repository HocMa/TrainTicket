<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Find Id</title>
</head>
<body>
	<!-- DB에 새로운 사용자 정보 저장 -->
 	<%@ include file="dbconn.jsp" %>
	<%
		request.setCharacterEncoding("UTF-8");
		String name = request.getParameter("user_name");
		String rrn = request.getParameter("user_rrn1") + "-" + request.getParameter("user_rrn2");
	
		ResultSet rs = null;
		Statement stmt = null;
		String find_id = null;
		
		try{
			String sql = "select id, name, rrn from member where name ='"+name+"' and rrn = '"+rrn+"'";
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql);
			
			if(rs.next()){
				find_id = rs.getString("id");
			} else{
				%>
					<jsp:forward page="Find_Id.jsp">
						<jsp:param name="result" value="fail"/>
					</jsp:forward>
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
	<jsp:forward page="Login.jsp">
			<jsp:param name="result" value="find_id"/>
			<jsp:param name="value" value="<%=find_id %>"/>
	</jsp:forward>
</body>
</html>