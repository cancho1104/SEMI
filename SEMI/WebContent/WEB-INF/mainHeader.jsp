<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>     
<!DOCTYPE html>
<html lang="en">
<head>
<title>OneTech</title>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="description" content="OneTech shop project">
<meta name="viewport" content="width=device-width, initial-scale=1">
<script src="js/jquery-3.3.1.min.js"></script>
<link rel="stylesheet" type="text/css" href="styles/bootstrap4/bootstrap.min.css">
<link href="plugins/fontawesome-free-5.0.1/css/fontawesome-all.css" rel="stylesheet" type="text/css">
<link rel="stylesheet" type="text/css" href="plugins/OwlCarousel2-2.2.1/owl.carousel.css">
<link rel="stylesheet" type="text/css" href="plugins/OwlCarousel2-2.2.1/owl.theme.default.css">
<link rel="stylesheet" type="text/css" href="plugins/OwlCarousel2-2.2.1/animate.css">
<link rel="stylesheet" type="text/css" href="plugins/slick-1.8.0/slick.css">
<link rel="stylesheet" type="text/css" href="styles/main_styles.css">
<link rel="stylesheet" type="text/css" href="styles/responsive.css">

 
</head>

<script type="text/javascript">

	var category = "";
	
	$(document).ready(function () {
		
		$("#serch").keydown(function(event) {
			if(event.keyCode == 13) {// 엔터를 했을 경우
				goWordSearch();			
			}
		});// end of $("#serch").keydown()-----------------------------------
		
		$("#serch").val("${ search }");
		 
		$(".searchCategoryCode").each(function () {
			
			var text = $(this).text();
			
			var searchCategoryCode = ($(this).val()==0)?"":""+$(this).val();
			
			if(searchCategoryCode == "${ searchCategoryCode }" ){
				$("#searchCategory").text(text); 
				return false;
			}
			
		});
		
	});
	
	function goWordSearch() {
		
		var searchCategory = $("#searchCategory").text().trim();
		var categoryCode = "";
		
		
		
		$(".searchCategoryCode").each(function () {
			
			if($(this).text() == searchCategory){
				categoryCode = $(this).val();
				return false;
			}
			
		});
		
		$("#searchCategoryCode").val(categoryCode);
		
		var frm = document.serchFrm;
		
		frm.method = "GET";
		frm.action = "prodList.do";
		frm.submit();
		
	}// end of goWordSearch()--------------

</script>

<body>

