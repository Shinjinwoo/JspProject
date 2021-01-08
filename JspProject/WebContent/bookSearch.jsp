<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>여기에 제목을 입력하십시오</title>
<link rel="stylesheet" href="css/bootstrap.css">
<link rel="stylesheet" href="css/custom.css">
<script src="https://code.jquery.com/jquery-3.5.1.js"
	integrity="sha256-QWo7LDvxbWT2tbbQ97B53yJnYU3WhH/C8ycbRAkjPDc="
	crossorigin="anonymous"></script>
<script src="js/bootstrap.min.js"></script>
</head>
<body>
	<%
		String userID = null;
		if (session.getAttribute("userID") != null ) {
			userID = (String) session.getAttribute("userID");
			// 현재 세션이 존재하는 유저라면 아이디값을 받아서 관리하도록 수행
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
	<div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
		<ul class="nav navbar-nav">
			<li><a href="main.jsp">메인</a></li>
			<li><a href="bbs.jsp">게시판</a></li>
			<li class="active"><a href="bookSearch.jsp">도서정보 찾기</a>
			<li><a href="cute.jsp">팽 ㅡ 수 </a>
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
		<div class="jumbotron">
			<div class="container">
				<h1>도서 정보 찾기</h1>
				<input id="bookname" value="" type="text">
				<button id="search">검색</button>
				<p align="left"></p>
			</div>
		</div>
	</div>





	<script>
	$(document).ready(function (){
		$('#search').click(function() {
			$.ajax({
				method : "GET",
				url : "https://dapi.kakao.com/v3/search/book?target=title",
				data : {query: $('#bookname').val() },
				headers : {Authorization: "KakaoAK e0f18d41020bcbf811eb9f4abc94056d" }
			}).done(function(msg) {
				console.log(msg);
				console.log(msg.documents[0].title);
				console.log(msg.documents[0].thumbnail);
				console.log(msg.documents[0].authors);
				console.log(msg.documents[0].contents);
				console.log(msg.documents[0].price);
				console.log(msg.documents[0].url);
				console.log(msg.documents[0].publisher);
				
				$( "p" ).append("<br><br><br><img src='"+msg.documents[0].thumbnail+"'/><br><br>");
				$( "p" ).append("<strong>"+"책 제목 : "+msg.documents[0].title+"</strong><br><br>");
				$( "p" ).append("<strong>"+" 저자 : "+msg.documents[0].authors+"</strong><br>");
				$( "p" ).append("<strong>"+" 출판사 : "+msg.documents[0].publisher+"</strong><br>");
				$( "p" ).append("<strong>"+" 가격 : "+msg.documents[0].price+"원"+"</strong><br><br>");
				$( "p" ).append("<strong>"+" 내용 : "+msg.documents[0].contents+"</strong><br><br>");
				$( "p" ).append("<strong>"+" 구매링크 : <a href ="+msg.documents[0].url+"> 구매하기 </a></strong><br>");
				
			})
		})
	});

	</script>

</body>
</html>