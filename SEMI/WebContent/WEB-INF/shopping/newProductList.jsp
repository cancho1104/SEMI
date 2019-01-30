<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    
<script type="text/javascript">

	
		
	 $.ajax({
		url: "getNewProdList.do",
		type: "GET",
		dataType: "JSON",
		success: function(json){
			
			var html = "";
			
			if(json.length != 0){
				$.each(json, function(entryIndex, entry){
					html += " <div class='owl-item'> \n" +
							" <div " + ((entryIndex == 0)?"class='viewed_item discount d-flex flex-column align-items-center justify-content-center text-center'> \n":
							"class='viewed_item d-flex flex-column align-items-center justify-content-center text-center'> \n") +
							" <div class='viewed_image'> \n" +
							" <a href='prodView.do?pnum=" + entry.pnum + "'><img src='images/" + entry.pimage + "' style='cursor: pointer;'></a> \n" +
							" </div> \n" +
							" <div class='viewed_content text-center'> \n" +
							" <div class='viewed_price' style='color:red;'> " + entry.saleprice.toLocaleString('en') + "원\n" +
							((entry.percent == 0)?"<br/><br/>":"<br/> <span>" + entry.price.toLocaleString('en') + "원</span> ") +   
							" </div> \n" +
							" <div class='viewed_name'> \n" +
							" <a href='prodView.do?pnum=" + entry.pnum + "'>" + ((entry.pname.length > 10)?entry.pname.substr(0,10):entry.pname) + "</a> \n" +
							" </div> \n" +
							" </div> \n" +
							" <ul class='item_marks'> \n" +
							((entry.percent == 0)?"":" <li class='item_mark item_discount'>" + entry.percent + "%</li> \n") +
							" <li class='item_mark item_new'>new</li> \n" +
							" </ul> \n" +
							" </div> \n" +
							" </div> \n\n";
				});
				
				$("#newContent").html(html);
				
			}// end of if() ---------------------

		},// end of success: function()------
		error: function(request, status, error){
			alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
		}
	});// end of $.ajax()--------------------------------
		
	
	
</script>

<!-- Recently Viewed -->

<div class="viewed">
	<div class="container">
		<div class="row">
			<div class="col">
				<div class="viewed_title_container">
					<h3 class="viewed_title">신상품</h3>
					<div class="viewed_nav_container">
						<div class="viewed_nav viewed_prev">
							<i class="fas fa-chevron-left"></i>
						</div>
						<div class="viewed_nav viewed_next">
							<i class="fas fa-chevron-right"></i>
						</div>
					</div>
				</div>

				<div class="viewed_slider_container">

					<!-- Recently Viewed Slider -->

					<div class="owl-carousel owl-theme viewed_slider" id="newContent">

						<!-- Recently Viewed Item -->
						<div class="owl-item">
							<div
								class="viewed_item discount d-flex flex-column align-items-center justify-content-center text-center">
								<div class="viewed_image">
									<img src="images/view_1.jpg" alt="">
								</div>
								<div class="viewed_content text-center">
									<div class="viewed_price">
										$225<span>$300</span>
									</div>
									<div class="viewed_name">
										<a href="#">Beoplay H7</a>
									</div>
								</div>
								<ul class="item_marks">
									<li class="item_mark item_discount">-25%</li>
									<li class="item_mark item_new">new</li>
								</ul>
							</div>
						</div>

						<!-- Recently Viewed Item -->
						<div class="owl-item">
							<div
								class="viewed_item d-flex flex-column align-items-center justify-content-center text-center">
								<div class="viewed_image">
									<img src="images/view_2.jpg" alt="">
								</div>
								<div class="viewed_content text-center">
									<div class="viewed_price">$379</div>
									<div class="viewed_name">
										<a href="#">LUNA Smartphone</a>
									</div>
								</div>
								<ul class="item_marks">
									<li class="item_mark item_discount">-25%</li>
									<li class="item_mark item_new">new</li>
								</ul>
							</div>
						</div>

						<!-- Recently Viewed Item -->
						<div class="owl-item">
							<div
								class="viewed_item d-flex flex-column align-items-center justify-content-center text-center">
								<div class="viewed_image">
									<img src="images/view_3.jpg" alt="">
								</div>
								<div class="viewed_content text-center">
									<div class="viewed_price">$225</div>
									<div class="viewed_name">
										<a href="#">Samsung J730F...</a>
									</div>
								</div>
								<ul class="item_marks">
									<li class="item_mark item_discount">-25%</li>
									<li class="item_mark item_new">new</li>
								</ul>
							</div>
						</div>

						

						

						
					</div>

				</div>
			</div>
		</div>
	</div>
</div>