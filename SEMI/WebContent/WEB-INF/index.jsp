<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<jsp:include page="mainHeader.jsp"/>

<script src="js/jquery-3.3.1.min.js"></script>

<style type="text/css">

.discount {
	text-align: center;
}

</style>


	<!-- Banner -->

	<div class="banner">
		<div class="banner_2_background" style="background-image:url(images/banner_2_background.jpg)"></div>
		<div class="banner_2_container">
			<div class="banner_2_dots"></div>
			<!-- Banner 2 Slider -->

			<div class="owl-carousel owl-theme banner_2_slider">

				<!-- Banner 2 Slider Item -->
				<div class="owl-item">
					<div class="banner_2_item">
						<div class="container fill_height">
							<div class="row fill_height">
								<div class="col-lg-4 col-md-6 fill_height">
									<div class="banner_2_content">
										<div class="banner_2_category">노트북</div>
										<div class="banner_2_title">맥북 에어 13</div>
										<div class="banner_2_text">지금 바로 구매하세요</div>
										<div class="button banner_2_button"><a href="#">보러가기</a></div>
									</div>
									
								</div>
								<div class="col-lg-8 col-md-6 fill_height">
									<div class="banner_2_image_container">
										<div class="banner_2_image"><img src="images/banner_2_product.png" alt=""></div>
									</div>
								</div>
							</div>
						</div>			
					</div>
				</div>

				<!-- Banner 2 Slider Item -->
				<div class="owl-item">
					<div class="banner_2_item">
						<div class="container fill_height">
							<div class="row fill_height">
								<div class="col-lg-4 col-md-6 fill_height">
									<div class="banner_2_content">
										<div class="banner_2_category">노트북</div>
										<div class="banner_2_title">맥북 에어 13</div>
										<div class="banner_2_text">지금 바로 구매하세요</div>
										<div class="button banner_2_button"><a href="#">보러가기</a></div>
									</div>
									
								</div>
								<div class="col-lg-8 col-md-6 fill_height">
									<div class="banner_2_image_container">
										<div class="banner_2_image"><img src="images/banner_2_product.png" alt=""></div>
									</div>
								</div>
							</div>
						</div>			
					</div>
				</div>

				<!-- Banner 2 Slider Item -->
				<div class="owl-item">
					<div class="banner_2_item">
						<div class="container fill_height">
							<div class="row fill_height">
								<div class="col-lg-4 col-md-6 fill_height">
									<div class="banner_2_content">
										<div class="banner_2_category">노트북</div>
										<div class="banner_2_title">맥북 에어 13</div>
										<div class="banner_2_text">지금 바로 구매하세요</div>
										<div class="button banner_2_button"><a href="#">보러가기</a></div>
									</div>
									
								</div>
								<div class="col-lg-8 col-md-6 fill_height">
									<div class="banner_2_image_container">
										<div class="banner_2_image"><img src="images/banner_2_product.png" alt=""></div>
									</div>
								</div>
							</div>
						</div>			
					</div>
				</div>

			</div>
		</div>
	</div>

	<!-- Deals of the week -->

	<div class="deals_featured" id="BEST">
		<div class="container">
			<div class="row">
				<div class="col d-flex flex-lg-row flex-column align-items-center justify-content-start">
					
					<!-- Deals -->

					<div class="deals">
						<div class="deals_title">판매 top3</div>
						<div class="deals_slider_container">
							
							<!-- Deals Slider -->
							<div class="owl-carousel owl-theme deals_slider">
								
								
								<c:if test="${ top3List != null }">
									<c:forEach var="svo" items="${ top3List }">
										<!-- Deals Item -->
										<div class="owl-item deals_item">
											<div class="deals_image"><a href="prodView.do?pnum=${ svo.pnum }"><img src="images/${ svo.pimage }" alt=""></a></div>
											<div class="deals_content">
												<div class="deals_info_line justify-content-start">
													<div class="deals_item_name">${ svo.pname }</div>
													<div class="deals_item_price_a ml-auto">
													<c:if test="${ svo.percent != 0 }">
														<span style="text-decoration: line-through;"><fmt:formatNumber value="${svo.price}" pattern="###,###" />원</span>
													</c:if>
													</div>
													<div class="deals_item_price ml-auto"><fmt:formatNumber value="${svo.saleprice}" pattern="###,###" />원</div>
												</div>
											</div>
										</div>
									</c:forEach>
								</c:if>
								<c:if test="${ top3List == null }">
									<!-- Deals Item -->
									<div class="owl-item deals_item">
										<div class="deals_content">
											<div class="deals_info_line justify-content-start">
												<div class="deals_item_name" style="text-align: center;">상품 준비중 입니다.</div>
											</div>
										</div>
									</div>
								</c:if>
								

							</div>

						</div>

						<div class="deals_slider_nav_container">
							<div class="deals_slider_prev deals_slider_nav"><i class="fas fa-chevron-left ml-auto"></i></div>
							<div class="deals_slider_next deals_slider_nav"><i class="fas fa-chevron-right ml-auto"></i></div>
						</div>
					</div>
					
					<!-- Featured -->
					<div class="featured">
						<div class="tabbed_container">
							<div class="tabs clearfix tabs-right">
								<div class="new_arrivals_title">BEST</div>
								<ul class="clearfix">
									<li class="active">데스크탑</li>
									<li>노트북</li>
									<li>모니터</li>
									<li>주변기기</li>
								</ul>
								<div class="tabs_line"><span></span></div> 
							</div>

							<!-- Product Panel -->
							<div class="product_panel panel active">
								<div class="featured_slider slider">
									<c:if test="${ bestMap.desktopList == null }">
										<!-- Slider Item -->
										<div class="featured_slider_item">
											<div class="product_price discount">상품 준비중 입니다.</div>
										</div>
									</c:if>
									<c:if test="${ bestMap.desktopList != null }">
									
										<c:forEach var="svo" items="${ bestMap.desktopList }">
											<!-- Slider Item -->
											<div class="featured_slider_item">
												<div class="border_active"></div>
												<div class="product_item discount d-flex flex-column align-items-center justify-content-center text-center" style="cursor: default;">
													<div class="product_image d-flex flex-column align-items-center justify-content-center"><img src="images/${ svo.pimage }" alt="" width="80%"></div>
													<div class="product_content">
														<div class="product_price discount">
															<fmt:formatNumber value="${svo.saleprice}" pattern="###,###" />원<br/>
															<c:if test="${ svo.percent != 0 }">
																<span style="text-decoration: line-through;"><fmt:formatNumber value="${svo.price}" pattern="###,###" />원</span>
															</c:if>
														</div>
														<div class="product_name"><div>${ svo.pname }</div></div>
														<div class="product_extras">
															<button class="product_cart_button" onclick="javascript:location.href = 'prodView.do?pnum=${ svo.pnum }'">보러가기</button>
														</div>
													</div>
													<c:if test="${ svo.percent != 0 }">
														<ul class="product_marks">
															<li class="product_mark product_discount">${ svo.percent }%</li>
														</ul>
													</c:if>
												</div>
											</div>
										</c:forEach>
									
									</c:if>

								</div>
								<div class="featured_slider_dots_cover"></div>
							</div>

							<!-- Product Panel -->
							<div class="product_panel panel">
								<div class="featured_slider slider">
									<c:if test="${ bestMap.laptopList == null }">
										<!-- Slider Item -->
										<div class="featured_slider_item">
											<div class="product_price discount">상품 준비중 입니다.</div>
										</div>
									</c:if>
									<c:if test="${ bestMap.laptopList != null }">
									
										<c:forEach var="svo" items="${ bestMap.laptopList }">
											<!-- Slider Item -->
											<div class="featured_slider_item">
												<div class="border_active"></div>
												<div class="product_item discount d-flex flex-column align-items-center justify-content-center text-center" style="cursor: default;">
													<div class="product_image d-flex flex-column align-items-center justify-content-center"><img src="images/${ svo.pimage }" alt="" width="80%"></div>
													<div class="product_content">
														<div class="product_price discount">
															<fmt:formatNumber value="${svo.saleprice}" pattern="###,###" />원<br/>
															<c:if test="${ svo.percent != 0 }">
																<span style="text-decoration: line-through;"><fmt:formatNumber value="${svo.price}" pattern="###,###" />원</span>
															</c:if>
														</div>
														<div class="product_name"><div>${ svo.pname }</div></div>
														<div class="product_extras">
															<button class="product_cart_button" onclick="javascript:location.href = 'prodView.do?pnum=${ svo.pnum }'">보러가기</button>
														</div>
													</div>
													<c:if test="${ svo.percent != 0 }">
														<ul class="product_marks">
															<li class="product_mark product_discount">${ svo.percent }%</li>
														</ul>
													</c:if>
												</div>
											</div>
										</c:forEach>
									
									</c:if>

								</div>
								<div class="featured_slider_dots_cover"></div>
							</div>

							<!-- Product Panel -->
							<div class="product_panel panel">
								<div class="featured_slider slider">
									<c:if test="${ bestMap.monitorList == null }">
										<!-- Slider Item -->
										<div class="featured_slider_item">
											<div class="product_price discount">상품 준비중 입니다.</div>
										</div>
									</c:if>
									<c:if test="${ bestMap.monitorList != null }">
									
										<c:forEach var="svo" items="${ bestMap.monitorList }">
											<!-- Slider Item -->
											<div class="featured_slider_item">
												<div class="border_active"></div>
												<div class="product_item discount d-flex flex-column align-items-center justify-content-center text-center" style="cursor: default;">
													<div class="product_image d-flex flex-column align-items-center justify-content-center"><img src="images/${ svo.pimage }" alt="" width="80%"></div>
													<div class="product_content">
														<div class="product_price discount">
															<fmt:formatNumber value="${svo.saleprice}" pattern="###,###" />원<br/>
															<c:if test="${ svo.percent != 0 }">
																<span style="text-decoration: line-through;"><fmt:formatNumber value="${svo.price}" pattern="###,###" />원</span>
															</c:if>
														</div>
														<div class="product_name"><div>${ svo.pname }</div></div>
														<div class="product_extras">
															<button class="product_cart_button" onclick="javascript:location.href = 'prodView.do?pnum=${ svo.pnum }'">보러가기</button>
														</div>
													</div>
													<c:if test="${ svo.percent != 0 }">
														<ul class="product_marks">
															<li class="product_mark product_discount">${ svo.percent }%</li>
														</ul>
													</c:if>
												</div>
											</div>
										</c:forEach>
									
									</c:if>

								</div>
								<div class="featured_slider_dots_cover"></div>
							</div>
							
							<!-- Product Panel -->
							<div class="product_panel panel">
								<div class="featured_slider slider">
									<c:if test="${ bestMap.otherList == null }">
										<!-- Slider Item -->
										<div class="featured_slider_item">
											<div class="product_price discount">상품 준비중 입니다.</div>
										</div>
									</c:if>
									<c:if test="${ bestMap.otherList != null }">
									
										<c:forEach var="svo" items="${ bestMap.otherList }">
											<!-- Slider Item -->
											<div class="featured_slider_item">
												<div class="border_active"></div>
												<div class="product_item discount d-flex flex-column align-items-center justify-content-center text-center" style="cursor: default;">
													<div class="product_image d-flex flex-column align-items-center justify-content-center"><img src="images/${ svo.pimage }" alt="" width="80%"></div>
													<div class="product_content">
														<div class="product_price discount">
															<fmt:formatNumber value="${svo.saleprice}" pattern="###,###" />원<br/>
															<c:if test="${ svo.percent != 0 }">
																<span style="text-decoration: line-through;"><fmt:formatNumber value="${svo.price}" pattern="###,###" />원</span>
															</c:if>
														</div>
														<div class="product_name"><div>${ svo.pname }</div></div>
														<div class="product_extras">
															<button class="product_cart_button" onclick="javascript:location.href = 'prodView.do?pnum=${ svo.pnum }'">보러가기</button>
														</div>
													</div>
													<c:if test="${ svo.percent != 0 }">
														<ul class="product_marks">
															<li class="product_mark product_discount">${ svo.percent }%</li>
														</ul>
													</c:if>
												</div>
											</div>
										</c:forEach>
									
									</c:if>

								</div>
								<div class="featured_slider_dots_cover"></div>
							</div>

						</div>
					</div>

				</div>
			</div>
		</div>
	</div>

	

	

	<!-- Hot New Arrivals -->

	<div class="new_arrivals" id="HIT">
		<div class="container">
			<div class="row">
				<div class="col">
					<div class="tabbed_container">
						<div class="tabs clearfix tabs-right">
							<div class="new_arrivals_title">HIT</div>
							<ul class="clearfix">
								<li class="active">데스크탑</li>
								<li>노트북</li>
								<li>모니터</li>
								<li>주변기기</li>
							</ul>
							<div class="tabs_line"><span></span></div>
						</div>
						<div class="row">
							<div class="col-lg-12" style="z-index:1;">

								<!-- Product Panel -->
								<div class="product_panel panel active">
									<div class="arrivals_slider slider">
	
										<c:if test="${ hitMap.desktopList == null }">
											<!-- Slider Item -->
											<div class="featured_slider_item">
												<div class="product_price discount">상품 준비중 입니다.</div>
											</div>
										</c:if>
										
										<c:if test="${ hitMap.desktopList != null }">
											<c:forEach var="svo" items="${ hitMap.desktopList }">
												<!-- Slider Item -->
												<div class="featured_slider_item">
													<div class="border_active"></div>
													<div class="product_item discount d-flex flex-column align-items-center justify-content-center text-center" style="cursor: default;">
														<div class="product_image d-flex flex-column align-items-center justify-content-center"><img src="images/${ svo.pimage }" alt="" width="80%"></div>
														<div class="product_content">
															<div class="product_price discount">
																<fmt:formatNumber value="${svo.saleprice}" pattern="###,###" />원<br/>
																<c:if test="${ svo.percent != 0 }">
																	<span style="text-decoration: line-through;"><fmt:formatNumber value="${svo.price}" pattern="###,###" />원</span>
																</c:if>
															</div>
															<div class="product_name"><div>${ svo.pname }</div></div>
															<div class="product_extras">
																<button class="product_cart_button" onclick="javascript:location.href = 'prodView.do?pnum=${ svo.pnum }'">보러가기</button>
															</div>
														</div>
														<c:if test="${ svo.percent != 0 }">
															<ul class="product_marks">
																<li class="product_mark product_discount">${ svo.percent }%</li>
															</ul>
														</c:if>
													</div>
												</div>
											</c:forEach>
										</c:if>
										
										
										
									</div>
									<div class="featured_slider_dots_cover"></div>
								</div>
									
								<!-- Product Panel -->
								<div class="product_panel panel">
									<div class="arrivals_slider slider">
	
										<c:if test="${ hitMap.laptopList == null }">
											<!-- Slider Item -->
											<div class="featured_slider_item">
												<div class="product_price discount">상품 준비중 입니다.</div>
											</div>
										</c:if>
										
										<c:if test="${ hitMap.laptopList != null }">
											<c:forEach var="svo" items="${ hitMap.laptopList }">
												<!-- Slider Item -->
												<div class="featured_slider_item">
													<div class="border_active"></div>
													<div class="product_item discount d-flex flex-column align-items-center justify-content-center text-center" style="cursor: default;">
														<div class="product_image d-flex flex-column align-items-center justify-content-center"><img src="images/${ svo.pimage }" alt="" width="80%"></div>
														<div class="product_content">
															<div class="product_price discount">
																<fmt:formatNumber value="${svo.saleprice}" pattern="###,###" />원<br/>
																<c:if test="${ svo.percent != 0 }">
																	<span style="text-decoration: line-through;"><fmt:formatNumber value="${svo.price}" pattern="###,###" />원</span>
																</c:if>
															</div>
															<div class="product_name"><div>${ svo.pname }</div></div>
															<div class="product_extras">
																<button class="product_cart_button" onclick="javascript:location.href = 'prodView.do?pnum=${ svo.pnum }'">보러가기</button>
															</div>
														</div>
														<c:if test="${ svo.percent != 0 }">
															<ul class="product_marks">
																<li class="product_mark product_discount">${ svo.percent }%</li>
															</ul>
														</c:if>
													</div>
												</div>
											</c:forEach>
										</c:if>
										
									</div>
									<div class="featured_slider_dots_cover"></div>
								</div>
	
								<!-- Product Panel -->
								<div class="product_panel panel">
									<div class="arrivals_slider slider">
	
										<c:if test="${ hitMap.monitorList == null }">
											<!-- Slider Item -->
											<div class="featured_slider_item">
												<div class="product_price discount">상품 준비중 입니다.</div>
											</div>
										</c:if>
										
										<c:if test="${ hitMap.monitorList != null }">
											<c:forEach var="svo" items="${ hitMap.monitorList }">
												<!-- Slider Item -->
												<div class="featured_slider_item">
													<div class="border_active"></div>
													<div class="product_item discount d-flex flex-column align-items-center justify-content-center text-center" style="cursor: default;">
														<div class="product_image d-flex flex-column align-items-center justify-content-center"><img src="images/${ svo.pimage }" alt="" width="80%"></div>
														<div class="product_content">
															<div class="product_price discount">
																<fmt:formatNumber value="${svo.saleprice}" pattern="###,###" />원<br/>
																<c:if test="${ svo.percent != 0 }">
																	<span style="text-decoration: line-through;"><fmt:formatNumber value="${svo.price}" pattern="###,###" />원</span>
																</c:if>
															</div>
															<div class="product_name"><div>${ svo.pname }</div></div>
															<div class="product_extras">
																<button class="product_cart_button" onclick="javascript:location.href = 'prodView.do?pnum=${ svo.pnum }'">보러가기</button>
															</div>
														</div>
														<c:if test="${ svo.percent != 0 }">
															<ul class="product_marks">
																<li class="product_mark product_discount">${ svo.percent }%</li>
															</ul>
														</c:if>
													</div>
												</div>
											</c:forEach>
										</c:if>
										
									</div>
									<div class="featured_slider_dots_cover"></div>
								</div>
								
								<!-- Product Panel -->
								<div class="product_panel panel">
									<div class="arrivals_slider slider">
	
										<c:if test="${ hitMap.otherList == null }">
											<!-- Slider Item -->
											<div class="featured_slider_item">
												<div class="product_price discount">상품 준비중 입니다.</div>
											</div>
										</c:if>
										
										<c:if test="${ hitMap.otherList != null }">
											<c:forEach var="svo" items="${ hitMap.otherList }">
												<!-- Slider Item -->
												<div class="featured_slider_item">
													<div class="border_active"></div>
													<div class="product_item discount d-flex flex-column align-items-center justify-content-center text-center" style="cursor: default;">
														<div class="product_image d-flex flex-column align-items-center justify-content-center"><img src="images/${ svo.pimage }" alt="" width="80%"></div>
														<div class="product_content">
															<div class="product_price discount">
																<fmt:formatNumber value="${svo.saleprice}" pattern="###,###" />원<br/>
																<c:if test="${ svo.percent != 0 }">
																	<span style="text-decoration: line-through;"><fmt:formatNumber value="${svo.price}" pattern="###,###" />원</span>
																</c:if>
															</div>
															<div class="product_name"><div>${ svo.pname }</div></div>
															<div class="product_extras">
																<button class="product_cart_button" onclick="javascript:location.href = 'prodView.do?pnum=${ svo.pnum }'">보러가기</button>
															</div>
														</div>
														<c:if test="${ svo.percent != 0 }">
															<ul class="product_marks">
																<li class="product_mark product_discount">${ svo.percent }%</li>
															</ul>
														</c:if>
													</div>
												</div>
											</c:forEach>
										</c:if>
										
									</div>
									<div class="featured_slider_dots_cover"></div>
								</div>

							</div>

						</div>
								
					</div>
				</div>
			</div>
		</div>		
	</div>

	<!-- Best Sellers -->

	<div class="best_sellers" id="NEW">
		<div class="container">
			<div class="row">
				<div class="col">
					<div class="tabbed_container">
						<div class="tabs clearfix tabs-right">
							<div class="new_arrivals_title">NEW</div>
							<ul class="clearfix">
								<li class="active">데스크탑</li>
								<li>노트북</li>
								<li>모니터</li>
								<li>주변기기</li>
							</ul>
							<div class="tabs_line"><span></span></div>
						</div>

						<div class="bestsellers_panel panel active">

							<!-- Best Sellers Slider -->

							<div class="bestsellers_slider slider">
								<c:if test="${ newMap.desktopList == null }">
									<!-- Best Sellers Item -->
									<div class="bestsellers_item product_price discount">
										상품 준비중 입니다.
									</div>
								</c:if>
								
								<c:if test="${ newMap.desktopList != null }"> 
								
									<c:forEach var="svo" items="${ newMap.desktopList }">
										<!-- Best Sellers Item -->
										<div class="bestsellers_item discount">
											<div class="bestsellers_item_container d-flex flex-row align-items-center justify-content-start">
												<div class="bestsellers_image"><img src="images/${ svo.pimage }" alt=""></div>
												<div class="bestsellers_content">
													<div class="bestsellers_category"><a>${ svo.fk_bcode }</a></div>
													<div class="bestsellers_name"><a>${ svo.pname }</a></div>
													<div class="bestsellers_price discount">
														<fmt:formatNumber value="${svo.saleprice}" pattern="###,###" />원
														<c:if test="${ svo.percent != 0 }">
															<span><fmt:formatNumber value="${svo.price}" pattern="###,###" />원</span>
														</c:if>
													</div>
													<div class="button banner_2_button" style="margin-top: 0px;"><a href="prodView.do?pnum=${ svo.pnum }">보러가기</a></div>
												</div>
											</div>
											<c:if test="${ svo.percent != 0 }">
												<ul class="bestsellers_marks">
													<li class="bestsellers_mark bestsellers_discount">${ svo.percent }%</li>
												</ul>
											</c:if>
										</div>
									</c:forEach>
									
								</c:if>
								
							</div>
						</div>

						<div class="bestsellers_panel panel">

							<!-- Best Sellers Slider -->

							<div class="bestsellers_slider slider">
								<c:if test="${ newMap.laptopList == null }">
									<!-- Best Sellers Item -->
									<div class="bestsellers_item product_price discount">
										상품 준비중 입니다.
									</div>
								</c:if>
								
								<c:if test="${ newMap.laptopList != null }"> 
								
									<c:forEach var="svo" items="${ newMap.laptopList }">
										<!-- Best Sellers Item -->
										<div class="bestsellers_item discount">
											<div class="bestsellers_item_container d-flex flex-row align-items-center justify-content-start">
												<div class="bestsellers_image"><img src="images/${ svo.pimage }" alt=""></div>
												<div class="bestsellers_content">
													<div class="bestsellers_category"><a>${ svo.fk_bcode }</a></div>
													<div class="bestsellers_name"><a>${ svo.pname }</a></div>
													<div class="bestsellers_price discount">
														<fmt:formatNumber value="${svo.saleprice}" pattern="###,###" />원
														<c:if test="${ svo.percent != 0 }">
															<span><fmt:formatNumber value="${svo.price}" pattern="###,###" />원</span>
														</c:if>
													</div>
													<div class="button banner_2_button" style="margin-top: 0px;"><a href="prodView.do?pnum=${ svo.pnum }">보러가기</a></div>
												</div>
											</div>
											<c:if test="${ svo.percent != 0 }">
												<ul class="bestsellers_marks">
													<li class="bestsellers_mark bestsellers_discount">${ svo.percent }%</li>
												</ul>
											</c:if>
										</div>
									</c:forEach>
									
								</c:if>
								
							</div>
							
						</div>

						<div class="bestsellers_panel panel">

							<!-- Best Sellers Slider -->

							<div class="bestsellers_slider slider">
								<c:if test="${ newMap.monitorList == null }">
									<!-- Best Sellers Item -->
									<div class="bestsellers_item product_price discount">
										상품 준비중 입니다.
									</div>
								</c:if>
								
								<c:if test="${ newMap.monitorList != null }"> 
								
									<c:forEach var="svo" items="${ newMap.monitorList }">
										<!-- Best Sellers Item -->
										<div class="bestsellers_item discount">
											<div class="bestsellers_item_container d-flex flex-row align-items-center justify-content-start">
												<div class="bestsellers_image"><img src="images/${ svo.pimage }" alt=""></div>
												<div class="bestsellers_content">
													<div class="bestsellers_category"><a>${ svo.fk_bcode }</a></div>
													<div class="bestsellers_name"><a>${ svo.pname }</a></div>
													<div class="bestsellers_price discount">
														<fmt:formatNumber value="${svo.saleprice}" pattern="###,###" />원
														<c:if test="${ svo.percent != 0 }">
															<span><fmt:formatNumber value="${svo.price}" pattern="###,###" />원</span>
														</c:if>
													</div>
													<div class="button banner_2_button" style="margin-top: 0px;"><a href="prodView.do?pnum=${ svo.pnum }">보러가기</a></div>
												</div>
											</div>
											<c:if test="${ svo.percent != 0 }">
												<ul class="bestsellers_marks">
													<li class="bestsellers_mark bestsellers_discount">${ svo.percent }%</li>
												</ul>
											</c:if>
										</div>
									</c:forEach>
									
								</c:if>
								
							</div>
						</div>
						
						<div class="bestsellers_panel panel">

							<!-- Best Sellers Slider -->

							<div class="bestsellers_slider slider">
								<c:if test="${ newMap.otherList == null }">
									<!-- Best Sellers Item -->
									<div class="bestsellers_item product_price discount">
										상품 준비중 입니다.
									</div>
								</c:if>
								
								<c:if test="${ newMap.otherList != null }"> 
								
									<c:forEach var="svo" items="${ newMap.otherList }">
										<!-- Best Sellers Item -->
										<div class="bestsellers_item discount">
											<div class="bestsellers_item_container d-flex flex-row align-items-center justify-content-start">
												<div class="bestsellers_image"><img src="images/${ svo.pimage }" alt=""></div>
												<div class="bestsellers_content">
													<div class="bestsellers_category"><a>${ svo.fk_bcode }</a></div>
													<div class="bestsellers_name"><a>${ svo.pname }</a></div>
													<div class="bestsellers_price discount">
														<fmt:formatNumber value="${svo.saleprice}" pattern="###,###" />원
														<c:if test="${ svo.percent != 0 }">
															<span><fmt:formatNumber value="${svo.price}" pattern="###,###" />원</span>
														</c:if>
													</div>
													<div class="button banner_2_button" style="margin-top: 0px;"><a href="prodView.do?pnum=${ svo.pnum }">보러가기</a></div>
												</div>
											</div>
											<c:if test="${ svo.percent != 0 }">
												<ul class="bestsellers_marks">
													<li class="bestsellers_mark bestsellers_discount">${ svo.percent }%</li>
												</ul>
											</c:if>
										</div>
									</c:forEach>
									
								</c:if>
								
							</div>
						</div>
						
					</div>
						
				</div>
			</div>
		</div>
	</div>

	

	
	<!-- Brands -->

	<div class="brands">
		<div class="container">
			<div class="row">
				<div class="col">
					<div class="brands_slider_container">
						
						<!-- Brands Slider -->

						<div class="owl-carousel owl-theme brands_slider">
							
							<div class="owl-item"><div class="brands_item d-flex flex-column justify-content-center"><img src="images/brands_1.jpg" alt=""></div></div>
							<div class="owl-item"><div class="brands_item d-flex flex-column justify-content-center"><img src="images/brands_2.jpg" alt=""></div></div>
							<div class="owl-item"><div class="brands_item d-flex flex-column justify-content-center"><img src="images/brands_3.jpg" alt=""></div></div>
							<div class="owl-item"><div class="brands_item d-flex flex-column justify-content-center"><img src="images/brands_4.jpg" alt=""></div></div>
							<div class="owl-item"><div class="brands_item d-flex flex-column justify-content-center"><img src="images/brands_5.jpg" alt=""></div></div>
							<div class="owl-item"><div class="brands_item d-flex flex-column justify-content-center"><img src="images/brands_6.jpg" alt=""></div></div>
							<div class="owl-item"><div class="brands_item d-flex flex-column justify-content-center"><img src="images/brands_7.jpg" alt=""></div></div>
							<div class="owl-item"><div class="brands_item d-flex flex-column justify-content-center"><img src="images/brands_8.jpg" alt=""></div></div>

						</div>
						
						<!-- Brands Slider Navigation -->
						<div class="brands_nav brands_prev"><i class="fas fa-chevron-left"></i></div>
						<div class="brands_nav brands_next"><i class="fas fa-chevron-right"></i></div>

					</div>
				</div>
			</div>
		</div>
	</div>

<jsp:include page="mainFooter.jsp"/>
