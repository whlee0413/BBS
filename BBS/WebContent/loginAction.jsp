<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="user.UserDAO"  %> 									<!-- user package에 있는 UserDAO import -->
<%@ page import="java.io.PrintWriter" %>							<!-- 자바스크립트 문장을 작성하기위해 사용하는 것 -->
<% request.setCharacterEncoding("UTF-8"); %>

<jsp:useBean id="user" class="user.User" scope="page"/>			<!-- scope="page" : 현재 페이지에서만 beans 사용 -->
<jsp:setProperty name="user" property="userID"/>
<jsp:setProperty name="user" property="userPassword"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<title>JSP 게시판 웹 사이트</title>										<!-- 사용자의 로그인 시도 처리 페이지 -->
</head>
<body>		
	<%
		UserDAO userDAO = new UserDAO();
		int result = userDAO.login(user.getUserID(), user.getUserPassword());    /* 아이디와 패스워드 값이 각각 login함수에 입력되어 실행됨 */ 
		if(result == 1)	{	 /* -1부터 2까지 각각의 결과값들이 result에 담김 */
			PrintWriter script = response.getWriter(); 						/* printwriter: 스크립트 문장을 넣을 수 있게 함 */
			script.println("<script>");										/* script문장을 유동적으로 실행하기 위해서  */
			script.println("location.href = 'main.jsp'");	
			script.println("</script>");
		}
		else if(result == 0){
			PrintWriter script = response.getWriter();
			script.println("<script>");										
			script.println("alert('비밀번호가 틀립니다.')");	
			script.println("history.back()");   							/*	histroy.back() : 이전 페이지로 돌려보냄  */
			script.println("</script>");	
		
		}
		else if(result == -1){
			PrintWriter script = response.getWriter();
			script.println("<script>");										
			script.println("alert('존재하지 않는 아이디 입니다.')");	
			script.println("history.back()");   							
			script.println("</script>");
		}
		else if(result == -2){
			PrintWriter script = response.getWriter();
			script.println("<script>");										
			script.println("alert('데이터베이스 오류가 발생했습니다.')");	
			script.println("history.back()");   							
			script.println("</script>");
		}
	%>
	

</body>
</html>