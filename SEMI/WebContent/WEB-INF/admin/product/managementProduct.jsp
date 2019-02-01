<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="../../adminHeader.jsp"/>

<link rel="stylesheet" type="text/css" href="styles/shop_styles.css">
<link rel="stylesheet" type="text/css" href="styles/shop_responsive.css">
<link rel="stylesheet" type="text/css" href="styles/blog_styles.css">
<link rel="stylesheet" type="text/css" href="styles/blog_responsive.css">

<div class="home">
	<div class="home_overlay"></div>
	<div class="home_content d-flex flex-column align-items-center justify-content-center">
		<h2 class="home_title">상품관리</h2>
	</div>
</div>

<div class="blog">
	<div class="container">
		<div class="row">
			<div class="col">
				<div class="blog_posts d-flex flex-row align-items-start justify-content-between">
					
					<!-- Blog post -->
					<div class="blog_post" style="cursor: pointer;" onclick="javascript:location.href='prodList.do'">
						<div class="blog_image" style="background-image:url(images/blog_1.jpg)"></div>
						<div class="blog_text" style="text-align: center;">제품관리</div>
						<div class="blog_button"><a href="prodList.do">이동하기</a></div>
					</div>

					<!-- Blog post -->
					<div class="blog_post" style="cursor: pointer;" onclick="javascript:location.href='registerProduct.do'">
						<div class="blog_image" style="background-image:url(images/blog_2.jpg)"></div>
						<div class="blog_text" style="text-align: center;">제품등록</div>
						<div class="blog_button"><a href="registerProduct.do">이동하기</a></div>
					</div>
					
				</div>
			</div>
				
		</div>
	</div>
</div>

<jsp:include page="../../adminFooter.jsp"/>