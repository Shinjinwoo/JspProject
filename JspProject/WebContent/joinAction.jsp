<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="user1.UserDAO"%>
<%@ page import="java.io.PrintWriter"%>
<% request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="user" class="user1.User1" scope="page" />
<jsp:setProperty name="user" property="userID" />
<jsp:setProperty name="user" property="userPassword" />
<jsp:setProperty name="user" property="userName" />
<jsp:setProperty name="user" property="userGender" />
<jsp:setProperty name="user" property="userEmail" />

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>여기에 제목을 입력하십시오</title>
</head>
<body>
	<%	

	String userID = null;

	if (session.getAttribute("userID") != null) {
		userID = (String) session.getAttribute("userID");
		// 변수 userID에게 자신에게 할당된 세션아이디를 담게 만들어줌
	}
	if ( userID != null ) {
	
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('이미 로그인이 되었습니다 .')");
		script.println("location.href = 'main.jsp'");
		script.println("</script>");
		// 이미 회원가입이 된 사람은 또 다시 회원가입 할수 없게 예외처리
	}

	if (user.getUserID() == null || user.getUserPassword() == null || user.getUserName() == null ||
		user.getUserGender() == null || user.getUserEmail() == null ){
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('모든 사항을 입력해주세요 ! ')");
		script.println("history.back()");
		script.println("</script>");
	} else {
		
		UserDAO userDAO = new UserDAO();
		int result = userDAO.join(user);
		
		if ( result == -1) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert(' 중복된 ID 입니다.')");
			script.println("history.back()");
			script.println("</script>");
		}
		else {
			session.setAttribute("userID",user.getUserID());
			/* 회원가입에 성공한 유저에게 userID를 기반으로 세션 할당  */
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("location.href = 'main.jsp'");
			script.println("</script>");
		}
		
	}

%>


</body>
</html>