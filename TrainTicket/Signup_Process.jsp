<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Sign Up</title>
</head>
<body>
	<!-- DB에 새로운 사용자 정보 저장 -->
 	<%@ include file="dbconn.jsp" %>
	<%
		request.setCharacterEncoding("UTF-8");
		String name = request.getParameter("user_name");
		String id = request.getParameter("user_id");
		String rrn = request.getParameter("user_rrn1") + "-" + request.getParameter("user_rrn2");
		String pw = request.getParameter("user_pw");
	
		ResultSet rs = null;
		Statement stmt = null;
		
		try{
			String sql = "select id from member where id ='"+id+"'";
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql);

			if(rs.next()){
				%>
					<jsp:forward page="Signup.jsp">
						<jsp:param name="result" value="fid"/>
					</jsp:forward>
				<%
			} else{
				stmt.close();
				rs.close();
				sql = "select rrn from member where rrn ='"+rrn+"'";
				stmt = conn.createStatement();
				rs = stmt.executeQuery(sql);
				
				if(rs.next()){
					%>
						<jsp:forward page="Signup.jsp">
							<jsp:param name="result" value="frrn"/>
						</jsp:forward>
					<%
				} else{
					sql = "INSERT INTO member VALUES('"+id+"', '"+name+"', '"+rrn+"', '"+pw+"')";
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
	<jsp:forward page="Login.jsp">
			<jsp:param name="result" value="signup_scs"/>
	</jsp:forward>
</body>
</html>