<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page="../header.jsp" />
<link rel="stylesheet" type="text/css" href="styles/product_styles.css">
<link rel="stylesheet" type="text/css"
	href="styles/product_responsive.css">
<script src="styles/bootstrap4/popper.js"></script>
<script src="styles/bootstrap4/bootstrap.min.js"></script>
<script src="plugins/greensock/TweenMax.min.js"></script>
<script src="plugins/greensock/TimelineMax.min.js"></script>
<script src="plugins/scrollmagic/ScrollMagic.min.js"></script>
<script src="plugins/greensock/animation.gsap.min.js"></script>
<script src="plugins/greensock/ScrollToPlugin.min.js"></script>
<script src="plugins/easing/easing.js"></script>

<style>
.spec th{
	padding:4px;font-size:12px;LETTER-SPACING: -1px;FONT-FAMILY: 돋움;
	width:25%;
	height:38px;
	background:#b3e0ff;
	text-align: center;
	
}
.spec td{
	padding:4px;font-size:12px;LETTER-SPACING: -1px;FONT-FAMILY: 돋움;
	width:75%;
	height:38px;
	background:white;
	text-align:left;
}
div.section > div {width:100%;display:inline-flex;}
div.section > div > input {margin:0;padding-left:5px;font-size:10px;padding-right:5px;max-width:18%;text-align:center;}
.attr,.attr2{cursor:pointer;margin-right:5px;height:20px;font-size:13px;padding:2px;border:1px solid gray;border-radius:2px;}
.active{ border:1px solid orange;}

