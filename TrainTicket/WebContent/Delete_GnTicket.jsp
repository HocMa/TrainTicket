<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Delete GnTicket</title>
</head>
<body>
	<%@ include file="dbconn.jsp" %>
	<%
		request.setCharacterEncoding("UTF-8");
		String num = request.getParameter("cancel");
		
		ResultSet rs =null;
		Statement stmt = null;
		
		try{
			String sql = "delete from gntickets where num='"+num+"'";
			stmt = conn.createStatement();
			stmt.executeUpdate(sql);
		} catch(SQLException ex){
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
		response.sendRedirect("Ticket_State.jsp");
	%>
</body>
</html>