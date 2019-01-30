<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page="../header.jsp" />

<link rel="stylesheet" type="text/css"
	href="styles/bootstrap4/bootstrap.min.css">
<link href="plugins/fontawesome-free-5.0.1/css/fontawesome-all.css"
	rel="stylesheet" type="text/css">
<link rel="stylesheet" type="text/css"
	href="plugins/OwlCarousel2-2.2.1/owl.carousel.css">
<link rel="stylesheet" type="text/css"
	href="plugins/OwlCarousel2-2.2.1/owl.theme.default.css">
<link rel="stylesheet" type="text/css"
	href="plugins/OwlCarousel2-2.2.1/animate.css">
<link rel="stylesheet" type="text/css"
	href="plugins/jquery-ui-1.12.1.custom/jquery-ui.css">
<link rel="stylesheet" type="text/css" href="styles/shop_styles.css">
<link rel="stylesheet" type="text/css" href="styles/shop_responsive.css">
<script src="plugins/jquery-ui-1.12.1.custom/jquery-ui.js"></script>
<script src="plugins/Isotope/isotope.pkgd.min.js"></script>
<script src="plugins/parallax-js-master/parallax.min.js"></script>
<link rel="stylesheet" href="styles/rSlider.min.css">
<script src="js/rSlider.min.js"></script>

<style>
.active {
	color: orange;
}

