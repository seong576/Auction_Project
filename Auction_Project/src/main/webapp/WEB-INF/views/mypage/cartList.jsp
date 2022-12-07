<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	// 세션이 있으면 이미 로그인을 했기 때문에 로그인 페이지는 보여줄 필요 없음.
	/* if(request.().getAttribute("user") != null){
		//response.sendRedirect("index.jsp");	// index.jsp 페이지로 이동
	} */
	
%>
<!DOCTYPE html>
<html>
<head>
<title>쇼핑카트</title>
	<style type="text/css">
		.table tbody td{
			vertical-align: middle;
		}
		.table thead tr th{
			text-align: center;
		}
		.btn-incre, .btn-decre{
			font-size: 35px;
			box-shadow: none;
		}
	</style>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<%@include file="/WEB-INF/includes/header.jsp" %>
</head>
<body>
	<%@include file="/WEB-INF/includes/navbar.jsp"%>
	
	<div class="container">
		<div class="d-flex py-3">
			<h3>총 금액 : 200,000원</h3>
			<a class="btn btn-primary" href="#" onclick="location.href='${pageContext.request.contextPath}/checkout'">주문</a>
		</div>
		<form name="formm" id="formm" action="${pageContext.request.contextPath}/mypage/checkout" method="post">
			<input type="hidden" name="userId" value="${userId}">
			<div id="wrap" align="center">
				<table id="datatable"
					class="table table-striped table-lought dt-responsive nowrap"
					style="width: 100%">
					<thead>
						<tr>
							<th scope="col">선택</th>
							<th scope="col">상품명</th>
							<th scope="col">가격</th>
							<th scope="col">수량</th>
							<th scope="col">금액</th>
							<th scope="col">주문일자</th>
							<th scope="col">삭제</th>
							<!-- <th scope="col" style="display:none;">히든</th> -->
						</tr>
					</thead>
		
					<tbody>
					<c:choose>
						<c:when test="${carts.size() <= 0}">
							<tr>
								<td colspan="9" align="center" height="23">장바구니가 비었습니다.</td>
							</tr>
						</c:when>
						<c:otherwise>
							<c:forEach items="${carts}" var="cart" varStatus="status">
								<tr>
									<td>	<!-- 선택 체크박스 -->
										<input type="checkbox" id="chkCart-${status.index}" name="chkCart" value="${cart.productId}" checked>	<!-- 유저ID-상품ID key -->
									</td>
									<td>	<!-- 상품명 -->
										<a href="${pageContext.request.contextPath}/detailView?productId=${cart.productId }">${cart.productName }</a>
									</td>
									<td> <!-- 가격(단가) -->
										<label id="unitPrice-${status.index }" >
											<fmt:formatNumber value="${cart.unitPrice}" />
										</label>
									</td>
									<td>	<!-- 수량 -->
										<div class="form-group d-flex justify-content-between">
											<a class="btn btn-sm btn-decre" id="minusQty-${status.index }" href="#" style="color:red">
												<i class="fas fa-minus-square"></i>
											</a>
											<input type="number" name="quantity" id="quantity-${status.index }" class="form-control" 
												style="width: 100px;" onchange="changeQuantity(${status.index})" required 
												value="${cart.quantity}"><br>
											<a class="btn btn-sm btn-incre" id="plusQty-${status.index }" href="#" style="color:blue">
												<i class="fas fa-plus-square"></i>
											</a>
										</div>
									</td>
									<td class="amt">	<!-- 금액(수량 * 단가) -->
										<label id="amt-${status.index }">
											<fmt:formatNumber value="${cart.unitPrice * cart.quantity}" />
										</label>
									</td>
									
									<td>	<!-- 저장일자 -->
										<fmt:formatDate value="${cart.createDate}" type="date" />
									</td>
									<td style="text-align:center;">	<!-- 삭제버튼 -->
										<a href="#" class="btn btn-warning" id="btn_delete-${cart.productId}">삭제</a> <%-- onclick="if(confirm('정말 삭제하시겠습니까?')){return fnDeleteCart(${cart.productId});} --%>
									</td>
									<td>	<!-- 단가 -->
										<input type="hidden" name="unitPrice" id="unitPrice-${status.index}" value="${cart.unitPrice}" >	
									</td>
									<td>	<!-- 상품ID -->
										<input type="hidden" name="productId" id="productId-${status.index}" value="${cart.productId}" >	<!-- 상품ID -->
									</td>									
																		
								</tr>
							</c:forEach>
						</c:otherwise>
					</c:choose>
					</tbody>
					<tfoot>
						<tr>
							<th colspan="4" style="text-align:center;">총 액</th>
							<th colspan="2">
								<label id="lblTotalAmt">
									<fmt:formatNumber value="${totalAmt}" />
								</label>
							</th>
							<c:if test="${cartList.size() != 0}">
								<th><a href="#" class="btn btn-primary" id="btn_order">주문하기</a></th>
							</c:if>								
						</tr>
					</tfoot>
				</table>
			</div>
			
			<div id="buttons" style="float: right">
			<input type="button" value="쇼핑하기" class="btn btn-primary" onclick="location.href='${pageContext.request.contextPath}/index'">			
			<c:if test="${msg}">
				<p class="check_font text-danger" id="order_error">${msg}</p>
			</c:if>
		</div>
		</form>
	</div>
	<%@include file="/WEB-INF/includes/footer.jsp" %>
