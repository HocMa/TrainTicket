<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>LogIn</title>
</head>
<body>
 	<%@ include file="dbconn.jsp" %>
	<%
		request.setCharacterEncoding("UTF-8");
		String id = request.getParameter("user_id");
		String pw = request.getParameter("user_pw");
	
		ResultSet rs = null;
		Statement stmt = null;

		try{
			String sql = "select id, pw from member where id = '"+id+"'";
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql);

			if(rs.next()){
				String rpw = rs.getString("pw");
				if(!pw.equals(rpw)){
					%>
					<jsp:forward page="Login.jsp">
						<jsp:param name="result" value="fail_login_pw"/>
						<jsp:param name="value1" value="<%=pw %>"/>
						<jsp:param name="value2" value="<%=rpw %>"/>
					</jsp:forward>
				<%
				}
			} else{
				%>
					<jsp:forward page="Login.jsp">
						<jsp:param name="result" value="fail_login_id"/>
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
	session.setAttribute("user", id);
	
	//로그인 시간 제한
	session.setMaxInactiveInterval(20*60);
	response.sendRedirect("Main.jsp");
	%>
</body>
</html>