</style>
<script>
	$(document).ready(function() {
		
		$(".categories").each(function () {
			
			var category = $(this).val();
			if(category == "${ searchCategoryCode }"){
				$(this).addClass("active");
			}
			
		});
		
		$(".categories").on("click", function() {
			if ($(this).attr("class") == "categories active") {
				$(this).removeClass("active");
				
			} else {
				$(this).addClass("active");
				//console.log($(this).attr("class"));
			}

		});
		
		
		$(".color").on("click", function() {

			if ($(this).attr("class") == "color active") {
				$(this).removeClass("active");
				$(this).css("border","1px solid black");
				
			} else {
				$(this).addClass("active");
				$(this).css("border","1px solid Lime");
				//console.log($(this).attr("class"));
			}
		});
		
		
		
		$(".brand").on("click", function() {

			if ($(this).attr("class") == "brand active") {
				$(this).removeClass("active");
				
			} else {
				$(this).addClass("active");
				//console.log($(this).attr("class"));
			}
		});

		
		goSearch($("#sort").text(), "1");

		
	});// end of $(document).ready()-----------------------------
	
	 (function () {
         'use strict';

         var init = function () {                

             var slider = new rSlider({
                 target: '#slider',
                 values: [0, 10, 20, 30, 40, 50, 60, 70,80,90,100,110,120,130,140,150,160,170,180,190,200],     
                 range: true,
                 set: [0, 200],
                 width:    180,
                 scale:    false,
                 labels: false,

                 onChange: function (vals) {
                    // console.log(vals);
                 }
             });
         };
         window.onload = init;
     })();

	var sizePerPage = 5;
	
	function goSearch(sort, pageNo) {
		
		console.log(sort);
		
		if(sort == null || sort == ""){
			sort = $("#sort").text();
		}
		
		if(pageNo == null || pageNo == ""){
			pageNo = "1";
		}
		
		var categories = "";
		$(".categories").each(function(){
			var classes = $(this).attr("class");
			
			if(classes == "categories active"){
				categories += "'" + $(this).val() + "',";
			}
		});
		$("#category").val(categories.substring(0,categories.length-1));
		var category = $("#category").val();
		console.log("category:"+category);
		
		//카테고리코드(ex]100000),카테고리코드,카테고리코드 으로 들어가니까 java단에서 받아서 분리시켜줄 필요가 있음
	
		var colors = "";
		$(".color").each(function(){
			var classes = $(this).attr("class");
			//console.log("classes:"+classes);
			if(classes == "color active"){
				colors += "'" + $(this).attr("value") +"',";
			}
		});
		$("#color").val(colors.substring(0,colors.length-1));
		var color = $("#color").val();
		console.log("color: "+color);
		//컬러코드,컬러코드,컬러코드 으로 들어가니까 java단에서 받아서 분리시켜줄 필요가 있음
		
		var companies = "";
		$(".brand").each(function(){
			var classes = $(this).attr("class");
			
			if(classes == "brand active"){
				companies += "'" + $(this).text() +"',";
			}
		});
		
		$("#company").val(companies.substring(0,companies.length-1));
		var company = $("#company").val();
		console.log("company:"+company);
		//회사명,회사명,회사명 으로 들어가니까 java단에서 받아서 분리시켜줄 필요가 있음
	
		console.log("price:"+$("#slider").val());
		//가격최소값,가격최대값 으로 나온다. ex) 30,60
		
		var str = $("#slider").val();
		var res=str.split(",");
		$("#minPrice").val(res[0]);
		$("#maxPrice").val(res[1]);
		
		var minPrice = $("#minPrice").val();
		var maxPrice = $("#maxPrice").val();
		console.log("minprice:"+minPrice);
		console.log("maxprice:"+maxPrice);
		//가격 최소값 minPrice, 가격 최대값 maxPrice input태그로 으로 나눠서 넣어놓았으므로 
		//java 단에서 받을때 minPrice, maxPrice 로 받으면 됨
		
		console.log("sort : " + sort);
		
		var searchWord = "${ search }";
		console.log("searchWord : " + searchWord);
		
		var form_data = {sort:sort, category:category, color:color, company:company, minprice:minPrice, maxprice:maxPrice, pageNo:pageNo, sizePerPage:sizePerPage, searchWord:searchWord}
		
		 $.ajax({
			url: "getProdList.do",
			type: "GET",
			data: form_data,  // 위의 URL 페이지로 사용자가 보내는 ajax 요청 데이터.
			dataType: "JSON", // ajax 요청에 의해 URL 페이지 서버로 부터 리턴받는 데이터 타입. xml, json, html, script, text 이 있음.
			success: function(json){
				
				var html = "";
				
				if(json.length > 0){
					
					$.each(json, function(entryIndex, entry){
						
						html += "<div style='margin-top: 20px;'>" +
									"<div class='row'>" +
										"<div class='col-md-5'>" +
											"<a href='prodView.do?pnum="+ entry.pnum +"'> <img class='img-fluid rounded mb-3 mb-md-0'" +
											"src='images/" + entry.pimage + "' alt=''" +
											"style='width: 300px; height: 200px;'>" +
											"</a>" +
										"</div>" +
										"<div class='col-md-7' style='padding-top: 30px;'>" +
											"<h3><a href='prodView.do?pnum="+ entry.pnum +"'>" + entry.pname + "</a> </h3>" +
											"<p>" + entry.pcontent + "</p>" +
											(entry.price == entry.saleprice?"":"<p style='text-decoration: line-through;'>" + entry.price.toLocaleString('en') + " 원</p>") +  
											"<h5 style='color:red'>" + entry.saleprice.toLocaleString('en') + " 원</h5>" +
											"<a class='btn btn-primary' href='#'>장바구니</a> <a " +
											"class='btn btn-primary' href='#'>구매하기</a>" +
										"</div>" +
									"</div>" +
								"</div>";
			      	        
					 });// end of $.each(data, function(entryIndex, entry){ })-------------------
					 
					 console.log(html);
					 
				}	 
				else{
					html += "<div style='margin-top: 20px;' align='center'>" +
								"<h3>검색 조건에 맞는 상품이 없습니다.</h3>" +
							"</div>";
				}
				
				$("#productList").html(html);
				$("#sort").text(sort);
				
				console.log("pageNo : " + pageNo);
				
				makePagebar(sort, category, color, company, minPrice, maxPrice, pageNo, searchWord);

			},// end of success: function()------
			error: function(request, status, error){
				alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
			}
		});// end of $.ajax()-------------------------------- 
		
	}// end of goSearch()--------------------------------------
	
	function makePagebar(sort, category, color, company, minPrice, maxPrice, currentPageNo, searchWord) {
		
		var form_data = {category:category, color:color, company:company, minprice:minPrice, maxprice:maxPrice, sizePerPage:sizePerPage, searchWord:searchWord};
		
		
		$.ajax({
			url: "prodListPageBarJSON.do",
			type: "GET",
			data: form_data,  // 위의 URL 페이지로 사용자가 보내는 ajax 요청 데이터.
			dataType: "JSON", // ajax 요청에 의해 URL 페이지 서버로 부터 리턴받는 데이터 타입. xml, json, html, script, text 이 있음.
			success: function(json){
									
				if(json.totalPage != 0) { 
					
				     var totalPage = json.totalPage;
				     var pageBarHTML = "";
				     
				     var blockSize = 3;
				    
       
				     var loop = 1;
				     
                     var pageNo = Math.floor((currentPageNo - 1)/blockSize) * blockSize + 1; 
				    
				     if(pageNo != 1) {
				    	 pageBarHTML += "<div class='page_prev d-flex flex-column align-items-center justify-content-center' onclick='javascript:goSearch(\"" + sort + "\", \"" + (pageNo-1) + "\")'>" +
										"<i class='fas fa-chevron-left'></i>" +
										"</div>";
				     }
				     pageBarHTML += "<ul class='page_nav d-flex flex-row'>"
				     while( !(loop > blockSize || pageNo > totalPage) ) {
				       	 
				    	  if(pageNo == currentPageNo) {
				    		  pageBarHTML += "<li style='cursor: default; color:red;'>" + pageNo + "</li>"; 
				    	  }
				    	  else {
				    	  	  pageBarHTML += "<li onclick='javascript:goSearch(\"" + sort + "\", \"" + (pageNo) + "\")'><a href='javascript:goSearch(\"" + sort + "\", \"" + pageNo + "\")'>" + pageNo + "</a></li>";
				     	  }
                     
				       	 loop++;
				    	 pageNo++;
				     } // end of while-----------------------------------

				     pageBarHTML += "</ul>";
				     
				  	  // *** [다음] 만들기 *** //
				     if( !(pageNo > totalPage) ) {
				    	 pageBarHTML +=  "<div class='page_next d-flex flex-column align-items-center justify-content-center' onclick='javascript:goSearch(\"" + sort + "\", \"" + pageNo + "\")'>" +
										 "<i class='fas fa-chevron-right'></i>" +
										 "</div>";
				     }
					 	
				     $("#pageBar").empty().html(pageBarHTML);
				     
				}
				
				else { // 검색된 데이터가 없는 경우
					 $("#pageBar").empty();
				}
				
				$("#findProduct").text(json.totalCount);

			},// end of success: function()------
			error: function(request, status, error){
				alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
			}
		});// end of $.ajax()-------------------
		
	}// end of makePagebar()---------------------
	
	
