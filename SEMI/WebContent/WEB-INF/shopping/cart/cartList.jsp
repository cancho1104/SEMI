<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<jsp:include page="../../header.jsp"/>

<title>Cart</title>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<script src="js/jquery-3.3.1.min.js"></script>
<meta name="description" content="OneTech shop project">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" type="text/css" href="styles/bootstrap4/bootstrap.min.css">
<link href="plugins/fontawesome-free-5.0.1/css/fontawesome-all.css" rel="stylesheet" type="text/css">
<link rel="stylesheet" type="text/css" href="styles/cart_styles.css">
<link rel="stylesheet" type="text/css" href="styles/cart_responsive.css">


<script>

$(document).ready(function(){
	
	$("#allCheck").click(function(){
		if($("#allCheck").prop('checked') ){
			$("input[class=chk]").prop("checked",true);

		}else{
			$("input[class=chk]").prop("checked",false);
		}
		
	});
	
	$(".chk").click(function(){
		
		if($(this).prop('checked') ){
			var orderAmount = $("#order_total").val();
			var price = $(this).parent().parent().find(".cart_item_price").find(".price").val();
			$("#order_total").val(parseInt(orderAmount)+parseInt(price));
			$(".order_total_amount").text(((parseInt(orderAmount)+parseInt(price)).toString()).toLocaleString());
		}else{
			var orderAmount = $("#order_total").val();
			var price = $(this).parent().parent().find(".cart_item_price").find(".price").val();
			$("#order_total").val(parseInt(orderAmount)+parseInt(price))
			$(".order_total_amount").text(((parseInt(orderAmount)-parseInt(price)).toString()).toLocaleString());
		}
	
	});
	
	$("#allCheck").click(function(){
		var totalPrice = 0;
		$(".price").each(function() {
			
			totalPrice += parseInt($(this).val());
		});
		if($("#allCheck").prop('checked')){
			$("#order_total").val(totalPrice);
			$(".order_total_amount").text(totalPrice.toLocaleString());
		}else{
			$("#order_total").val("0");
			$(".order_total_amount").text("0");
		}
		
	});
	
});//Eo ready

function deleteCart(pnum){
	
	$("#delPnum").val(pnum);
	var frm = document.cartDel;
	frm.submit();
	
}
</script>
	<!-- Cart -->

	<div class="cart_section" style="width:100%;">
		<div class="container" style="width:100%;">
			<div class="row" style="width:100%;">
				<div class="col-lg-12" >
					<div class="cart_container col-lg-12" >
						<div class="cart_title">장바구니</div>
						<div class="cart_items col-lg-12" style="border: 0px solid gray; ">	
							
							<c:if test="${ cartList != null }">			
								<div><input type="checkbox" id="allCheck"><span color: rgba(0,0,0,0.5); style="margin-left: 10px;"><label for="allCheck">전체선택</label></span></div>
							</c:if>
							
							<ul class="cart_list col-lg-12">
								<c:if test="${ cartList != null }">
									<c:forEach var="cvo" items="${cartList}">
										<li class="cart_item clearfix col-lg-12" style="border: 0px solid blue;">
										
											<div class="cart_item_info d-flex flex-md-row flex-column justify-content-between col-lg-12" style="border: 0px solid red;">
												<div class="cart_item_image col-lg-3" style="margin-left: 0px;">
													<input type="checkbox" class="chk" /><img style="width:90%; height: 90%;" src="images/${cvo.pimage}"/>
												</div>
												<div class="cart_item_name cart_info_col col-lg-5">
													<div class="cart_item_title">상품/옵션정보</div>
													<span class="cart_item_text">${cvo.pname }</span><br/>
													<span class="cart_item_title" style="font-weight:bold;">${cvo.pcontent }</span>
												</div>
												<div class="cart_item_quantity cart_info_col col-lg-1" style="margin-right:30px;">
													<div class="cart_item_title">수량</div>
													<div class="cart_item_text"><input type="number" value="${cvo.oqty }" style="width: 50px; text-align: center;" /></div> 
												</div>   
												<div class="cart_item_price cart_info_col col-lg-2" style="margin-right:30px;">
													<div class="cart_item_title" >상품가격</div>
													<div class="cart_item_text"><fmt:formatNumber  value="${cvo.saleprice }" pattern="#,###,###,###"/></div>원
													<input class="price" type="hidden" value="${cvo.saleprice }"/>
												
												</div>
												
												<div class="cart_item_color cart_info_col col-lg-1" >
													<div class="cart_item_title">주문</div>
													<div class="cart_item_text">
														<ul>
															<li><button type="button" class="btn btn-danger btn-sm" style="font-size: 12pt; cursor:pointer;">주문하기</button></li>												
															<li><button type="button" class="btn btn-success btn-sm" style="font-size: 12pt; cursor:pointer;" onClick="deleteCart('${cvo.pnum}');">삭제하기</button></li>
														</ul>
													</div>
												</div>										
											</div> 
										
										</li>
									</c:forEach>
								</c:if>
								<c:if test="${ cartList == null }">
									<li>
										<div class="cart_item_price cart_info_col col-xs-12">
											<div class="cart_item_price cart_info_col col-xs-12" style="text-align: center;">
												<div class="cart_item_title" style="clear: both; margin-top: 30px; margin-bottom: 30px;">장바구니 목록이 없습니다.</div>
											
											</div>							
										</div>
									</li>
								</c:if>
							</ul>
						</div>
						<form name="cartDel" method="GET" action="cartDel.do">
							<input type="hidden" name="pnum" id="delPnum" value="0"/>
						</form>
						<c:if test="${ cartList != null }">
							<!-- Order Total -->
							<div class="order_total">
								<div class="order_total_content text-md-right">
									<div class="order_total_title">Order Total:</div>
									<input type="hidden" id="order_total" value="0"/>
									<div class="order_total_amount">0 </div>원
								</div>
							</div>
	
							<div class="cart_buttons">
								<button type="button" class="button cart_button_checkout">선택상품주문</button>
								<button type="button" class="button cart_button_clear">전체주문</button>
							</div>
						
						</c:if>
					</div>
				</div>
			</div>
		</div>
	</div>


<jsp:include page="../../footer.jsp"/>