<script type="text/javascript">

// <tbody>의 행수를 알아내기 위해서 전역변수화
$(function() {
	const table = $('#datatable');
	const tbodyRows = $('#datatable > tbody > tr').length;
	$("[id^=btn_delete]").on('click',function()
	{
		let url = "${pageContext.request.contextPath}/mypage/deleteCart";
		
		let f = document.createElement('form');	//실제로 화면에는 없는 <form>을 생성
	    var productId = parseInt($(this).attr("id").replace("btn_delete-",""))
	    let obj;
	    obj = document.createElement('input');
	    obj.setAttribute('type', 'hidden');
	    obj.setAttribute('name', 'productId');
	    obj.setAttribute('value', productId);
	    
	    f.appendChild(obj);
	    f.setAttribute('method', 'post');
	    f.setAttribute('action', url);
	    document.body.appendChild(f);
	    f.submit();
	})
	
	$("[id^=chkCart]").on("change",function(){
		let totalAmt = 0;
		var row = parseInt($(this).attr("id").replace("chkCart-",""))
		let amt = document.getElementById('amt['+row+']').innerText;		// 해당 행의 금액(amt) lable tag
		let checkFlag = document.getElementById('chkCart-'+row).checked;// 해당 행의 체크 여부
		
		totalAmt = document.getElementById('lblTotalAmt').innerText; 	// 모든 행의 전체 합계 금액 label tag
		
		if(checkFlag == true){
			// 총금액 + 체크된 행의 금액
			//alert('체크됨');
			//alert(totalAmt);
			//alert(amt);
			
			totalAmt = parseInt(fnRemoveComma(totalAmt)) + parseInt(fnRemoveComma(amt));
		}else{
			//alert('체크풀림');
			//alert(totalAmt);
			//alert(amt);
			
			// 총금액 - 언체크된 행의 금액
			totalAmt = parseInt(fnRemoveComma(totalAmt)) - parseInt(fnRemoveComma(amt));
		}
		document.getElementById('lblTotalAmt').innerText = fnAddComma(totalAmt);
	})
	$("#btn_order").on("click",function(){
		let count = 0;
		for(var i=0; i<tbodyRows; i++){
			if ($('#chkCart-'+i).prop("checked")) {
				count++;
			}
		}
		
		if(count <= 0){
			alert('주문할 항목이 없습니다.');
			return false;
		}
		
		alert('주문된 상품은  : ' + count + ' 건 입니다.');
		
		//Loop 각각의 항목들을 콤머(,)로 연결하여 모두해서 문자열 4개를 만든다.
		let strProductId = "";
		let strQuantity = "";
		let strUnitPrice = "";
		
		for(var i=0; i<tbodyRows; i++){
			if ($('#chkCart-' + i).prop("checked")) {
				strProductId += fnRemoveComma($('#chkCart-'+ i).val()) + ",";	//맨끝에  붙는 콤머(,) 처리해야
				strQuantity += fnRemoveComma($('#quantity-'+ i).val()) + ",";
				strUnitPrice += fnRemoveComma(($('#unitPrice-'+ i).html()).trim()) + ",";
			}
		}
		
		let totalAmt = fnRemoveComma($("#lblTotalAmt").text()).trim();	//Total Amt
		
		//alert(totalAmt)
		//만들어놓은 배열의 크기로 정상 여부 확인
		/* alert(strProductId);
		alert(strQuantity);
		alert(strUnitPrice); */
		
	 	let url = "${pageContext.request.contextPath}/mypage/checkout";
		
		let f = document.createElement('form');	//실제로 화면에는 없는 가상의 <form>을 생성해서 거기에 값들을 담는다.
	    
	    let objProdudctId;	// productId용
	    objProdudctId = document.createElement('input');
	    objProdudctId.setAttribute('type', 'hidden');
	    objProdudctId.setAttribute('name', 'productId');
	    objProdudctId.setAttribute('value', strProductId);
	    
	    let objQuantity;	// Quantity용
	    objQuantity = document.createElement('input');
	    objQuantity.setAttribute('type', 'hidden');
	    objQuantity.setAttribute('name', 'quantity');
	    objQuantity.setAttribute('value', strQuantity);

	    let objUnitPirce;	// UnitPirce용
	    objUnitPirce = document.createElement('input');
	    objUnitPirce.setAttribute('type', 'hidden');
	    objUnitPirce.setAttribute('name', 'unitPrice');
	    objUnitPirce.setAttribute('value', strUnitPrice);

	    let objTotalAmt;	// total amt
	    objTotalAmt = document.createElement('input');
	    objTotalAmt.setAttribute('type', 'hidden');
	    objTotalAmt.setAttribute('name', 'totalAmt');
	    objTotalAmt.setAttribute('value', totalAmt);		    
	    
	    f.appendChild(objProdudctId);
	    f.appendChild(objQuantity);
	    f.appendChild(objUnitPirce);
	    f.appendChild(objTotalAmt);
	    
	    f.setAttribute('method', 'post');
	    f.setAttribute('action', url);
	    document.body.appendChild(f);
	    f.submit();
			
	
	})
	$("[id^=plusQty]").on("click",function(){
		let quantity = 0;
		let unitPrice = 0;
		let amt = 0;
		var row = parseInt($(this).attr("id").replace("plusQty-",""))
		let qty = $('#quantity-'+row); 	// input tag()
		let price = $('#unitPrice-'+row).text().trim();	// lable tag
		
		//alert(row + "-"+ qty.val() +"-"+price)
		//한 row에 대한 금액 계산
		if (qty.val() == "" || qty.val() == null) {
			alert('구매 수량을 입력하세요.');
			qty.focus();
			return false;
		}
		else {
			quantity = parseInt(qty.val());
			if(quantity >= 100){
				alert('구매 수량은 100개 이하이어야 합니다.');
				$("#quantity").focus();
				return false;
			}else{
				quantity = quantity + 1;	// 기존 수량 - 1
				qty.val(quantity);		// 차감한 수량 세팅
				//가격(단가)
				unitPrice = price;
				
				//금액계산(수량 * 단가)
				amt = parseInt(quantity) * fnRemoveComma(unitPrice);
				$('#amt-'+row).text(fnAddComma(amt));
			}
		}
		// 모든 행들의 amt 합계 계산
		fnCalTotalAmt();
		
		return false;
	})
	
	$("[id^=minusQty]").on("click",function(){
		let quantity = 0;
		let unitPrice = 0;
		let amt = 0;
		var row = parseInt($(this).attr("id").replace("minusQty-",""))
		let qty = $('#quantity-'+row); 	// input tag()
		let price = $('#unitPrice-'+row).text().trim();	// lable tag
		
		//alert(row + "-"+ qty.val() +"-"+price)
		//한 row에 대한 금액 계산
		if (qty.val() == "" || qty.val() == null) {
			alert('구매 수량을 입력하세요.');
			qty.focus();
			return false;
		}
		else {
			quantity = parseInt(qty.val());
			if(quantity <= 1){
				alert('구매 수량은 1개 이상이어야 합니다.');
				$("#quantity").focus();
				return false;
			}else{
				quantity = quantity - 1;	// 기존 수량 - 1
				qty.val(quantity);		// 차감한 수량 세팅
				//가격(단가)
				unitPrice = price;
				
				//금액계산(수량 * 단가)
				amt = parseInt(quantity) * fnRemoveComma(unitPrice);
				$('#amt-'+row).text(fnAddComma(amt));
			}
		}
		// 모든 행들의 amt 합계 계산
		fnCalTotalAmt();
		
		return false;
	})
	
	function fnCalTotalAmt(){
		//let totalRows = document.formm.chkCart.length;	// 테이블의 행수(체크박스 갯수)
		let count = 0;
		let totalAmt = 0;
					
		//for문 돌면서 모든 행들의 금액을 합산해서 총금액에 세팅
		for (var i = 0; i < tbodyRows; i++) {
			//alert(i);
			//alert(document.getElementById('chkCart[' + i + ']').checked);
			if ($('#chkCart-' + i).prop("checked")) {
				//alert(document.getElementById('amt[' + i + ']').innerText);
				totalAmt += parseInt(fnRemoveComma($('#amt-' + i).text()));
			}
		}						
		
		document.getElementById('lblTotalAmt').innerText = fnAddComma(totalAmt);			
	}
	function fnRemoveComma(number) {
	    if (typeof number == "undefined" || number == null || number == "") {
	        return "";
	    }
	    var txtNumber = '' + number;
	    return txtNumber.replace(/(,)/g, "");
	}
	
	function fnAddComma(number) {
	    var number_string = number.toString();
	    var number_parts = number_string.split('.');
	    var regexp = /\B(?=(\d{3})+(?!\d))/g;
	    if (number_parts.length > 1) {
	        return number_parts[0].replace(regexp, ',') + '.' + number_parts[1];
	    }
	    else
	    {
	        return number_string.replace(regexp, ',');
	    }
	}
});
<%-- const table = $('#datatable');
const tbodyRows = $('#datatable > tbody > tr').length;	

