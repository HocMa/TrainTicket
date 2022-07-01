<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page errorPage="../errorPage.jsp" %>
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
		<form name="newWrite" action="./BoardWriteAction.do" method="post">
			<table class="board">
				<caption class="boardCap">
					<button>등록</button>&nbsp;
					<a href="./BoardListAction.do">목록</a>&nbsp;
					<button type="reset">취소</button>
				</caption>
				<tr>
					<td>
						<label for="sub">제목</label>&nbsp;
						<input type="text" name="subject" id="sub" placeholder="subject">
					</td>
				</tr>
				<tr>
					<td><label for="cntt">내용</label></td>
				</tr>
				<tr>
					<td><textarea name="content" id="cntt" cols="50" rows="5" placeholder="content"></textarea></td>
				</tr>
			</table>
		</form>
	</div>
</body>
</html>