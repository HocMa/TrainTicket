<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.time.LocalDate" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Ticket RgState Process</title>
</head>
<body>
	<%@ include file="dbconn.jsp" %>
	<%
		request.setCharacterEncoding("UTF-8");
		String session_id = (String)session.getAttribute("user");
		String[] ticket = request.getParameter("rg_ticket").split(",");
		
		PreparedStatement pstmt = null;
		
		try{
			String sql = "insert into rgtickets value(?,?,?,?,?,?)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, session_id);
			pstmt.setString(2, ticket[0]);
			pstmt.setString(3, ticket[1]);
			pstmt.setString(4, ticket[2]);
			pstmt.setString(5, ticket[3]);

	        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy. MM. dd");
	        LocalDate rdate = LocalDate.parse(ticket[3], formatter).plusDays(Integer.parseInt(ticket[4]));
			String date = rdate.format(formatter);
			
			pstmt.setString(6, date);
			pstmt.executeUpdate();
		} catch (SQLException ex){
		%>
			<jsp:forward page="errorPage.jsp">
				<jsp:param name="errorType" value="<%=ex%>"/>
				<jsp:param name="errorMsg" value="<%=ex.getMessage()%>"/>
			</jsp:forward>
		<%;
		} finally{
			if(pstmt != null)
				pstmt.close();
			if(conn != null)
				conn.close();
		}
	response.sendRedirect("Ticket_State.jsp");
	%>
</body>
</html>