</script>

<!-- Home -->

<div class="home">
	<div class="home_background parallax-window" data-parallax="scroll"
		data-image-src="images/shop_background.jpg"></div>
	<div class="home_overlay"></div>
	<div
		class="home_content d-flex flex-column align-items-center justify-content-center">
		<h2 class="home_title">제품목록</h2>
	</div>
</div>

<!-- Shop -->

<div class="shop">
	<div class="container">
		<div class="row">
			<div class="col-lg-3">

				<!-- Shop Sidebar -->
				<div class="shop_sidebar">
					<form name="sidebar">
						<div class="sidebar_section">
							<div class="sidebar_title">카테고리</div>
							<ul class="sidebar_categories">
								<li class="categories" value="100000" style="cursor: pointer;">컴퓨터</li>
								<li class="categories" value="200000" style="cursor: pointer;">노트북</li>
								<li class="categories" value="300000" style="cursor: pointer;">모니터</li>
								<li class="categories" value="400000" style="cursor: pointer;">주변기기</li>
							</ul>
							<input type="hidden" name="category" id="category" />
						</div>
						<div class="sidebar_section filter_by_section">
							<div class="sidebar_title">검색 조건</div>
							<div class="sidebar_subtitle">가격 (만원)</div> 
							<div class="filter_price">
								<br/>
							
								<div class="slider-container">
									<input type="text" name="price" id="slider" class="slider" value=""/>
									<input type="hidden" name="minPrice" id="minPrice"/>
									<input type="hidden" name="maxPrice" id="maxPrice"/>
        						</div>
							</div>
						</div>
						<div class="sidebar_section">
							<div class="sidebar_subtitle color_subtitle">색상</div>
							<ul class="colors_list">
								<li class="color" value="#000000" style="background: #000000; border: solid 1px #000000;"><a style="cursor:pointer;"></a></li>
								<li class="color" value="#999999" style="background: #999999; border: solid 1px #000000;"><a style="cursor:pointer;"></a></li>
								<li class="color" value="#0e8ce4" style="background: #0e8ce4; border: solid 1px #000000;"><a style="cursor:pointer;"></a></li>
								<li class="color" value="#df3b3b" style="background: #df3b3b; border: solid 1px #000000;"><a style="cursor:pointer;"></a></li>
								<li class="color" value="#ffffff" style="background: #ffffff; border: solid 1px #000000;"><a style="cursor:pointer;"></a></li>
							</ul>
							<input type="hidden" id="color" name="color" />
						</div>
						
						<div class="sidebar_section">
							<div class="sidebar_subtitle brands_subtitle">제조사</div>
							<ul class="brands_list">
								<li class="brand" style="cursor:pointer;">애플</li>
								<li class="brand" style="cursor:pointer;">삼성</li>
								<li class="brand" style="cursor:pointer;">아수스</li>
								<li class="brand" style="cursor:pointer;">레노버</li>
								<li class="brand" style="cursor:pointer;">LG</li>
								<li class="brand" style="cursor:pointer;">한성컴퓨터</li>
							</ul>
							<input type="hidden" id="company" name="company"/>
						</div>
						<div id="div_btnFind" align="left" style="padding-left:50px; padding-top:30px;">  
							<button type="button" class="btn btn-success" id="btnFind"
								onClick="goSearch('', '');"
								style="background-color: #3385ff; cursor: pointer;">찾기</button>
						</div>
					</form>
				</div>

			</div>

			<div class="col-lg-9">

				<!-- Shop Content -->

				<div class="shop_content">
					<div class="shop_bar clearfix">
						<div class="shop_product_count">
							<span id="findProduct"></span>개의 상품을 찾았습니다.
						</div>
						<div class="shop_sorting">
							<span>정렬:</span>
							<ul>
								<li><span class="sorting_text" id="sort">판매순</span>
									<ul>
										<li class="shop_sorting_button" onclick="goSearch('판매순', '1');">판매순</li>
										<li class="shop_sorting_button" onclick="goSearch('이름순', '1');">이름순</li>
										<li class="shop_sorting_button" onclick="goSearch('가격순', '1');">가격순</li>
									</ul>
								</li>
							</ul>
						</div>
					</div>
					
					<%-- 상품 리스트 --%>
					<div id="productList"> 
					</div>
					
					<!-- Shop Page Navigation -->
					<div class="shop_page_nav d-flex flex-row" id="pageBar">
					</div>
				</div>

			</div>
		</div>
	</div>