/*
* 본 jsp 페이지는 전체를 감싸는 form이 있고 그 안에서 행별로 지워야 한다
* 행별로 삭제할 때는 현재 jsp페이지 전체를 submit()하는 것이 아니기 때문에
* 삭제 버튼이 눌린 그 행만 submit()을 시켜야 한다.
* 그래서 별도의 form을 creation하고 거기에 name 속성을 만들어서 넣고
* value 속성도 만들어서 넣는다.
* 최종적으로 만든 form을 submit()하면 post 방식으로 submit()할수있다.
* 이 방식은 난이도가 좀 있는 편이다.
*/
function fnDeleteCart(productId){
	let url = "${pageContext.request.contextPath}/mypage/deleteCart";
	
	let f = document.createElement('form');	//실제로 화면에는 없는 <form>을 생성
    
    let obj;
    obj = document.createElement('input');
    obj.setAttribute('type', 'hidden');
    obj.setAttribute('name', 'productId');
    obj.setAttribute('value', productId);
    
    f.appendChild(obj);
    f.setAttribute('method', 'post');
    f.setAttribute('action', url);
    document.body.appendChild(f);
    f.submit();
}

/*
 * [주문]
 *	1. 체크된 행만 주문서 화면으로 이동되어야 한다.
 */
function fnCheckout(){
	
	// 체크된 행이 하나라도 있어야 주문 진행
	let count = 0;
	for(var i=0; i<tbodyRows; i++){
		if ($('chkCart[' + i + ']').attr("checked", true)) {
			count++;
		}
	}
	
	if(count <= 0){
		alert('주문할 항목이 없습니다.');
		return false;
	}
	
	//alert('주문된 상품은  : ' + count + ' 건 입니다.');
	
	//Loop 각각의 항목들을 콤머(,)로 연결하여 모두해서 문자열 4개를 만든다.
	let strProductId = "";
	let strQuantity = "";
	let strUnitPrice = "";
	
	for(var i=0; i<tbodyRows; i++){
		if ($('#chkCart[' + i + ']').attr("checked",true)) {
			strProductId += fnRemoveComma($('#chkCart[' + i + ']').val()) + ",";	//맨끝에  붙는 콤머(,) 처리해야
			strQuantity += fnRemoveComma($('#quantity[' + i + ']').val()) + ",";
			strUnitPrice += fnRemoveComma($('#unitPrice[' + i + ']').html()) + ",";
		}
	}			
	
	let totalAmt = fnRemoveComma(document.getElementById("lblTotalAmt").innerText);	//Total Amt
	
	//만들어놓은 배열의 크기로 정상 여부 확인
	alert(strProductId.length);
	alert(strQuantity.length);
	alert(strUnitPrice.length);
	
	let url = "${pageContext.request.contextPath}/mypage/checkout";
	
	let f = document.createElement('form');	//실제로 화면에는 없는 가상의 <form>을 생성해서 거기에 값들을 담는다.
    
    let objProdudctId;	// productId용
    objProdudctId = document.createElement('input');
    objProdudctId.setAttribute('type', 'hidden');
    objProdudctId.setAttribute('name', 'productId');
    objProdudctId.setAttribute('value', strProductId);
    
    let objQuantity;	// Quantity용
    objQuantity = document.createElement('input');
    objQuantity.setAttribute('type', 'hidden');
    objQuantity.setAttribute('name', 'quantity');
    objQuantity.setAttribute('value', strQuantity);

    let objUnitPirce;	// UnitPirce용
    objUnitPirce = document.createElement('input');
    objUnitPirce.setAttribute('type', 'hidden');
    objUnitPirce.setAttribute('name', 'unitPrice');
    objUnitPirce.setAttribute('value', strUnitPrice);

    let objTotalAmt;	// total amt
    objTotalAmt = document.createElement('input');
    objTotalAmt.setAttribute('type', 'hidden');
    objTotalAmt.setAttribute('name', 'totalAmt');
    objTotalAmt.setAttribute('value', totalAmt);		    
    
    f.appendChild(objProdudctId);
    f.appendChild(objQuantity);
    f.appendChild(objUnitPirce);
    f.appendChild(objTotalAmt);
    
    f.setAttribute('method', 'post');
    f.setAttribute('action', url);
    document.body.appendChild(f);
    f.submit();		
		
}

