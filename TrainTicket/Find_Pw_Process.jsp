<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Find Pw</title>
</head>
<body>
	<!-- DB에 새로운 사용자 정보 저장 -->
 	<%@ include file="dbconn.jsp" %>
	<%
		request.setCharacterEncoding("UTF-8");
		String name = request.getParameter("user_name");
		String id = request.getParameter("user_id");
		String rrn = request.getParameter("user_rrn1") + "-" + request.getParameter("user_rrn2");
	
		ResultSet rs = null;
		Statement stmt = null;
		String find_pw = null;
		
		try{
			String sql = "select * from member where id ='"+id+"'";
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql);
			
			if(rs.next()){
				String rname = rs.getString("name");
				String rrrn = rs.getString("rrn");
				if(name.equals(rname) && rrn.equals(rrrn)){
					find_pw = rs.getString("pw");
				} else if(name.equals(rname)){
					%>
						<jsp:forward page="Find_Pw.jsp">
							<jsp:param name="result" value="frrn"/>
						</jsp:forward>
					<%
				} else{
					%>
						<jsp:forward page="Find_Pw.jsp">
							<jsp:param name="result" value="fname"/>
						</jsp:forward>
					<%
				}
			} else{
				%>
					<jsp:forward page="Find_Pw.jsp">
						<jsp:param name="result" value="fid"/>
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
			<jsp:param name="result" value="find_pw"/>
			<jsp:param name="value" value="<%=find_pw %>"/>
	</jsp:forward>
</body>
</html>