</div>

<jsp:include page="./newProductList.jsp" />

<!-- Brands -->

<div class="brands">
	<div class="container">
		<div class="row">
			<div class="col">
				<div class="brands_slider_container">

					<!-- Brands Slider -->

					<div class="owl-carousel owl-theme brands_slider">

						<div class="owl-item">
							<div
								class="brands_item d-flex flex-column justify-content-center">
								<img src="images/brands_1.jpg" alt="">
							</div>
						</div>
						<div class="owl-item">
							<div
								class="brands_item d-flex flex-column justify-content-center">
								<img src="images/brands_2.jpg" alt="">
							</div>
						</div>
						<div class="owl-item">
							<div
								class="brands_item d-flex flex-column justify-content-center">
								<img src="images/brands_3.jpg" alt="">
							</div>
						</div>
						<div class="owl-item">
							<div
								class="brands_item d-flex flex-column justify-content-center">
								<img src="images/brands_4.jpg" alt="">
							</div>
						</div>
						<div class="owl-item">
							<div
								class="brands_item d-flex flex-column justify-content-center">
								<img src="images/brands_5.jpg" alt="">
							</div>
						</div>
						<div class="owl-item">
							<div
								class="brands_item d-flex flex-column justify-content-center">
								<img src="images/brands_6.jpg" alt="">
							</div>
						</div>
						<div class="owl-item">
							<div
								class="brands_item d-flex flex-column justify-content-center">
								<img src="images/brands_7.jpg" alt="">
							</div>
						</div>
						<div class="owl-item">
							<div
								class="brands_item d-flex flex-column justify-content-center">
								<img src="images/brands_8.jpg" alt="">
							</div>
						</div>

					</div>

					<!-- Brands Slider Navigation -->
					<div class="brands_nav brands_prev">
						<i class="fas fa-chevron-left"></i>
					</div>
					<div class="brands_nav brands_next">
						<i class="fas fa-chevron-right"></i>
					</div>

				</div>
			</div>
		</div>
	</div>
</div>



				
<jsp:include page="../footer.jsp" />
