<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page errorPage="errorPage.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Edit Info</title>
<link href="css/style_Ticket_State.css" rel="stylesheet" type="text/css">
</head>
<body>
	<jsp:include page="header.jsp"/>
    <h1 class="title">예매 현황</h1>
	
	<%@ include file="dbconn.jsp" %>
	<%
		String session_id = (String)session.getAttribute("user");
	
		ResultSet rs = null;
		Statement stmt = null;
		
		try{
			String sql = "select * from gntickets where id ='"+session_id+"'";
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql);
			%>
			
			<div class="rgn">
				<form action="Delete_GnTicket.jsp" method="post">
				<fieldset class="rgn_field">
					<legend class="rgn_legend">일반 승차권</legend>
			<%
			if(rs.next()){
				%>
				<table class="gn_table">
					<thead>
						<tr>
							<th>기차 정보</th>
							<th>출발 역</th>
							<th>도착 역</th>
							<th>날짜</th>
							<th>인원정보</th>
							<th>예매 취소</th>
						</tr>
					</thead>
					<tbody>
					<tr>
						<td><%=rs.getString("train_kind")%><br><%=rs.getString("train_no")%></td>
						<td><%=rs.getString("depSt")%><br><%=rs.getString("depTime")%></td>
						<td><%=rs.getString("arrvSt")%><br><%=rs.getString("arrvTime")%></td>
						<td><%=rs.getString("date")%></td>
						<td>어른: <%=rs.getString("adult")%><br>아이: <%=rs.getString("child")%></td>
						<%String gnvalue = rs.getString("num");%>
						<td><button class="cncBtn" name="cancel" value="<%=gnvalue %>">예매 취소</button></td>
					<tr>
				<%
				while(rs.next()){
					String train_kind = rs.getString("train_kind");
					String train_no = rs.getString("train_no");
					String depSt = rs.getString("depSt");
					String depTime = rs.getString("depTime");
					String arrvSt = rs.getString("arrvSt");
					String arrvTime = rs.getString("arrvTime");
					
					gnvalue = rs.getString("num");
					%>
						<tr>
							<td><%=train_kind%><br><%=train_no%></td>
							<td><%=depSt%><br><%=depTime%></td>
							<td><%=arrvSt%><br><%=arrvTime%></td>
							<td><%=rs.getString("date")%></td>
							<td>어른: <%=rs.getString("adult")%><br>어린이: <%=rs.getString("child")%></td>
							<td><button class="cncBtn" name="cancel" value="<%=gnvalue %>">예매 취소</button></td>
						<tr>
					<%
				}
				%>
					</tbody>
				</table>
				<%
			} else{
				out.print("<h1 class='msg'>예매하신 기차가 없습니다.</h1>");
			}
		%>
					</fieldset>
				</form>
			</div>
			<div class="rgn">
				<form action="Delete_RgTicket.jsp" method="post">
				<fieldset class="rgn_field">
					<legend class="rgn_legend">정기 승차권</legend>
		<%	
			stmt.close();
			rs.close();
			sql = "select * from rgtickets where user_id ='"+session_id+"'";
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql);
				
			if(rs.next()){
			%>
				<table class="rg_table">
				<thead>
					<tr>
						<th>기차 정보</th>
						<th>출발 역</th>
						<th>도착 역</th>
						<th>유효 기간</th>
						<th>예매 취소</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td><%=rs.getString("train_kind")%></td>
						<td><%=rs.getString("depSt")%></td>
						<td><%=rs.getString("arrvSt")%></td>
						<td><%=rs.getString("fdate")%><br>~<br><%=rs.getString("ldate")%></td>
						<%String rgvalue = rs.getString("num");%>
						<td><button class="cncBtn" name="cancel" value="<%=rgvalue %>">예매 취소</button></td>
					</tr>
				</tbody>
			<%
				while(rs.next()){
					String train_kind = rs.getString("train_kind");
					String depSt = rs.getString("depSt");
					String arrvSt = rs.getString("arrvSt");
					String fdate = rs.getString("fdate");
					String ldate = rs.getString("ldate");
					
					rgvalue = rs.getString("num");
					%>
						<tr>
							<td><%=train_kind%></td>
							<td><%=depSt%></td>
							<td><%=arrvSt%></td>
							<td><%=fdate%> ~<br><%=ldate%></td>
							<td><button class="cncBtn" name="cancel" value="<%=rgvalue %>">예매 취소</button></td>
						<tr>
					<%
				}
			%>
					</tbody>
				</table>
			</fieldset>
			</form>
		</div>
			<%
			} else{
				out.print("<h1 class='msg'>예매하신 기차가 없습니다.</h1>");
			}
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
	%>
</body>
</html>