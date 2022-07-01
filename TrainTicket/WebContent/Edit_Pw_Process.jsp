<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Edit Pw</title>
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
			String sql = "select pw from member where id ='"+session_id+"'";
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql);
			
			if(rs.next()){
				String rpw = rs.getString("pw");
				
				if(pw.equals(rpw)){
					%>
						<jsp:forward page="Edit_Pw.jsp">
							<jsp:param name="result" value="f"/>
						</jsp:forward>
					<%
				} else{
					stmt.close();
					sql = "update member set pw='"+pw+"' where id='"+session_id+"'";
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
			<jsp:param name="result" value="trans_pw"/>
		</jsp:forward>
</body>
</html>