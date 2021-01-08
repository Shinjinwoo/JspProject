<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="bbs.Bbs"%>
<%@ page import="bbs.BbsDAO"%>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width" , initial-scale="1">
<!-- 컴퓨터,핸드폰에 맞게 디자인들의 사이즈가 유동적으로 변하는 부트스랩을 위해 메타태그를 삽입  -->
<link rel="stylesheet" href="css/bootstrap.css">
<link rel="stylesheet" href="css/custom.css">
<!-- 디자인을 담당하는 CSS를 참조  -->
<title>신진우 연말 프로젝트</title>
</head>
<body>
	<%
		String userID = null;
		if (session.getAttribute("userID") != null ) {
			userID = (String) session.getAttribute("userID");
			// 현재 세션이 존재하는 유저라면 아이디값을 받아서 관리하도록 수행
		}
		
		int bbsID = 0;
		if (request.getParameter("bbsID") != null) {
			bbsID = Integer.parseInt(request.getParameter("bbsID"));
		}
		
		if (bbsID == 0) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('유효하지 않은 글입니다.')");
			script.println("location.href = 'bbs.jsp'");
			script.println("</script>");
		}
		
		Bbs bbs = new BbsDAO().getBbs(bbsID);
		
	%>
	<nav class="navbar navbar-default">
		<div class="navbar-header">
			<button type="button" class="navbar-toggle collapse"
				data-toggle="collapse" data-target="#bs-example-navbar-collapse-1"
				aria-expanded="false">
				<span class="icon-bar"></span> <span class="icon-bar"></span> <span
					class="icon-bar"></span>

			</button>
			<a class="navbar-brand" href="main.jsp">신진우 연말 프로젝트</a>
		</div>
		<div class="collapse navbar-collapse"
			id="bs-example-navbar-collapse-1">
			<ul class="nav navbar-nav">
				<li><a href="main.jsp">메인</a></li>
				<li class="active"><a href="bbs.jsp">게시판</a></li>
				<li><a href="bookSearch.jsp">도서정보 찾기</a>
				<li><a href="cute.jsp">펭 ㅡ 수 </a>
			</ul>
			<%
				if(userID == null) {
					/* 로그인을 하지 않은 사람의 경우에만 접속하기 드랍다운이 나오게 조건문으로 처리해준다.  */
				
			%>
			<ul class="nav navbar-nav navbar-right">
				<li class="dropdown"><a href="#" class="dropdown-toggle"
					data-toggle="dropdown" role="button" aria-haspopup="true"
					aria-expanded="false">접속하기 <span class="caret"></span></a>
					<ul class="dropdown-menu">
						<li><a href="login.jsp">로그인</a></li>
						<li><a href="join.jsp">회원가입</a></li>
					</ul></li>
			</ul>

			<%
			
				} else {
				/* 로그인을 한 사람에게만 보이도록 로그아웃 버튼이 포함된 회원관리 드랍다운을 보이게 만든다. */
					
			%>

			<ul class="nav navbar-nav navbar-right">
				<li class="dropdown"><a href="#" class="dropdown-toggle"
					data-toggle="dropdown" role="button" aria-haspopup="true"
					aria-expanded="false">회원관리 <span class="caret"></span></a>
					<ul class="dropdown-menu">
						<li><a href="logoutAction.jsp">로그아웃</a></li>
					</ul></li>
			</ul>

			<%
				}
			
			%>
		</div>
	</nav>
	<div class="container">
		<div class="row">
			<table class="table table-striped"
				style="text-align: center; border: 1px solid #dddddd">
				<!-- 홀수 짝수마다 색깔을 변하게 해주는 디자인적인 요소를 넣어준 테이블 형식으로 게시판의 틀을 만듬  -->
				<thead>
					<tr>
						<th colspan="3"
							style="background-color: #eeeeee; text-align: center;">게시판
							글보기</th>

					</tr>
				</thead>
				<tbody>
					<tr>
						<td style="width: 20%">글제목</td>
						<td colspan="2"><%= bbs.getBbsTitle().replaceAll(" ","&nbsp;").replaceAll("<", "&lt;").replaceAll(">","&gt;").replaceAll("\n","<br>") %></td>
					</tr>
					<tr>
						<td style="width: 20%">작성자</td>
						<td colspan="2"><%= bbs.getUserID() %></td>
					</tr>
					<tr>
						<td>작성일자</td>
						<td colspan="2"><%= bbs.getBbsDate().substring(0, 11) + bbs.getBbsDate().substring(11,13) + "시" + bbs.getBbsDate().substring(14,16) + "분"  %></td>
					</tr>
					<tr>
						<td style="width: 20%">내용</td>
						<td colspan="2" style="min-height: 200px; text-align: left;"><%= bbs.getBbsContent().replaceAll(" ","&nbsp;")
						.replaceAll("<", "&lt;").replaceAll(">","&gt;").replaceAll("\n","<br>") %></td>
						<!-- 특수문자 처리로 게시글의 내용이 공백이나 특수문자를 읽어올수있게 보여줌 -->
					</tr>
				</tbody>
			</table>
			<a href="bbs.jsp" class="btn btn-primary">목록 </a>

			<%
				if(userID != null && userID.equals(bbs.getUserID())) { %>
			<a href="update.jsp?bbsID=<%=bbsID %>" class="btn btn-primary">수정</a>
			<a onclick="return confirm ('정말로 삭제 하시겠습니까 ?')"
				href="deleteAction.jsp?bbsID=<%=bbsID %>" class="btn btn-primary">삭제</a>
			<!-- 해당 게시글의 작성자가 본인이라면 수정과 삭제가 가능하게 조건문으로 구분  -->
			<% 
			}
			%>
			<input type="submit" class="btn btn-primary pull-right" value="글쓰기">
			<!-- 글쓰기 버튼이 오른쪽 정렬로 보여지도록 디자인 -->

		</div>
	</div>


	<!-- 웹사이트의 전반적인 구성을 알려주는 네비게이션 바 이다. -->
	<script
		src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
	<script src="js/bootstrap.min.js"></script>
	<!-- 동적인 다자인을 위해 애니매이션을 담당할 자바 스크립트들을 넣어준다.  -->

</body>
</html>