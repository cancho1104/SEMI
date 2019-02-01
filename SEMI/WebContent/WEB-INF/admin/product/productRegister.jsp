<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!------ Include the above in your HEAD tag ---------->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<% String ctxPath = request.getContextPath(); %>

<jsp:include page="../../adminHeader.jsp"/>

<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<script src="//code.jquery.com/jquery-1.11.1.min.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.6.1/css/font-awesome.min.css">
<link rel="stylesheet" href="styles/registerstyle.css">
<link rel="stylesheet" type="text/css" href="styles/shop_styles.css">
<link rel="stylesheet" type="text/css" href="styles/shop_responsive.css"> 

<link rel="stylesheet" href="styles/selectstyle.css">


<!-- Google Fonts -->
<link href='https://fonts.googleapis.com/css?family=Passion+One' rel='stylesheet' type='text/css'>
<link href='https://fonts.googleapis.com/css?family=Oxygen' rel='stylesheet' type='text/css'>
 
<title>제품등록</title>

<style type="text/css">

</style>

<script type="text/javascript">
	$(document).ready(function() {
		
		// 이미지 등록 시작 ------------------------------------
		
		var imagePath = "";
		
		$(".fileSearch").hide();
 		var i = 0;
		$("#add_row").click(function() {
			i++;			
			$(".tbl-img").append("<tr id='addr"+i+"'>"+$(".imgRow").html()+"</tr>");
			$("#addr"+i).find(".idx").empty().text(i+1);

			console.log(i);
		});
		
		$("#delete_row").click(function() {
			if(i<1) {
				alert("삭제불가");
				return ;
			}
			$("#tbl-img").find("#addr"+i).remove();
			i--;
			console.log(i);
		});

		$(document).on("click", ".btnFile", function() {
			$(this).parent().parent().find(".fileSearch").trigger("click");
		});

		$(document).on("change", ".fileSearch", function() {
			var pimages = $(this).val();
			pimages = pimages.substring(pimages.lastIndexOf("\\")+1);
			console.log(pimages);
			$(this).parent().parent().find(".pimages").val(pimages);
		});
		
		$("#applyImg").click(function() {
			var addRoot = "";
			
			$(".pimages").each(function() {
				var root = $(this).val().trim();
				root = root.substring(root.lastIndexOf("\\")+1);

				if(root != "") {
					addRoot += root+",";
				}
			});// end of each
			
			var cnt = 0;
			
			addRoot = addRoot.substring(0,addRoot.length-1);
			
		//	console.log(addRoot);
			$("#pimages").val(addRoot);
		});
		
		// 이미지 등록 끝-----------------------------------------------------------------
		
		$(".screenSet").attr("disabled", true); 
		
		$(".btn-select").each(function (e) {
	        var text = $(this).find("ul li.selected").html();
	        var value = $(this).find("ul li.selected").val();
	        if (value != undefined) {
	            $(this).find(".btn-select-input").val(value);
	            $(this).find(".btn-select-value").html(text);
	        }
	    });
		
		/* 색상 이미지태그를 누를경우 */
		$(".colors").click(function() {
			var url = "insertColors.do";
			window.open(url, "colors", "left=500px, top=100px, width=700px, height=400px");
		});
		
		/* 저장장치 버튼을 누를 경우 */
		$(".storages").click(function() {
			// 팝업창 띄우기
			var url = "insertStorages.do";
			window.open(url, "storages", "left=500px, top=100px, width=700px, height=400px");
		});

		/* 램 버튼을 누를 경우 */
		$(".rams").click(function() {
			// 팝업창 띄우기
			var url = "insertRAMS.do";
			window.open(url, "rams", "left=500px, top=100px, width=700px, height=400px");
		});
		
		$("#company").change(function() {
			var company = $(this).val();

			if(company != "0")
				$("#os").val("Windows 10");
			else
				$("#os").val("Mac OS");
		});

	});// end of document ready

	$(document).on('click', '.btn-select', function (e) {
	    e.preventDefault();
	    
	    var ul = $(this).find("ul");
	    if ($(this).hasClass("active")) {
	        if (ul.find("li").is(e.target)) {
	            var target = $(e.target);
	            target.addClass("selected").siblings().removeClass("selected");
	            var text = target.text();
	            var value = target.val();
	            category = value;
	            $(this).find(".btn-select-input").val(value);
	            $(this).find(".btn-select-value").html(text);
	            
	            console.log($("#bcategory").val());
	            console.log(value);
	            
	            if($("#bcategory").val() == "300000" || $("#bcategory").val() == "400000") {
	    			$(".comSet").attr("disabled", true);
	    			$("#os").val("");
	    		} else {
	    			$(".comSet").attr("disabled", false);
	    			if($("#company").val() != "5")
						$("#os").val("Windows 10");
					else
						$("#os").val("Mac OS");
	    		}// end of if~else
	    			
	    		if($("#bcategory").val() == "100000") {
	    			$("#case").attr("disabled", false);
	    		}
	    		else{
	    			$("#case").attr("disabled", true);
	    		}
	    			
	    		if($("#bcategory").val() == "100000" || $("#bcategory").val() == "400000") {
	    			$(".screenSet").attr("disabled", true);
	    		}
	    		else {
	    			$(".screenSet").attr("disabled", false);
	    		}
	    			
	        }
	        ul.hide();
	        $(this).removeClass("active");
	    }
	    else {
	        $('.btn-select').not(this).each(function () {
	            $(this).removeClass("active").find("ul").hide();
	        });
	        ul.slideDown(300);
	        $(this).addClass("active");
	    }
	    
	    
	});

	$(document).on('click', function (e) {
	    var target = $(e.target).closest(".btn-select");
	    if (!target.length) {
	        $(".btn-select").removeClass("active").find("ul").hide();
	    }
	});
	
	function goRegister() {
		
		console.log($("#pimages").val());
		
		if($("#colors").val().trim() == ""){
			alert("색상을 선택해주세요");
			return;
		}
		
		if($("#bcategory").val() == "100000" || $("#bcategory").val() == "200000"){
			
			if($("#storages").val().trim() == ""){
				alert("저장장치를 선택해주세요");
				return;
			}
			
			if($("#rams").val().trim() == ""){
				alert("램을 선택해주세요");
				return;
			}
			
			if($("#cpu").val().trim() == ""){
				alert("CUP를 입력해주세요");
				return;
			}
			
			if($("#mainboard").val().trim() == ""){
				alert("메인보드를 입력해주세요");
				return;
			}
			
			if($("#power").val().trim() == ""){
				alert("파워를 입력해주세요");
				return;
			}
			
			if($("#case").val().trim() == "" && $("#bcategory").val() == "100000"){
				alert("케이스를 입력해주세요");
				return;
			}
			
		}
		
		if($("#company").val().trim() == ""){
			alert("브랜드를 선택해주세요");
			return;
		}
		
		if($("#pname").val().trim() == ""){
			alert("제품명을 입력해주세요");
			return;
		}
		
		if($("#price").val().trim() == ""){
			alert("정가를 입력해주세요");
			return;
		}
		
		if($("#saleprice").val().trim() == ""){
			alert("판매가를 입력해주세요");
			return;
		}
		
		if($("#pimages").val().trim() == ""){
			alert("이미지를 선택해주세요");
			return;
		}
		
		if($("#pcontent").val().trim() == ""){
			alert("제품설명을 입력해주세요");
			return;
		}
		
		if($("#point").val().trim() == ""){
			alert("포인트를 입력해주세요");
			return;
		}
		
		if($("#pqty").val().trim() == ""){
			alert("재고량을 입력해주세요");
			return;
		}
		
		
		
		var frm = document.productRegiterFrm;
		frm.method = "POST";
		frm.enctype = "multipart/form-data";
		frm.action = "productRegisterEnd.do";
		frm.submit();
	}// end of goRegister
	 

