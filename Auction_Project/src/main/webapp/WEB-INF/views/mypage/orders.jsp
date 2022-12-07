<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	// 세션이 있으면 이미 로그인을 했기 때문에 로그인 페이지는 보여줄 필요 없음.
	if(request.getSession().getAttribute("user") != null){
		response.sendRedirect("index.jsp");	// index.jsp 페이지로 이동
	}
	
%>
<!DOCTYPE html>
<html>
<head>
<title>주문</title>
<%@include file="/WEB-INF/includes/header.jsp" %>
</head>
<body>
	<%@include file="/WEB-INF/includes/navbar.jsp"%>
	
	<%@include file="/WEB-INF/includes/footer.jsp" %>
</body>
</html>