<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="css/style_TicketGn.css" rel="stylesheet" type="text/css">
<style>
	button{
		width:100px;
		height:50px;
		font-size:25px;
		font-weight:600;
	}
	td:first-child{
		width:100px;
	}
	td:not(:first-child){
		width:150px;
	}
</style>
</head>
<body>
	<div class="result">
		<form action="Ticket_RgState_Process.jsp" method="post">
			<fieldset class="result_field">
				<legend class="result_legend">
				<%
					request.setCharacterEncoding("UTF-8");
					String depSt = request.getParameter("depSt");
					String arrvSt = request.getParameter("arrvSt");
					String date = request.getParameter("date");
					String train = request.getParameter("train_kind");
				
					out.print(depSt +" <-> "+arrvSt);
				%>
				</legend>

				<%
					String cnt = request.getParameter("cnt");
					
					if(cnt.length() > 10){
						out.print(cnt);
					} else{
						%>
						<figure>
						<table class="result_table">
						<caption class="result_cap">*비용 버튼 클릭시 해당 기차가 예매됩니다.</caption>
						<thead>
							<tr>
								<th>열차</th>
								<th>15일</th>
								<th>한 달</th>
							</tr>
						</thead>
						<tbody>
						<%
							String ticketK_1 = "KTX,"+depSt+","+arrvSt+","+date+","+"15";
							String ticketK_2 = "KTX,"+depSt+","+arrvSt+","+date+","+"30";
							String ticketI_1 = "ITX,"+depSt+","+arrvSt+","+date+","+"15";
							String ticketI_2 = "ITX,"+depSt+","+arrvSt+","+date+","+"30";
						
							if(train.equals("train_all")){
						%>
							<tr>
								<td>KTX</td>
								<td><button class="btn" name="rg_ticket" value="<%=ticketK_1%>">30,000</button></td>
								<td><button class="btn" name="rg_ticket" value="<%=ticketK_2%>">60,000</button></td>
							</tr>
							<tr>
								<td>ITX</td>
								<td><button class="btn" name="rg_ticket" value="<%=ticketI_1%>">15,000</button></td>
								<td><button class="btn" name="rg_ticket" value="<%=ticketI_2%>">30,000</button></td>
							</tr>
						<%
							;}else{
								if(train.equals("KTX")){
									%>
										<tr>
											<td>KTX</td>
											<td><button class="btn" name="rg_ticket" value="<%=ticketK_1%>">30,000</button></td>
											<td><button class="btn" name="rg_ticket" value="<%=ticketK_2%>">60,000</button></td>
										</tr>
									<%
								} else{
									%>
										<tr>
											<td>ITX</td>
											<td><button class="btn" name="rg_ticket" value="<%=ticketI_2%>">15,000</button></td>
											<td><button class="btn" name="rg_ticket" value="<%=ticketI_1%>">30,000</button></td>
										</tr>
									<%
								}
							}
						%>
						</tbody>
					</table>
					<figcaption class="result_figcap">시작일: <%=date %></figcaption>
					</figure>
					<%
					}
				%>
			</fieldset>
		</form>
	</div>
</body>
</html>