<div class="super_container">
	
	<!-- Header -->
	
	<header class="header">

		<!-- Top Bar -->

		<div class="top_bar">
			<div class="container">
				<div class="row">
					<div class="col d-flex flex-row">
						<div class="top_bar_content ml-auto">
							<div class="top_bar_user">
								<c:if test="${ sessionScope.loginuser == null && sessionScope.loginadmin == null }">
									<div class="user_icon"><img src="images/user.svg" alt=""></div>
									<div><a href="userRegister.do">회원가입</a></div>
									<div><a href="login.do">로그인</a></div>
									<div style="margin-left: 10px;"><a href="#">고객센터</a></div>
								</c:if>
								<c:if test="${ sessionScope.loginuser != null && sessionScope.loginadmin == null }">
									<div class="user_icon"><img src="images/user.svg" alt=""></div>
									<div><a href="userRegister.do">내정보</a></div>
									<div><a href="logout.do">로그아웃</a></div>
									<div style="margin-left: 10px;"><a href="#">고객센터</a></div>
								</c:if>
								<c:if test="${ sessionScope.loginadmin != null && sessionScope.loginuser == null }">
									<div class="user_icon"><img src="images/user.svg" alt=""></div>
									<div><a href="managementUser.do">회원관리</a></div>
									<div><a href="managementProduct.do">상품관리</a></div>
									<div style="margin-left: 10px;"><a href="logout.do">로그아웃</a></div>
								</c:if>
							</div>
						</div>
					</div>
				</div>
			</div>		
		</div>

		<!-- Header Main -->

		<div class="header_main">
			<div class="container">
				<div class="row">

					<!-- Logo -->
					<div class="col-lg-2 col-sm-3 col-3 order-1">
						<div class="logo_container">
							<div class="logo" align="center"><a href="index.do"><img src="images/mainlogo.png" width="50%" height="50%"></a></div>
						</div>
					</div>

					<!-- Search -->
					<div class="col-lg-6 col-12 order-lg-2 order-3 text-lg-left text-right">
						<div class="header_search">
							<div class="header_search_content">
								<div class="header_search_form_container">
									<form name="serchFrm" class="header_search_form clearfix">
										<input type="text" required="required" id="serch" name="serch" class="header_search_input" placeholder="Search for products...">
										<div class="custom_dropdown">
											<div class="custom_dropdown_list">
												<span class="custom_dropdown_placeholder clc" id="searchCategory">전체</span>
												<i class="fas fa-chevron-down"></i>
												<ul class="custom_list clc"  style="border: none;">
													<li class="searchCategoryCode" value=""><a class="clc" href="#">전체</a></li>
													<li class="searchCategoryCode" value="100000"><a class="clc" href="#">데스크탑</a></li>
													<li class="searchCategoryCode" value="200000"><a class="clc" href="#">노트북</a></li>
													<li class="searchCategoryCode" value="300000"><a class="clc" href="#">모니터</a></li>
													<li class="searchCategoryCode" value="400000"><a class="clc" href="#">주변기기</a></li>
												</ul>
												<input type="text" name="searchCategoryCode" id="searchCategoryCode" style="display: none;" value=""/>
											</div>
										</div>
										<button type="button" id="searchbtn" class="header_search_button trans_300" value="" onclick="goWordSearch()"><img src="images/search.png" alt=""></button>
									</form>
								</div>
							</div>
						</div>
					</div>

					<!-- Wishlist -->
					<div class="col-lg-4 col-9 order-lg-3 order-2 text-lg-left text-right">
						<div class="wishlist_cart d-flex flex-row align-items-center justify-content-end">
							<!-- Cart -->
							<div class="cart">
								<div class="cart_container d-flex flex-row align-items-center justify-content-end" style="cursor: pointer;" onclick="javascript:location.href='cartList.do'">
									<div class="cart_icon">
										<img src="images/cart.png" alt="">
									</div>
									<div class="cart_content">
										<div class="cart_text"><a href="cartList.do">장바구니</a></div>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		
		<!-- Main Navigation -->

		<nav class="main_nav">
			<div class="container">
				<div class="row">
					<div class="col">
						
						<div class="main_nav_content d-flex flex-row">

							<!-- Categories Menu -->

							<div class="cat_menu_container" >
								<div class="cat_menu_title d-flex flex-row align-items-center justify-content-start">
									<div class="cat_burger"><span></span><span></span><span></span></div>
									<div class="cat_menu_text">카테고리</div>
								</div>

								<ul class="cat_menu">
									<li><a href="prodList.do?searchCategoryCode=100000">컴퓨터 <i class="fas fa-chevron-right ml-auto"></i></a></li>
									<li><a href="prodList.do?searchCategoryCode=200000">노트북<i class="fas fa-chevron-right"></i></a></li>
									<li><a href="prodList.do?searchCategoryCode=300000">모니터<i class="fas fa-chevron-right"></i></a></li>
									<li><a href="prodList.do?searchCategoryCode=400000">주변기기<i class="fas fa-chevron-right"></i></a></li>
								</ul>
							</div>
							

							<!-- Main Nav Menu -->

							<div class="main_nav_menu ml-auto">
								<ul class="standard_dropdown main_nav_dropdown">
									
									<li class="hassubs">
										<a href="#BEST">베스트 셀러<i class=""></i></a>
									</li>
									<li class="hassubs">
										<a href="#HIT">HIT 상품<i class=""></i></a>
									</li>
									<li><a href="#NEW">NEW 제품<i class=""></i></a></li>
									<li class="hassubs">
										<a href="prodList.do">전체<i class=""></i></a>
									</li>
									<li><a href="">제품 리뷰<i class=""></i></a></li>
								</ul>
							</div>

							<!-- Menu Trigger -->

							<div class="menu_trigger_container ml-auto">
								<div class="menu_trigger d-flex flex-row align-items-center justify-content-end">
									<div class="menu_burger">
										<div class="menu_trigger_text">menu</div>
										<div class="cat_burger menu_burger_inner"><span></span><span></span><span></span></div>
									</div>
								</div>
							</div>

						</div>
					</div>
				</div>
			</div>
		</nav>
		
		<!-- Menu -->

		<div class="page_menu">
			<div class="container">
				<div class="row">
					<div class="col">
						
						<div class="page_menu_content">
							
							<div class="page_menu_search">
								<form action="#">
									<input type="search" required="required" class="page_menu_search_input" placeholder="Search for products...">
								</form>
							</div>
							<ul class="page_menu_nav">
								<li class="page_menu_item">
									<a href="#">베스트 셀러<i class="fa fa-angle-down"></i></a>
								</li>
								<li class="page_menu_item">
									<a href="#">HIT 상품<i class="fa fa-angle-down"></i></a>
								</li>
								<li class="page_menu_item">
									<a href="#">NEW 제품<i class="fa fa-angle-down"></i></a>
								</li>
								<li class="page_menu_item">
									<a href="#">제품 리뷰<i class="fa fa-angle-down"></i></a>
								</li>
								<li class="page_menu_item"><a href="blog.html">고객 문의<i class="fa fa-angle-down"></i></a></li>
							</ul>
						</div>
					</div>
				</div>
			</div>
		</div>

	</header>