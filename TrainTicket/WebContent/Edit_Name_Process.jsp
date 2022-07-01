<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Edit Name</title>
</head>
<body>
	<%@ include file="dbconn.jsp" %>
	<%
		request.setCharacterEncoding("UTF-8");
		String name = request.getParameter("user_name");
		String session_id = (String)session.getAttribute("user");
	
		ResultSet rs = null;
		Statement stmt = null;
		
		try{
			String sql = "select name from member where id ='"+session_id+"'";
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql);
			
			if(rs.next()){
				String rname = rs.getString("name");
				
				if(name.equals(rname)){
					%>
						<jsp:forward page="Edit_Name.jsp">
							<jsp:param name="result" value="f"/>
						</jsp:forward>
					<%
				} else{
					stmt.close();
					sql = "update member set name='"+name+"' where id='"+session_id+"'";
					stmt = conn.createStatement();
					stmt.executeUpdate(sql);
				}
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
		<jsp:forward page="Show_Info.jsp">
			<jsp:param name="result" value="trans_name"/>
		</jsp:forward>
</body>
</html>