// 마이너스 버튼 클릭 이벤트 핸들러
function minusBtnClick(row) {
	//alert("minusBtnClick");
	//alert(this);
	//alert(row);
	
	let quantity = 0;
	let unitPrice = 0;
	let amt = 0;
	
	let qty = document.getElementById('quantity['+row+']'); 	// input tag()
	let price = document.getElementById('unitPrice['+row+']');	// lable tag
	
	//한 row에 대한 금액 계산
	if (qty.value == "" || qty.value == null) {
		alert('구매 수량을 입력하세요.');
		qty.focus();
		return false;
	}else {
		quantity = parseInt(qty.value);
		if(quantity <= 1){
			alert('구매 수량은 1개 이상이어야 합니다.');
			qty.focus();
			return false;
		}else{
			quantity = quantity - 1;	// 기존 수량 - 1
			qty.value = quantity;		// 차감한 수량 세팅
			
			//가격(단가)
			unitPrice = price.innerText;
			
			//금액계산(수량 * 단가)
			amt = parseInt(quantity) * parseInt(fnRemoveComma(unitPrice));
			document.getElementById('amt['+row+']').innerText = fnAddComma(amt);
		}
	}
	// 모든 행들의 amt 합계 계산
	fnCalTotalAmt();
	
	return false;
}

