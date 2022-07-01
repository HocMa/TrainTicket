<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="board.model.BoardDTO"%>
<%@ page errorPage="../errorPage.jsp" %>
<%
	String session_Id = (String) session.getAttribute("user");
	List<BoardDTO> boardList = (List) request.getAttribute("boardlist");
	int total_record = ((Integer) request.getAttribute("total_record")).intValue();
	int pageNum = ((Integer) request.getAttribute("pageNum")).intValue();
	int total_page = ((Integer) request.getAttribute("total_page")).intValue();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Board</title>
<link href="css/style_Board_list.css" rel="stylesheet" type="text/css">
</head>
<body>
	<jsp:include page="../header.jsp"/>
	<h1 class="title">공지사항</h1>
	<form action="./BoardListAction.do" method="post">
		<div>
			<p class="total" align="right">전체 <%=total_record %>건</p>
			<hr>
			<%
				if(boardList.size() == 0){
			%>
					<h1 align="center">게시글이 없습니다.</h1>
			<%
				} else{
			%>
			<table class="board_table">
				<thead>
					<tr>
						<th>번호</th>
						<th>제목</th>
						<th>작성일</th>
						<th>조회수</th>
					</tr>
				</thead>
				<tbody>
					<%
						for(int i=0; i< boardList.size(); i++){
							BoardDTO notice = boardList.get(i);
					%>
						<tr>
							<td><%=notice.getNum() %></td>
							<td><a href="./BoardViewAction.do?num=<%=notice.getNum()%>&pageNum=<%=pageNum%>"><%=notice.getSubject()%></a></td>
							<td><%=notice.getRegist_day() %></td>
							<td><%=notice.getHit() %></td>
						</tr>
					<%
						}
					%>
				</tbody>
			</table>
			<%
				}
			%>
		</div>
		<div class="page">
			<%
				for(int i=1; i<=total_page; i++){
			%>
					<a href="./BoardListAction.do?pageNum=<%=i %>">
			<%
					if(pageNum == i){
						out.print("<b>["+i+"]</b>");
					}else{
						out.print("["+i+"]");
					}
			%>
					</a>
			<%
				}
			%>
		</div>
		<div>
			<table class="search">
				<tr>
					<td>
						<select name="items" class="txt">
								<option value="subject">제목에서</option>
								<option value="content">본문에서</option>
						</select>
						<input name="text" type="text" />
						<input type="submit" value="검색 "/>
					</td>
					<%
						if(session_Id == null || !session_Id.equals("admin")){
					%>
							<td width="150px" align="right" class="hidden">
								<a href="./BoardWriteForm.do">&laquo;글쓰기</a>
							</td>
					<%
						} else{
					%>
							<td width="150px" align="right">
								<a href="./BoardWriteForm.do">&laquo;&nbsp;글쓰기</a>
							</td>
					<%
						}
					%>
				</tr>
			</table>
		</div>
	</form>
</body>
</html>