<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Delete Member</title>
</head>
<body>
	<%@ include file="dbconn.jsp" %>
	<%
		request.setCharacterEncoding("UTF-8");
		String pw = request.getParameter("user_pw");
		String session_id = (String)session.getAttribute("user");
		
		ResultSet rs = null;
		Statement stmt = null;
		
		try{
			String sql = "select pw from member where id ='"+session_id+"' and pw='"+pw+"'";
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql);
			
			if(rs.next()){
				stmt.close();
				sql = "delete from member where id ='"+session_id+"'";
				stmt = conn.createStatement();
				stmt.executeUpdate(sql);
			} else{
				%>
					<jsp:forward page="Delete_Member.jsp">
						<jsp:param name="result" value="fpasswd"/>
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
		session.removeAttribute("user");
		%>
		<jsp:forward page="Main.jsp">
			<jsp:param name="result" value="true"/>
		</jsp:forward>
</body>
</html>