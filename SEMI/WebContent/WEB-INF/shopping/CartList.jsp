<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="../header.jsp"/>

<title>Cart</title>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="description" content="OneTech shop project">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" type="text/css" href="styles/bootstrap4/bootstrap.min.css">
<link href="plugins/fontawesome-free-5.0.1/css/fontawesome-all.css" rel="stylesheet" type="text/css">
<link rel="stylesheet" type="text/css" href="styles/cart_styles.css">
<link rel="stylesheet" type="text/css" href="styles/cart_responsive.css">



	<!-- Cart -->

	<div class="cart_section"">
		<div class="container">
			<div class="row">
				<div class="col-lg-10 offset-lg-1" >
					<div class="cart_container">
						<div class="cart_title">장바구니</div>
						<div class="cart_items" style="border: 0px solid gray;">					
							<div style="margin-left: 20px;"><input type="checkbox" ><span color: rgba(0,0,0,0.5); style="margin-left: 10px;">전체선택</span></div>
							<ul class="cart_list">
								<li class="cart_item clearfix" style="border: 0px solid blue;">
									<div class="cart_item_info d-flex flex-md-row flex-column justify-content-between" style="border: 0px solid red;">
										<div class="cart_item_image" style="margin-left: 5px;"><input type="checkbox" /><img src="images/shopping_cart.jpg"></div>
										<div class="cart_item_name cart_info_col">
											<div class="cart_item_title">상품/옵션정보</div>
											<div class="cart_item_text">MacBook Air 13</div>
										</div>
										<div class="cart_item_quantity cart_info_col">
											<div class="cart_item_title">수량</div>
											<div class="cart_item_text"><input type="text" value="1" style="width: 50px; text-align: center;" /></div> 
											<button type="button" style="font-size: 12pt; font-weight: 400; color: rgba(0,0,0,0.5); background: #FFFFFF; border: solid 1px #b2b2b2; cursor: pointer; outline: none; margin-top: 10px; padding-left: 20px; padding-right: 20px;><span">변경</span></button>
										</div>   
										<div class="cart_item_price cart_info_col">
											<div class="cart_item_title">상품금액</div>
											<div class="cart_item_text">$2000</div>
										</div>
										<div class="cart_item_total cart_info_col">
											<div class="cart_item_title">할인금액</div>
											<div class="cart_item_text">$1800</div>
										</div> 
										<div class="cart_item_color cart_info_col">
											<div class="cart_item_title">주문</div>
											<div class="cart_item_text">
												<ul>
													<li><button type="button" class="btn btn-danger btn-sm" style="font-size: 12pt;">주문하기</button></li>												
													<li><button type="button" class="btn btn-success btn-sm" style="font-size: 12pt;">삭제하기</button></li>
												</ul>
											</div>
										</div>										
									</div> 
								</li>
							</ul>
						</div>

						 
						<!-- Order Total -->
						<div class="order_total">
							<div class="order_total_content text-md-right">
								<div class="order_total_title">Order Total:</div>
								<div class="order_total_amount">$2000</div>
							</div>
						</div>

						<div class="cart_buttons">
							<button type="button" class="button cart_button_checkout">선택상품주문</button>
							<button type="button" class="button cart_button_clear">전체주문</button>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>


<jsp:include page="../footer.jsp"/>
