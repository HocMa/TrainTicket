<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Delete RgTicket</title>
</head>
<body>
	<%@ include file="dbconn.jsp" %>
	<%
		request.setCharacterEncoding("UTF-8");
		String[] rdata = request.getParameter("cancel").split(",");
		String train_kind = rdata[0];
		String depSt = rdata[1];
		String arrvSt = rdata[2];
		String fdate = rdata[3];
		String ldate = rdata[4];
		
		ResultSet rs = null;
		Statement stmt = null;
		
		try{
			String sql = "delete from rgtickets where train_kind='"+train_kind+"' and depSt='"
		+depSt+"'and arrvSt='"+arrvSt+"' and fdate='"+fdate+"'and ldate='"+ldate+"'";
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