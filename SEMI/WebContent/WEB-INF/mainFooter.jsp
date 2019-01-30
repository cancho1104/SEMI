<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>     
	<!-- Footer -->

	<footer class="footer" style="background-color: #e6e6e6">
		<div class="container">
			<div class="row">

				<div class="col-lg-3 footer_col">
					<div class="footer_column footer_contact">
						<div class="logo_container">
							<div class="logo"><a href="#">PineApple</a></div>
						</div>
						<div class="footer_contact_text">
							<p>서울 중구 남대문로 120 대일빌딩 3층</p>
						</div>
					</div>
				</div>

				<div class="col-lg-2 offset-lg-2">
					<div class="footer_column">
						<div class="footer_title">바로가기</div>
						<ul class="footer_list">
							<li><a href="#">데스크탑</a></li>
							<li><a href="#">노트북</a></li>
							<li><a href="#">모니터</a></li>
							<li><a href="#">주변기기</a></li>
						</ul>
					</div>
				</div>

				<div class="col-lg-2">
					<div class="footer_column">
						<div class="footer_title">빨리찾기</div>
						<ul class="footer_list footer_list_2">
							<li><a href="#">베스트 셀러<i class=""></i></a></li>
							<li><a href="#">HIT 상품<i class=""></i></a></li>
							<li><a href="">NEW 제품<i class=""></i></a></li>
						</ul>
					</div>
				</div>

				<div class="col-lg-2">
					<div class="footer_column">
						<div class="footer_title">고객기능</div>
						<ul class="footer_list">
							<c:if test="${ sessionScope.loginuser == null && sessionScope.loginadmin == null }">
								<li><a href="#">로그인</a></li>
								<li><a href="#">회원가입</a></li>
							</c:if>
							<c:if test="${ sessionScope.loginuser != null && sessionScope.loginadmin == null }">
								<li><a href="#">내정보</a></li>
								<li><a href="#">로그아웃</a></li>
							</c:if>
							<c:if test="${ sessionScope.loginadmin != null && sessionScope.loginuser == null }">
								<li><a href="#">회원관리</a></li>
								<li><a href="#">상품관리</a></li>
								<li><a href="#">로그아웃</a></li>
							</c:if>
							<li><a href="#">장바구니</a></li>
							<li><a href="#">리뷰</a></li>
							<li><a href="#">고객센터</a></li>
						</ul>
					</div>
				</div>

			</div>
		</div>
	</footer>

	<!-- Copyright -->

	<div class="copyright">
		<div class="container">
			<div class="row">
				<div class="col">
					
					<div class="copyright_container d-flex flex-sm-row flex-column align-items-center justify-content-start">
						<div class="copyright_content"><!-- Link back to Colorlib can't be removed. Template is licensed under CC BY 3.0. -->
Copyright &copy;<script>document.write(new Date().getFullYear());</script> All rights reserved
<!-- Link back to Colorlib can't be removed. Template is licensed under CC BY 3.0. -->
</div>
						
					</div>
				</div>
			</div>
		</div>
	</div>
</div>

<script src="js/jquery-3.3.1.min.js"></script>
<script src="styles/bootstrap4/popper.js"></script>
<script src="styles/bootstrap4/bootstrap.min.js"></script>
<script src="plugins/greensock/TweenMax.min.js"></script>
<script src="plugins/greensock/TimelineMax.min.js"></script>
<script src="plugins/scrollmagic/ScrollMagic.min.js"></script>
<script src="plugins/greensock/animation.gsap.min.js"></script>
<script src="plugins/greensock/ScrollToPlugin.min.js"></script>
<script src="plugins/OwlCarousel2-2.2.1/owl.carousel.js"></script>
<script src="plugins/slick-1.8.0/slick.js"></script>
<script src="plugins/easing/easing.js"></script>
<script src="js/custom.js"></script>
</body>

</html>