// 모든 행들의 amt 합계 계산
function fnCalTotalAmt(){
	//let totalRows = document.formm.chkCart.length;	// 테이블의 행수(체크박스 갯수)
	let count = 0;
	let totalAmt = 0;
				
	//for문 돌면서 모든 행들의 금액을 합산해서 총금액에 세팅
	for (var i = 0; i < tbodyRows; i++) {
		//alert(i);
		//alert(document.getElementById('chkCart[' + i + ']').checked);
		if (document.getElementById('chkCart[' + i + ']').checked == true) {
			//alert(document.getElementById('amt[' + i + ']').innerText);
			totalAmt += parseInt(fnRemoveComma(document.getElementById('amt[' + i + ']').innerText));
		}
	}						
	
	document.getElementById('lblTotalAmt').innerText = fnAddComma(totalAmt);			
}

//상품 체크박스 체크/언체크시 이벤트 핸들러(전체 금액 계산)


function plusBtnClick(row) {
	let quantity = 0;
	let unitPrice = 0;
	let amt = 0;
	
	let qty = document.getElementById('quantity['+row+']'); 	// input tag()
	let price = document.getElementById('unitPrice['+row+']');	// lable tag
	
	//한 row에 대한 금액 계산
	if (qty.value == "" || qty.value == null) {
		alert('구매 수량을 입력하세요.');
		qty.focus();
		return false;
	}else {
		quantity = parseInt(qty.value);
		if(quantity > 100){
			alert('구매 수량은 100개 이하여야 합니다.');
			qty.focus();
			return false;
		}else{
			quantity = quantity + 1;	// 기존 수량 + 1
			qty.value = quantity;		// 차감한 수량 세팅

			//가격(단가)
			unitPrice = price.innerText;
			
			//금액계산(수량 * 단가)
			amt = parseInt(quantity) * parseInt(fnRemoveComma(unitPrice));
			document.getElementById('amt['+row+']').innerText = fnAddComma(amt);
		}
	}
	
	// 모든 행들의 amt 합계 계산
	fnCalTotalAmt();
	
	return false;
}

