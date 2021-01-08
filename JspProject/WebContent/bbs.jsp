<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="bbs.BbsDAO"%>
<%@ page import="bbs.Bbs"%>
<%@ page import="java.util.ArrayList"%>

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
		
		int pageNumber = 1;
		if (request.getParameter("pageNumber") != null ){
			pageNumber = Integer.parseInt(request.getParameter("pageNumber"));
		}
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
						<th style="background-color: #eeeeee; text-align: center;">번호</th>
						<th style="background-color: #eeeeee; text-align: center;">제목</th>
						<th style="background-color: #eeeeee; text-align: center;">작성자</th>
						<th style="background-color: #eeeeee; text-align: center;">작성일</th>
					</tr>
				</thead>
				<tbody>
					<%
						BbsDAO bbsDAO = new BbsDAO();
						ArrayList<Bbs> list = bbsDAO.getList(pageNumber);
						for ( int i = 0; i <list.size(); i++){
					%>
					<tr>
						<td><%= list.get(i).getBbsID() %></td>
						<td><a href="view.jsp?bbsID=<%= list.get(i).getBbsID() %>"><%= list.get(i).getBbsTitle() %></a></td>
						<!-- 게시글 번호를 기반으로 view.jsp에 파라미터를 넘겨줌으로써 게시글을 클릭할시 고유값을 가진채로 글제목과 관련된 view.jsp로 넘어간다. -->
						<td><%= list.get(i).getUserID() %></td>
						<td><%= list.get(i).getBbsDate().substring(0, 11) + list.get(i).getBbsDate().substring(11,13) + "시" + list.get(i).getBbsDate().substring(14,16) + "분"  %></td>
						<!-- substring을 이용해서 데이터베이스에 원초적인 시간이 아니라 가독성이 좋게 절삭해준다. -->
					</tr>
					<%
						}
					%>
				</tbody>
			</table>

			<%
				if(pageNumber != 1) {
			%>
			<a href="bbs.jsp?pageNumber=<%=pageNumber - 1 %>"
				class="btn btn-success btn-arraw-left">이전</a>
			<%
				} if (pageNumber == 1) {
			%>
			<a href="bbs.jsp?pageNumber=<%=pageNumber + 1 %>"
				class="btn btn-success btn-arraw-left">다음</a>
			<% 
				}
			%>
			<a href="write.jsp" class="btn btn-primary pull-right">글쓰기</a>
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