<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="board.model.BoardDTO"%>
<%@ page errorPage="../errorPage.jsp" %>
<%
	String session_Id = (String) session.getAttribute("user");
	BoardDTO notice = (BoardDTO) request.getAttribute("board");
	int num = ((Integer) request.getAttribute("num")).intValue();
	int nowpage = ((Integer) request.getAttribute("page")).intValue();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Board</title>
<link href="css/style_Board_view.css" rel="stylesheet" type="text/css">
</head>
<body>
	<jsp:include page="../header.jsp"/>
	<h1 class="title">공지사항</h1>
	
	<div>
	<%
		if(session_Id == null || !session_Id.equals("admin")){
	%>
		<table class="board">
			<caption class="boardCap">
				<a href="./BoardListAction.do?pageNum=<%=nowpage%>">목록</a>
			</caption>
			<tr>
				<td>제목:&nbsp;<span class="ttl"><%=notice.getSubject()%></span></td>
			</tr>
			<tr>
				<td>내용</td>
			</tr>
			<tr>
				<td><%=notice.getContent()%></td>
			</tr>
		</table>
	<%
		} else{
	%>		
		<form name="newUpdate" action="BoardUpdateAction.do?num=<%=notice.getNum()%>&pageNum=<%=nowpage%>"
		 method="post">
			<table class="board">
				<caption class="boardCap">
					<a href="./BoardListAction.do?pageNum=<%=nowpage%>">목록</a>&nbsp;
					<button>수정</button>&nbsp;
					<a	href="./BoardDeleteAction.do?num=<%=notice.getNum()%>&pageNum=<%=nowpage%>">삭제</a>
				</caption>
				<tr>
					<td>
						<label for="sub">제목</label>&nbsp;
						<input type="text" name="subject" id="sub" value=" <%=notice.getSubject()%>" >
					</td>
				</tr>
				<tr>
					<td><label for="cntt">내용</label></td>
				</tr>
				<tr>
					<td><textarea name="content" id="cntt" cols="50" rows="5"> <%=notice.getContent()%></textarea></td>
				</tr>
			</table>
		</form>
	<%
		}
	%>
	</div>
</body>
</html>