<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="bbs.Bbs"%>
<%@ page import="bbs.BbsDAO"%>
<%@ page import="java.io.PrintWriter"%>
<% request.setCharacterEncoding("UTF-8"); %>


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
	if ( userID == null ) {
	
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('로그인을 하세요 .')");
		script.println("location.href = 'login.jsp'");
		script.println("</script>");
		// 로그인 없이 게시판 글쓰기는 불가능하게 하기 위한 예외처리
		// 세션 아이디가 없으면 이 조건문을 수행하게 된다.
		
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
	
	if (!userID.equals(bbs.getUserID())) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('권한이 없습니다.')");
		script.println("location.href = 'bbs.jsp'");
		script.println("</script>");
	} else {
		if (request.getParameter("bbsTitle") == null ||request.getParameter("bbsContent") == null
				|| request.getParameter("bbsTitle").equals("")
				||request.getParameter("bbsContent").equals("")){
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('입력이 안된 사항이 있습니다. ')");
				script.println("history.back()");
				script.println("</script>");
			} else {
				
				BbsDAO bbsDAO = new BbsDAO();
				int result = bbsDAO.update(bbsID,request.getParameter("bbsTitle"),request.getParameter("bbsContent"));
				
				if ( result == -1) {
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("alert('글 수정  실패 ')");
					script.println("history.back()");
					script.println("</script>");
				}
				else {
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("location.href = 'bbs.jsp'");
					script.println("</script>");
				}
				
			}
		
		
	}



%>


</body>
</html>