<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.time.LocalDate" %>
<%@ page errorPage="errorPage.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Buy Ticket</title>
<link href="css/style_BuyTicket.css" rel="stylesheet" type="text/css">
</head>
<body>
	<jsp:include page="header.jsp"/>
    <h1 class="title">승차권 예매</h1>

	<div id="buyTicketBox">
		<form action="BuyTicket_Process.jsp" method="post" id="buyTickForm">
		     <table id="ticketBox">
		         <tr>
		             <td>
		                 <fieldset id="ticket_kinds">
		                     <legend>승차권 종류</legend>
		                     <label><input type="radio" id="general" name="tck_kinds" value="general" checked>일반</label>
		                     <label><input type="radio" id="regular" name="tck_kinds" value="regular">정기</label>
		                 </fieldset>
		             </td>
		             <td>
		                 <fieldset id="train_kinds">
		                     <legend>열차 종류</legend>
		                     <label><input type="radio" name="train_kind" value="train_all" checked>전체</label>
		                     <label><input type="radio" name="train_kind" value="KTX">KTX</label>
		                     <label><input type="radio" name="train_kind" value="ITX">ITX</label>
		                 </fieldset>
		             </td>
		         </tr>
		         <tr>
		             <td style="vertical-align: top;" rowspan="2">
		                <fieldset id="select_Station">
		                    <legend>역 정보</legend>
		                    <label>출발역</label>
		                    <input type="text" id="depSt" name="depSt" list="stations" required>
		                    <br>
		                    <label>도착역</label>
		                    <input type="text" id="arrvSt" name="arrvSt" list="stations" required>
		                        <datalist id="stations">
		                        	<%@ include file="dbconn.jsp" %>
										<%
											ResultSet rs = null;
											PreparedStatement pstmt = null;
											
											try{
												String sql = "select name from stations";
												pstmt = conn.prepareStatement(sql);
												rs = pstmt.executeQuery();
												
												while(rs.next()){
													String rname = rs.getString("name");
													out.print("<option value='"+rname+"'></option>");
													
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
												if(pstmt != null)
													pstmt.close();
												if(conn != null)
													conn.close();
											}
										%>
									</datalist>
		                </fieldset>
		            </td>
		            <td style="vertical-align: top;">
		                <fieldset id="pp_num">
		                    <legend>인원 정보</legend>
		                    <label for="adult_num">어른</label>
		                    <select id="adult_num" name="adult_num">
		                        <option value="1" selected>1 명</option>
		                        <option value="2">2 명</option>
		                        <option value="3">3 명</option>
		                        <option value="4">4 명</option>
		                        <option value="5">5 명</option>
		                    </select>
		                    <label for="child_num">어린이</label>
		                    <select id="child_num" name="child_num">
		                        <option value="0" selected>0 명</option>
		                        <option value="1">1 명</option>
		                        <option value="2">2 명</option>
		                        <option value="3">3 명</option>
		                        <option value="4">4 명</option>
		                        <option value="5">5 명</option>
		                    </select>
		                </fieldset>
		            </td>
		        </tr>
		        <tr>
		        	<td>
			        	<%
			        		request.setAttribute("minDate", LocalDate.now());
		                    request.setAttribute("maxDate", LocalDate.now().plusMonths(3));
			        	%>
		        		<label id="for_date" for="date">출발 날짜</label>
		        		<input type="date" id="date" name="date" min="${minDate}" max="${maxDate}" required>
		        	</td>
		        </tr>
		    </table>
		    <button id="ticket_chkBtn">조회하기</button>
		</form>
	</div>
	
	<%
		request.setCharacterEncoding("UTF-8");
		String result = request.getParameter("result");
		if(result==null){}
		else if(result.equals("false")){
		%>
			<script>
				alert("없는 역을 입력하셨습니다.");
			</script>
		<%
		} else if(result.equals("same")){
		%>
			<script>
				alert("출발역과 도착역이 같습니다.");
			</script>
		<%	
		}
		else if(result.equals("gn")){
		%>
			<jsp:include page="TicketGn.jsp">
				<jsp:param name="train_kind" value='<%=request.getParameter("train_kind")%>'/>
				<jsp:param name="depStCode" value='<%=request.getParameter("depStCode")%>'/>
				<jsp:param name="arrvCode" value='<%=request.getParameter("arrvStCode")%>'/>
				<jsp:param name="depSt" value='<%=request.getParameter("depSt")%>'/>
				<jsp:param name="arrvSt" value='<%=request.getParameter("arrvSt")%>'/>
				<jsp:param name="adult_num" value='<%=request.getParameter("adult_num")%>'/>
				<jsp:param name="child_num" value='<%=request.getParameter("child_num")%>'/>
				<jsp:param name="date" value='<%=request.getParameter("date")%>'/>
				<jsp:param name="cnt" value='<%=request.getParameter("cnt")%>'/>
			</jsp:include>
		<%
		} else if(result.equals("rg")){
		%>
			<jsp:include page="TicketRg.jsp">
				<jsp:param name="train_kind" value='<%=request.getParameter("train_kind")%>'/>
				<jsp:param name="depSt" value='<%=request.getParameter("depSt")%>'/>
				<jsp:param name="arrvSt" value='<%=request.getParameter("arrvSt")%>'/>
				<jsp:param name="date" value='<%=request.getParameter("date").replace("-",". ")%>'/>
				<jsp:param name="cnt" value='<%=request.getParameter("cnt")%>'/>
			</jsp:include>
		<%
		}
	%>
	
</body>	
</html>