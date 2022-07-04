<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.Collections" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="css/style_TicketGn.css" rel="stylesheet" type="text/css">
</head>
<body>
	<div class="result">
		<form action="Ticket_GnState_Process.jsp" method="post">
			<fieldset class="result_field">
				<legend class="result_legend">
				<%!
				    /* 출발, 도착시간 출력 형식 */
				    public String TimeSet(String time) {
				    	String rTime = time.substring(8, 10) + " : " +time.substring(10, 12);
				    	
				    	return rTime;
				    }
				    
				    /* 가격 출력 형식 */
				    public String PriceSet(String price) {
				    	if(price.length() > 3) {
				    		StringBuffer sb = new StringBuffer(price);
				    		sb.insert(-4, ",");
				    		String rPrice = sb.toString();
				    		return rPrice;
				    	} else {
				    		return price;
				    	}
				    }
				%>
				<%
					request.setCharacterEncoding("UTF-8");
					String train_kind = request.getParameter("train_kind");
					String depStCode = request.getParameter("depStCode");
					String arrvStCode = request.getParameter("arrvStCode");
					String depSt = request.getParameter("depSt");
					String arrvSt = request.getParameter("arrvSt");
					int adult_num = Integer.parseInt(request.getParameter("adult_num"));
					int child_num = Integer.parseInt(request.getParameter("child_num"));
					String date = request.getParameter("date").replace("-","");
					String sdate = request.getParameter("date").replace("-",". ");
					String cnt = request.getParameter("cnt");
					
					out.print(request.getParameter("depSt") +" -> "+request.getParameter("arrvSt"));
				%>	
				</legend>
				<%
					if(cnt.length() > 10){
						out.print(cnt);
					} else{
				%>
				<table class="result_table">
					<caption class="result_cap">*비용 버튼 클릭시 해당 기차가 예매됩니다.</caption>
					<thead>
						<tr>
							<th>열차</th>
							<th>출발</th>
							<th>도착</th>
							<th>비용</th>
						</tr>
					</thead>
					<tbody>
						<jsp:useBean id="trainInfo" class="train.TrainInfo"/>
						<%
							ArrayList<ArrayList<String>> info = trainInfo.getTrainInfo(depStCode, arrvStCode, train_kind, date, cnt);
							
							// 정렬할 key를 지정한다.
					        ArrayList<String> arrSortKey = new ArrayList<String>();
					        
					        // Key에 해당하는 Data를 추출하고, 정렬한다.
					        for( int i=0; i<info.size(); i++) arrSortKey.add(info.get(i).get(2));
					        Collections.sort(arrSortKey);
					        
					        // 정렬된 Key정보를 이용하여 데이터를 추출, 적재한다.
					        for(int i=0; i<arrSortKey.size(); i++){
					            
					            for(int j=0; j<info.size(); j++){
					                
					                if(arrSortKey.get(i).equals(info.get(j).get(2))){
					                	String depTime = TimeSet(info.get(j).get(2));
										String arrvTime = TimeSet(info.get(j).get(3));
										
										String ticket = info.get(j).get(0)+","+info.get(j).get(1)+","+depSt+","+depTime+","+arrvSt+","+arrvTime+","+sdate+","+adult_num+","+child_num;
										
										int value;
										if(info.get(i).get(0).equals("KTX")){
											value = 10000;
										} else{
											value = 5000;
										}
										String price = NumberFormat.getInstance().format(value*adult_num + value/2*child_num);
										
										out.print("<tr><td>"+info.get(j).get(0)+"<br>"+info.get(j).get(1)+"</td><td>"
											+depSt+"<br>"+depTime+"</td><td>"+arrvSt+"<br>"+arrvTime+
											"</td><td><button class='btn' name='gn_ticket' value='"+ticket+"'>"+price+"</button></td></tr>");
										break;
									}
					            }
					        }	
						%>
					</tbody>
				</table>
				<%
					}
				%>
			</fieldset>
		</form>
	</div>
</body>
</html>