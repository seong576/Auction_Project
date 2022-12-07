<!-- 아래 page 지시자 빼면 한글 깨짐! -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<nav class="navbar navbar-expand-lg navbar-dark bg-primary" id="t_header">
	<div class="container">
		<a class="navbar-brand" href="${pageContext.request.contextPath}/">ShoppingMall</a>
		<button class="navbar-toggler" type="button" data-bs-toggle="collapse"
			data-bs-target="#navbarSupportedContent"
			aria-controls="navbarSupportedContent" aria-expanded="false"
			aria-label="Toggle navigation">
			<span class="navbar-toggler-icon"></span>
		</button>
		<div class="collapse navbar-collapse" id="navbarSupportedContent">
			<ul class="navbar-nav mx-auto">
				<li class="nav-item">
					<a class="nav-link active"	aria-current="page" href="${pageContext.request.contextPath}/index">Home</a></li>
				<li class="nav-item">
					<a class="nav-link" id="cart" 
						href="${pageContext.request.contextPath}/mypage/cartList">Cart
					</a>
				</li>
				<li class="nav-item">
					<a class="nav-link" id="order"  
						href="${pageContext.request.contextPath}/mypage/orderList">Order
					</a>
				</li>
			</ul>
		</div>
		<div class="flex-grow-1">
			<div class="navbar-collapse collapse w-100 order-3 dual-collapse2">
				<ul class="navbar-nav ms-auto">
					<li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/userUpdate?userId=${sessionScope.user.userId}">(${sessionScope.user.userName}님) </a></li>
					<li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/logout">Logout</a></li>
					<!-- 여기에 /logout을 하면 컨텍스트패스를 없애고 /logout이 되어 오류 -->
					<li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/login">Login</a>
					</li>
				</ul>
			</div>
		</div>
	</div>
</nav>