<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page errorPage="errorPage.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="css/style_header.css" rel="stylesheet" type="text/css">
<script src="js/jquery.js" type="text/javascript"></script>
<script src="js/Main.js"></script>
</head>
<body>
	<header>
        <table>
            <tr>
            	<td>
       			<a href="Main.jsp"><button id="toMain">HOME</button></a>
       			</td>
                <%
	                String userChk = (String)session.getAttribute("user");
	            	
	        		if(userChk == null){
	        			%>
	        			<td>
		                    <a href="Login.jsp"><button id="toBuyTicket">승차권 예매</button></a>
		                </td>
		                <td>
		                    <a href="Login.jsp"><button id="toTicketState">예매 현황</button></a>
		                </td>
		                <td>
		                    <a href="Login.jsp"><button id="toMemberModify">회원 정보 수정</button></a>
		                </td>
	        			<%
	        		} else{
	        			%>
	        			<td>
		                    <a href="BuyTicket.jsp"><button id="toBuyTicket">승차권 예매</button></a>
		                </td>
		                <td>
		                    <a href="Ticket_State.jsp"><button id="toTicketState">예매 현황</button></a>
		                </td>
		                <td>
		                    <a href="Show_Info.jsp"><button id="toMemberModify">회원 정보 수정</button></a>
		                </td>
	        			<%
	        		}
                %>
            </tr>
        </table>
    </header>
</body>
</html>