</script>

	

	<div class="home">
		<div class="home_overlay"></div>
		<div class="home_content d-flex flex-column align-items-center justify-content-center">
			<h2 class="home_title">제품 등록</h2>
		</div>
	</div>

	<div class="container" style="width: 35%; margin-top: 30px; margin-bottom: 100px;">
		<div class="row clearfix">
			<div class="col-md-12" >
				<h4 style="font-weight: bold;">제품등록</h4>
				<form name="productRegiterFrm">

					<table class="table table-bordered table-hover" id="tab_logic">

						<tr>
							<td style="vertical-align: middle;">카테고리</td>
							<td>
							    <div class="row">
							        
							        <div class="col-xs-12 col-sm-12">
							            <a class="btn btn-primary btn-select btn-select-light" style="margin: 0px;">
							                <input type="hidden" class="btn-select-input" id="bcategory" name="bcategory" value="" />
							                <span class="btn-select-value">Select an Item</span>
							                <span class='btn-select-arrow glyphicon glyphicon-chevron-down'></span>
							                <ul>
							                    <li class="selected" value="100000">컴퓨터</li>
							                    <li value="200000">노트북</li>
							                    <li value="300000">모니터</li>
							                    <li value="400000">주변기기</li>
							                </ul>
							            </a>
							        </div>
							    </div>
							</td>
						</tr>

						
						<tr>
							<td style="vertical-align: middle;">색상</td>
							<td>
								<button type="button" class="form-control colors btn-dark btn-light"
									style="background-color: #000000; color: #ffffff;">색상등록</button>
								<input type="hidden" name="colors" id="colors" />
							</td>
						</tr>
						
						<tr>
							<td style="vertical-align: middle;">저장장치</td>
							<td>
								<button type="button" class="form-control comSet storages btn-dark btn-light"
									style="background-color: #000000; color: #ffffff;">장치등록</button>
								<input type="hidden" name="storages" id="storages"/>
							</td>
						</tr>
						
						<tr>
							<td style="vertical-align: middle;">RAM</td>
							<td>
								<button type="button" class="form-control rams comSet btn-dark btn-light"
									style="background-color: #000000; color: #ffffff;">램등록</button>
								<input type="hidden" name="rams" id="rams"/>
							</td>
						</tr>

						<tr>
							<td style="vertical-align: middle;">CPU</td>
							<td><input type="text" name="cpu" id="cpu" class="form-control comSet"
								placeholder="CPU"/></td>
						</tr>
						
						<tr>
							<td style="vertical-align: middle;">MAINBOARD</td>
							<td><input type="text" name="mainboard" id="mainboard" class="form-control comSet"
								placeholder="MAINBOARD"></td>
						</tr>
						
						<tr>
							<td style="vertical-align: middle;">POWER</td>
							<td><input type="text" name="power" id="power" class="form-control comSet"
								placeholder="POWER"></td>
						</tr>
						
						<tr>
							<td style="vertical-align: middle;">CASE</td>
							<td><input type="text" name="case" id="case" class="form-control comSet"
								placeholder="CASE"/></td>
						</tr>
						
						<tr>
							<td style="vertical-align: middle;">화면크기</td>
							<td><input type="text" name="screenSize" id="screenSize" class="form-control screenSet"
								placeholder="SCREENSIZE"/></td>
						</tr>

						<tr>
							<td style="vertical-align: middle;">브랜드</td>
							<td>
								
								<div class="row">
							        <div class="col-xs-12 col-sm-12">
							            <a class="btn btn-primary btn-select btn-select-light" style="margin: 0px;">
							                <input type="hidden" class="btn-select-input" id="company" name="company" value="" />
							                <span class="btn-select-value">Select an Item</span>
							                <span class='btn-select-arrow glyphicon glyphicon-chevron-down'></span>
							                <ul>
							                    <li class="selected" value="1">삼성</li>
							                    <li value="2">ASUS</li>
							                    <li value="3">MSI</li>
							                    <li value="4">HP</li>
							                    <li value="5">APPLE</li>
							                </ul>
							            </a>
							        </div>
							    </div>
							
							</td>
						</tr>

						<tr>
							<td style="vertical-align: middle;">OS</td>
							<td>
								<input type="text" id="os" name="os" class="form-control comSet" readonly value="Windows 10" />
							</td>
						</tr>
				
						<tr>
							<td style="vertical-align: middle;">제품명</td>
							<td><input type="text" id="pname" name="pname" class="form-control"
								placeholder="제품명" /></td>
						</tr>

						<tr>
							<td style="vertical-align: middle;">정가</td>
							<td><input type="number" id="price" name="price" class="form-control"
								placeholder="정가" /></td>
						</tr>

						<tr>
							<td style="vertical-align: middle;">판매가격</td>
							<td><input type="number" id="saleprice" name="saleprice"
								class="form-control" placeholder="판매가" /></td>
						</tr>

						<tr>
							<td style="vertical-align: middle;">이미지첨부</td>
							<td>
								<div>
									<button type="button" data-toggle="modal" data-target="#squarespaceModal" class="form-control thumb btn-dark btn-light" 
									style="background-color: #000000; color: #ffffff;">이미지 추가</button>
								</div>
								<input type="hidden" name="pimages" id="pimages"/>
							</td>
						</tr>

						<tr>
							<td style="vertical-align: middle;">제품설명</td>
							<td><input type="text" id="pcontent" name="pcontent" class="form-control"
								placeholder="제품설명" /></td>
						</tr>

						<tr>
							<td style="vertical-align: middle;">포인트</td>
							<td><input type="number" id="point" name="point" class="form-control"
								placeholder="포인트" /></td>
						</tr>

						<tr>
							<td style="vertical-align: middle;">재고량</td>
							<td><input type="number" id="pqty" name="pqty" class="form-control"
								placeholder="재고" /></td>
						</tr>


					</table>
					
					<button type="button" class="btn form-control btn-dark" style="background-color: #000000; color: #ffffff; font-weight: bold; cursor: pointer;"
						onClick="goRegister();">등록하기</button> 
					
						
					<!-- line modal -->
					<div class="modal fade" id="squarespaceModal" tabindex="-1" role="dialog" aria-labelledby="modalLabel" aria-hidden="true">
						<div class="modal-dialog">
							<div class="modal-content">
								<div class="modal-header">
									<button type="button" class="close" data-dismiss="modal">
										<span aria-hidden="true">×</span><span class="sr-only">Close</span>
									</button>
								</div>
								
								<div class="modal-body">
				
									<!-- content goes here -->
				
				
									<div class="form-group">
				
										<div class="row clearfix">
											<div class="col-md-12">
				
												<table class="table table-bordered table-hover" id="tab_logic">
				
													<thead>
														<tr>
															<th class="text-center">번호</th>
															<th class="text-center">이미지파일 경로</th>
															<th class="text-center">파일찾기</th>
														</tr>
													</thead>
				
													<tbody class="tbl-img" id="tbl-img">
														<tr id='addr0' class="imgRow">
															<td><span class="idx">1</span></td>
															<td><input type="text" name='pimage' placeholder='경로명' class="form-control pimages" value="" readonly/></td> 
															<td>
																<button type="button" class="btnFile form-control btn btn-dark" style="background-color: #000000;">
																	<span style="font-weight: bold; color: #ffffff;">첨부</span>
																</button>
																<input type="file" id="pimagesPath" name="pimagesPath" class="fileSearch"/>
															</td>
														</tr>
				
													</tbody>
												</table>
				
											</div>
										</div>
										<div class="row clearfix">
											<div class="col-md-12">
												<button type="button" id="add_row" class="btn btn-default pull-left">Add Row</button>
												<button type="button" id='delete_row' class="pull-right btn btn-default">Delete Row</button>
											</div>
										</div>
				
				
				
									</div>
				
				
								</div>
								
								<div class="modal-footer">
									<div class="btn-group btn-group-justified" role="group" aria-label="group button">
										<div class="btn-group" role="group">
											<button type="button" class="btn btn-default" data-dismiss="modal" role="button">닫기</button>
										</div>
										<div class="btn-group" role="group">
											<button type="button" id="applyImg" class="btn btn-default btn-hover-green" data-dismiss="modal" data-action="save" role="button">등록하기</button>
										</div>
									</div>
								</div>
								
							</div>
						</div>
					</div>
					<!-- end modal -->
						
				</form>
			</div>
			
			
		
		
			
			
		</div>

	</div>

<jsp:include page="../../adminFooter.jsp"/>