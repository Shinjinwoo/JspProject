<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter"%>
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
				<li class="active"><a href="main.jsp">메인</a></li>
				<li><a href="bbs.jsp">게시판</a></li>
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
		<div class="jumbotron">
			<div class="container">
				<h1>웹 사이트 소개</h1>
				<p>
					신진우의 홈페이지 입니다.부트스트랩을 프론트엔드로 하여 <br> MVC로 게시판의 CRUD와
					회원가입,로그인,로그아웃을 구현했습니다. <br> 또한 추가로 지도 API와 Daum검색 API를 사용해
					도서정보 찾기 기능과 학원 위치를 표시하였습니다
				</p>
				<p>현재 다니는 학원은 더조은 아카데미 입니다.</p>
				<a class="btn btn-primary btn-pull" href="http://www.tjoeun.co.kr/"
					role="button"> 더조은 알아보기 </a><br>
				<br>

				<p>위치 : 강남역 5번출구 도보 5분 송림빌딩 13층</p>
				<div id="map" style="width: 500px; height: 400px;"></div>
			</div>
		</div>
	</div>


	<script type="text/javascript"
		src="//dapi.kakao.com/v2/maps/sdk.js?appkey=6156c5358e30cb4c03d6089354741f42"></script>

	<script>
	var container = document.getElementById('map'); //지도를 담을 영역의 DOM 레퍼런스
	var options = { //지도를 생성할 때 필요한 기본 옵션
		center: new kakao.maps.LatLng(37.49340007396145, 127.02853000028072), //지도의 중심좌표.
		level: 3 //지도의 레벨(확대, 축소 정도)
	};

	var map = new kakao.maps.Map(container, options); //지도 생성 및 객체 리턴
	</script>


	<!-- 웹사이트의 전반적인 구성을 알려주는 네비게이션 바 이다. -->
	<script
		src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
	<script src="js/bootstrap.min.js"></script>
	<!-- 동적인 다자인을 위해 애니매이션을 담당할 자바 스크립트들을 넣어준다.  -->

</body>
</html>