function changeQuantity(row) {
	
	let quantity = 0;
	let unitPrice = 0;
	let amt = 0;
	
	let qty = document.getElementById('quantity['+row+']'); 	// input tag()
	let price = document.getElementById('unitPrice['+row+']');	// lable tag
	
	//한 row에 대한 금액 계산
	if (qty.value == "" || qty.value == null) {
		alert('구매 수량을 입력하세요.');
		qty.focus();
		return false;
	}else {
		quantity = parseInt(qty.value);
		if(quantity < 1){
			alert('구매 수량은 1개 이상이어야 합니다.');
			qty.value = 1;
			qty.focus();
			return false;
		}
		if(quantity > 100){
			alert('구매 수량은 100개 미만이어야 합니다.');
			qty.value = 100;
			qty.focus();
			return false;
		}else{
			//가격(단가) 추출
			unitPrice = price.innerText;
			
			//금액계산(수량*단가)
			amt = parseInt(quantity) * parseInt(fnRemoveComma(unitPrice));
			document.getElementById('amt['+row+']').innerText = fnAddComma(amt); //금액 세팅
		}
	}
	// 모든 행들의 amt 합계 계산
	fnCalTotalAmt();
	
	return false;
}

function fnGoCart(userId){
	// 잘 불러온다. 하지만 이 객체에서 특정 속성값을 갖고 올수 없다. 아쉽~
	////var user = '<%=(User)session.getAttribute("user")%>'; 
	var user = '${sessionScope.user}'; // 이 방법도 됨
	alert(user);
	console.log(user);
	if(user == ""){
		alert("로그인을 하세요.");
		location.href="";
		return false;
	}
	
	return true;
}		

//Add comma at thousand unit(int and decimal)
function fnAddComma(number) {
    var number_string = number.toString();
    var number_parts = number_string.split('.');
    var regexp = /\B(?=(\d{3})+(?!\d))/g;
    if (number_parts.length > 1) {
        return number_parts[0].replace(regexp, ',') + '.' + number_parts[1];
    }
    else
    {
        return number_string.replace(regexp, ',');
    }
}

//remove comma
function fnRemoveComma(number) {
    if (typeof number == "undefined" || number == null || number == "") {
        return "";
    }
    var txtNumber = '' + number;
    return txtNumber.replace(/(,)/g, "");
}			 --%>

</script>
</body>
</html>