</style>
<script>
$(document).ready(function(){
    //-- Click on detail
    $("ul.menu-items > li").on("click",function(){
        $("ul.menu-items > li").removeClass("active");
        $(this).addClass("active");
    })

    $(".attr.color").on("click",function(){
        $(".attr.color").removeClass("active");
        $(this).addClass("active");
        if($(this).is(".color")){
        	var color = $(this).attr('style');
        	color = color.substring(color.indexOf('#'),color.length-1);
        	$("#color").val(color);
        }
       
    })
    $(".attr2.ram").on("click",function(){

        $(".attr2.ram").removeClass("active");
        $(this).addClass("active");
       
        if($(this).is(".ram")){
        	var ram = $(this).text();
        	$("#ram").val(ram);
        	console.log("ram:"+ram);	
        }
    })
     $(".attr2.HDD, .attr2.SSD").on("click",function(){

        $(".attr2.HDD, .attr2.SSD").removeClass("active");
        $(this).addClass("active");
       
        if($(this).is(".HDD")){
        	var disk = $(this).text();
        	$("#disk").val("HDD"+disk);
        	console.log("disk:"+disk);
        }else{
        	var disk = $(this).text();
        	$("#disk").val("SSD"+disk);
        	console.log("disk:"+disk);
        }
    })

    //-- Click on QUANTITY
    $(".btn-minus").on("click",function(){
        var now = $(".section > div > input").val();
        if ($.isNumeric(now)){
            if (parseInt(now) -1 > 0){ now--;}
            $(".section > div > input").val(now);
        }else{
            $(".section > div > input").val("1");
        }
    })            
    $(".btn-plus").on("click",function(){
        var now = $(".section > div > input").val();
        if ($.isNumeric(now)){
            $(".section > div > input").val(parseInt(now)+1);
        }else{
            $(".section > div > input").val("1");
        }
    })                        
}) 
</script>
<%-- contents start --%>
<!-- Single Product -->
<div class="single_product">
	<div class="container">
		<c:if test="${ svo == null }">
			<h1>상품이 존재하지 않습니다.</h1>
		</c:if>
		
		<c:if test="${ svo != null }">
			<div class="row">
				
				<!-- Selected Image -->
				<div class="col-lg-7 order-lg-3 order-3">
					<div class="image_selected">
						<img src="images/${ svo.pimage }" alt="" width="100%" height="100%"> 
					</div>
				</div>
				
				
				<!-- Description -->
				<div class="col-lg-5 order-3">
					<div class="product_description">
						<div class="product_category">${ svo.fk_bcode }</div>
						<div class="product_name">${ svo.pname }</div>
	
						<div class="product_text">
							<p>
								<%--제품설명 들어가는 칸 --%>
								${ svo.pcontent }
							</p>
						</div>
					</div>
					<br /> <br />
					<form>
	
						<div style="margin-left: 30px; border: 0px solid gray;">
							<div>
								<h4 style="display: inline; margin: 4px;"> <label   
									for="sel0"><small>수량</small>&nbsp;: </label> 
								</h4> <input class="form-control"
									style="margin-left: 5px; width: 65px; display: inline-block;"
									type="number" name="quantity" id="sel0" min="1" max="99"
									value="1" />
								<c:if test="${ colorList != null }">
									<div class="section">
										<h4 class="title-attr" style="margin-top: 15px;">
											<small>COLOR</small>
										</h4>
										
										<div>
										<%-- 색깔을 DB에 입력할땐 무조건 7자리 코드 + 색깔명으로 입력할것 --%>
											<c:forEach var="colorMap" items="${ colorList }">
												<div class="attr color" style="width: 25px; background:${ colorMap.color };"></div>
											</c:forEach>
										
										</div>
									
										<input type="hidden" name="color" id="color" value=""/>  
									</div>
								</c:if>
	
								
							</div>
	
							<div style="margin-top: 10px;">
								<c:if test="${ ramList != null }">
									<div class="section" style="padding-bottom: 5px;">
										<h4 class="title-attr">
											<small>RAM</small>
										</h4>
										<div>
											<c:forEach var="ramMap" items="${ ramList }">
												<div class="attr2 ram" >${ ramMap.ramtype } GB</div>
											</c:forEach>
											<input type="hidden" name="ram" id="ram" value="" />
										</div>
									</div>
								</c:if>
							
								<c:if test="${ hddList != null || ssdList != null }">
									<div class="section" style="padding-bottom: 5px; margin-top:4px;">
										<h4 class="title-attr" >
											<small>DISK</small>
										</h4>
										<div>
											<c:if test="${ hddList != null }">
												<h6 class="title-attr" style="margin-right:10px;"><small>HDD</small></h6>
												<c:forEach var="storageMap" items="${ hddList }">
													<div class="attr2 HDD">${ storageMap.strgsize }</div>
												</c:forEach>
											</c:if>
											<c:if test="${ hddList != null && ssdList != null }">
												<h4 style="font-weight: lighter; margin-right:5px;">/</h4>
											</c:if>
											<c:if test="${ ssdList != null }">
												<h6 class="title-attr" style="margin-right:10px;"><small>SSD</small></h6>
												<c:forEach var="storageMap" items="${ ssdList }">
													<div class="attr2 SSD">${ storageMap.strgsize }</div>
												</c:forEach>
											</c:if>
											<input type="hidden" name="disk" value="" id="disk"/>
										</div>
									</div>
								</c:if>
								
							</div>
	
						</div>
	
						<div class="button_container" style="margin-left: 24px;">
							<button type="button" class="button cart_button">장바구니 추가</button>
							<button type="button" class="button cart_button">구매하기</button> 
						</div>
	
					</form>
	
				</div>
	
			</div>
			<%-- end class=col-lg-5 order-3 --%>
	
	
			<%-- /.row --%>
	
			
			
			
			<div class="container">
				<div class="row clearfix"  style="border-bottom: 1px gray solid; border-top: 1px gray solid; margin-top: 30px;">
	 
					<!-- Related Projects Row -->
					<h3 class="my-4">제품상세</h3>
				</div>
				<c:if test="${ imageList != null }">
					<div class="row">
		
						<div class="col-md-12 col-sm-12 mb-12" style="text-align: center; padding-top: 30px;">
							<c:forEach var="imgMap" items="${ imageList }">
								<img src="images/${ imgMap.dimage }" width="80%" alt=""/>
							</c:forEach>
							
						</div>
		
					</div>
				</c:if>
				
			</div>
			
			<c:if test="${ prodSpec != null }">
				<%-- 상세스펙 시작--%>
				<div class="container" style="margin-left:0px;">
					<h3 class="product_name clearfix" valign="bottom" style=" font-weight:bold; margin-top:30px;  text-align: center;">상세스펙</h3> 
					<div class="row clearfix">
						
						
							<table class="col-md-6 col-sm-6 mb-6 spec" style="border-top:1px solid #0099ff; border-bottom:1px solid #1aa3ff; margin: auto;">
								<tr>
									<th>제품명</th>
									<td>${ svo.pname }</td>
								</tr>
								
								<c:if test="${ prodSpec.cpu != null }">
									<tr>
										<th>CPU</th>
										<td>${ prodSpec.cpu }</td>
									</tr>
								</c:if>
								
								<c:if test="${ prodSpec.mainboard != null }">
									<tr>
										<th>메인보드</th>
										<td>${ prodSpec.mainboard }</td>
									</tr>
								</c:if>
								<c:if test="${ prodSpec.power != null }">
									<tr>
										<th>전원</th>
										<td>${ prodSpec.power }</td>
									</tr>
								</c:if>
								<c:if test="${ prodSpec.pcCase != null }">
									<tr>
										<th>케이스</th>
										<td>${ prodSpec.pcCase }</td>
									</tr>
								</c:if>
								<c:if test="${ prodSpec.os != null }">
									<tr>
										<th>운영체제</th>
										<td>${ prodSpec.os }</td>
									</tr>
								</c:if>
		
							</table>
						
					</div>
				</div>
				<%-- 상세스펙 끝 --%>
			</c:if>
			
			<%-- 리뷰 페이지 --%>
	
			<table class="table table-hover "
				style="margin-top: 130px; text-align: center;">
				<thead class="container-fluid">
					<tr class="row">
						<th style="color: #0e8ce4;" class="col-md-1">리뷰번호</th>
						<th style="color: #0e8ce4;" class="col-md-2">제품명</th>
						<th style="color: #0e8ce4;" class="col-md-4"
							style="margin-left:10px;">리뷰제목</th>
						<th style="color: #0e8ce4;" class="col-md-1">작성자</th>
						<th style="color: #0e8ce4;" class="col-md-3">리뷰작성일</th>
						<th style="color: #0e8ce4;" class="col-md-1">조회수</th>
					</tr>
				</thead>
	
				<tbody class="container-fluid">
					<tr class="row">
						<td class="td" class="col-md-1"></td>
						<td class="td name" class="col-md-2"></td>
						<%--  자바스크립트에서 페이지이동은 location.href="이동해야할 페이지명"; 으로 한다. --%>
						<td class="td" class="col-md-4"></td>
						<td class="td" class="col-md-1"></td>
						<td class="td" class="col-md-3"></td>
						<td class="td" class="col-md-1"></td>
					</tr>
	
	
				</tbody>
	
				<%-- 페이징 처리용 --%>
				<tfoot class="container-fluid">
					<tr class="row">
						<td class="col-md-3"></td>
						<td class="col-md-5">페이지</td>
						<td class="col-md-4" style="color: #0e8ce4;">현재[<span
							style="color: #FF6347;">${currentShowPageNo}</span>]페이지 /
							총[${totalPage}]페이지 &nbsp; 회원수 : 총 ${totaluserCount}명
						</td>
					</tr>
				</tfoot>
	
			</table>
		</c:if>
		<%-- 리뷰페이지 끝 --%>
	</div>

</div>

<jsp:include page="./newProductList.jsp" />

<!-- contents end-->
<jsp:include page="../footer.jsp" />