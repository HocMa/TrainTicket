<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Ticket GnState</title>
</head>
<body>
	<%@ include file="dbconn.jsp" %>
	<%
		request.setCharacterEncoding("UTF-8");
		String session_id = (String)session.getAttribute("user");
		String[] ticket = request.getParameter("gn_ticket").split(",");
		
		PreparedStatement pstmt = null;
		
		try{
			String sql = "insert into gntickets value(?,?,?,?,?,?,?,?,?,?)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, session_id);
			pstmt.setString(2, ticket[0]);
			pstmt.setString(3, ticket[1]);
			pstmt.setString(4, ticket[2]);
			pstmt.setString(5, ticket[3]);
			pstmt.setString(6, ticket[4]);
			pstmt.setString(7, ticket[5]);
			pstmt.setString(8, ticket[6]);
			pstmt.setString(9, ticket[7]);
			pstmt.setString(10, ticket[8]);
			pstmt.executeUpdate();
		} catch (SQLException ex){
		%>
			<jsp:forward page="errorPage.jsp">
				<jsp:param name="errorType" value="<%=ex%>"/>
				<jsp:param name="errorMsg" value="<%=ex.getMessage()%>"/>
			</jsp:forward>
		<%
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