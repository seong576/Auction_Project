<%@ page import="java.util.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>


<!DOCTYPE html>
<html lang="ko">
<head>
<title>쇼핑몰에 오신걸 환영합니다.</title>
	<%@include file="/WEB-INF/includes/header.jsp"%>
</head>
<body>
	<%@include file="/WEB-INF/includes/navbar.jsp"%>

	<%
		out.print("Login User Session : " + session.getAttribute("user"));
		//System.out.println(application.getContextPath());
		//System.out.println("index.jsp페이지 application.getRealPath('/image'): " + application.getRealPath("/image"));
	%>

	<div class="container mt-5">
		<!-- 모든 상품 -->
		<div class="card">
			<div class="card-header bg-warning bg-gradient p-2 fw-bold" style="-bs-bg-opacity: .1;">모든 상품</div>
			<div class="card-body">
				<div class="row">
					<c:forEach var="p" items="${products}">
						<div class="col-lg-3 col-md-4 col-sm-6 col-12 mt-2">
							<div class="card w-100" style="width: 18rem;">
								<a href="${pageContext.request.contextPath}/detailView?productId=${p.productId}">
									<img class="card-img-top" src="${pageContext.request.contextPath}/images/${p.image}" alt="${p.productName}">
								</a>
								<div class="card-body">
									<div class="card-title">
										제품명 :
										${p.productName}</div>
									<div class="price">
										가격 :
										${p.unitPrice}원
									</div>
									<div class="category">
										카테고리 :
										${p.categoryName}</div>
									<div class="mt-3 d-flex justify-content-between">
										<a href="#" class="btn btn-secondary" style="font-size:0.8rem;">카트에 추가</a> <a href="#"
											class="btn btn-success" style="font-size:0.8rem;">즉시구매</a>
									</div>
								</div>
							</div>
						</div>
					</c:forEach>
				</div>
			</div>
		</div>
		<!-- 모든 상품 -->
		<!-- 최근 상품 -->
		<div class="card mt-3">
			<div class="card-header bg-info bg-gradient p-2 fw-bold"
				style="-bs-bg-opacity: .2;">최근 상품</div>
			<div class="card-body">
				<div class="row">
					<c:forEach var="p" items="${recentProducts}">
						<div class="col-lg-3 col-md-4 col-sm-6 col-12 mt-2">
							<div class="card w-100" style="width: 18rem;">
								<a href="${pageContext.request.contextPath}/detailView?productId=${p.productId}">
									<img class="card-img-top" src="${pageContext.request.contextPath}/images/${p.image}" alt="${p.productName}">
								</a>						
								<div class="card-body">
									<h5 class="card-title">
										제품명 :
										${p.productName}</h5>
									<div class="price">
										가격 :
										${p.unitPrice}원
									</div>
									<div class="category">
										카테고리 :
										${p.categoryName}</div>
									<div class="mt-3 d-flex justify-content-between">
										<a href="#" class="btn btn-secondary" style="font-size:0.8rem;">카트에 추가</a> <a href="#"
											class="btn btn-success" style="font-size:0.8rem;">즉시구매</a>
									</div>
								</div>
							</div>
						</div>
					</c:forEach>
				</div>
			</div>
		</div>
		<!-- 최근 상품 -->
		
		<!-- 히트 상품 -->
		<div class="card mt-3">
			<div class="card-header bg-success bg-gradient p-2 fw-bold"
				style="-bs-bg-opacity: .2;">인기 상품</div>
			<div class="card-body">
				<div class="row">
					<c:forEach var="p" items="${hitProducts}">				
						<div class="col-lg-3 col-md-4 col-sm-6 col-12 mt-2">
							<div class="card w-100" style="width: 18rem;">
								<a href="${pageContext.request.contextPath}/detailView?productId=${p.productId}">
										<img class="card-img-top" src="${pageContext.request.contextPath}/images/${p.image}" alt="${p.productName}">
								</a>
								<div class="card-body">
									<h5 class="card-title">
										제품명 :
										${p.productName}</h5>
									<div class="price">
										가격 :
										${p.unitPrice}원
									</div>
									<div class="category">
										카테고리 :
										${p.categoryName}</div>
									<div class="mt-3 d-flex justify-content-between">
										<a href="#" class="btn btn-secondary" style="font-size:0.8rem;">카트에 추가</a> <a href="#"
											class="btn btn-success" style="font-size:0.8rem;">즉시구매</a>
									</div>
								</div>
							</div>
						</div>
					</c:forEach>
				</div>
			</div>
		</div>
		<!-- 히트 상품 -->	
	</div>


	<%@include file="/WEB-INF/includes/footer.jsp"%>
</body>
</html>