<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page errorPage="errorPage.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>BuyTicket</title>
</head>
<body>
	<%@ include file="dbconn.jsp" %>
	<%
		ResultSet rs = null;
		PreparedStatement pstmt = null;
		
		request.setCharacterEncoding("UTF-8");
		String depSt = request.getParameter("depSt");
		String arrvSt = request.getParameter("arrvSt");
		
		try{
			String sql = "SELECT * FROM stations WHERE name =?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, depSt);
			rs = pstmt.executeQuery();
			
			String depStCode = null;
			String arrvStCode = null;

			if(rs.next()){
				if(depSt.equals(arrvSt)){
					%>
					<jsp:forward page="BuyTicket.jsp">
						<jsp:param name="result" value="same"/>
					</jsp:forward>
					<%
				}
				
				depStCode = rs.getString("code");
				rs.close();
				
				sql = "SELECT * FROM stations WHERE name =?";
				pstmt.setString(1, arrvSt);
				rs = pstmt.executeQuery();
				if(rs.next()){
					arrvStCode = rs.getString("code");
					%>
					<!-- 기차 유무, 기차 수 -->
					<jsp:useBean id="trainCnt" class="train.TrainInfo"/>
					<%
					String kind = request.getParameter("train_kind");
					String date = request.getParameter("date").replace("-","");
					String cnt = null;
					if(kind.equals("train_all")){
						String cnt1 = trainCnt.TrainCnt(depStCode, arrvStCode, date, "00");
						String cnt2 = trainCnt.TrainCnt(depStCode, arrvStCode, date, "08");
						cnt = Integer.toString(Integer.parseInt(cnt1)+Integer.parseInt(cnt2));
					} else if(kind.equals("KTX")){
						cnt = trainCnt.TrainCnt(depStCode, arrvStCode, date, "00");
					} else{
						cnt = trainCnt.TrainCnt(depStCode, arrvStCode, date, "08");
					}
					
					if(cnt.equals("0")){
						cnt = "<h1 class='msg'>직통 기차가 없습니다.</h1>";
					}
					 
					 
					if(request.getParameter("tck_kinds").equals("general")){
						%>
							<jsp:forward page="BuyTicket.jsp">
								<jsp:param name="result" value="gn"/>
								<jsp:param name="depStCode" value="<%=depStCode%>"/>
								<jsp:param name="arrvStCode" value="<%=arrvStCode%>"/>
								<jsp:param name="cnt" value="<%=cnt%>"/>
							</jsp:forward>
						<%
					} else{
						%>
						<jsp:forward page="BuyTicket.jsp">
							<jsp:param name="result" value="rg"/>
							<jsp:param name="depStCode" value="<%=depStCode%>"/>
							<jsp:param name="arrvStCode" value="<%=arrvStCode%>"/>
							<jsp:param name="cnt" value="<%=cnt%>"/>
						</jsp:forward>
					<%
					}
				}
			}
		} catch (SQLException ex){
		%>
			<jsp:forward page="../errorPage.jsp">
				<jsp:param name="errorType" value="<%=ex%>"/>
				<jsp:param name="errorMsg" value="<%=ex.getMessage()%>"/>
			</jsp:forward>
		<%
		} finally{
			if(rs != null)
				rs.close();
			if(pstmt != null)
				pstmt.close();
			if(conn != null)
				conn.close();
		}
	%>
	<jsp:forward page="../BuyTicket.jsp">
		<jsp:param name="result" value="false"/>
	</jsp:forward>
</body>
</html>