<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<jsp:include page="../adminHeader.jsp"/>

<script src="//code.jquery.com/jquery-1.11.1.min.js"></script>
<link href="//netdna.bootstrapcdn.com/bootstrap/3.0.0/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
<script src="//netdna.bootstrapcdn.com/bootstrap/3.0.0/js/bootstrap.min.js"></script>
<script src="//netdna.bootstrapcdn.com/twitter-bootstrap/2.3.2/js/bootstrap.min.js"></script>
<link rel="stylesheet" type="text/css" href="styles/userList.css">
<link rel="stylesheet" type="text/css" href="styles/shop_styles.css">
<link rel="stylesheet" type="text/css" href="styles/shop_responsive.css">

<script type="text/javascript">

	var panels = $('.user-infos');
	
	$(document).ready(function() {
	
	    //Click dropdown
	    $(document).on("click", ".dropdown-user", function(){
	        //get data-for attribute
	        var dataFor = $(this).attr('data-for');
	        var idFor = $(dataFor);
	
	        //current button
	        var currentButton = $(this);
	        idFor.slideToggle(400, function() {
	            //Completed slidetoggle
	            if(idFor.is(':visible'))
	            {
	                currentButton.html('<i class="glyphicon glyphicon-chevron-up text-muted"></i>');
	            }
	            else
	            {
	                currentButton.html('<i class="glyphicon glyphicon-chevron-down text-muted"></i>');
	            }
	        })
	    });
	
	
	    
	
	    userList($("#sort").text(), "1");
		
	
	});// $(document).ready()-----------------------------
	
	var sizePerPage = 5;
	
	function userList(sort, pageNo) {
		
		if(sort == null || sort == ""){
			sort = $("#sort").text();
		}
		
		var form_data = {sort:sort, pageNo:pageNo, sizePerPage:sizePerPage};
		
		$.ajax({
			url: "getUserList.do",
			type: "GET",
			data: form_data,  // 위의 URL 페이지로 사용자가 보내는 ajax 요청 데이터.
			dataType: "JSON", // ajax 요청에 의해 URL 페이지 서버로 부터 리턴받는 데이터 타입. xml, json, html, script, text 이 있음.
			success: function(json){
				var html = "";
				if(json.length > 0){
					
					$.each(json, function(entryIndex, entry){
						
						var status = "";
						
						if(entry.status == 0){
							status = "활동중";
						}
						else if(entry.status == 1){
							status = "휴면";
						}
						else {
							status = "탈퇴";
						}
						
						html += "<div class=\"row user-row\" style='margin-top: 30px; margin-bottom: 30px;'>\n" + 
								"           <div class=\"col-xs-3 col-sm-2 col-md-2 col-lg-1\">\n" + 
								"               <img class=\"img-circle\"\n" + 
								"                    src=\"images/" + ((entry.status == 2)?"unable.jpg":"able.jpg") + "\" width=\"50px\" height=\"50px\"\n" + 
								"                    alt=\"User Pic\">\n" + 
								"           </div>\n" + 
								"           <div class=\"col-xs-8 col-sm-9 col-md-9 col-lg-10\">\n" + 
								"               <strong>아이디 : " + entry.userid + "</strong><br>\n" + 
								"               <span class=\"text-muted\">회원 등급: <span class='" + 
												((entry.grade_name == "브론즈")?"grade-bronze":"") +
												((entry.grade_name == "실버")?"grade-silver":"") +
												((entry.grade_name == "골드")?"grade-gold":"") +
												((entry.grade_name == "플래티넘")?"grade-platinum":"") +
												((entry.grade_name == "다이아")?"grade-diamond":"") +
												"'>" + entry.grade_name + "</span></span>\n" + 
								"           </div>\n" + 
								"           <div class=\"col-xs-1 col-sm-1 col-md-1 col-lg-1 dropdown-user\" data-for=\"." + entry.userid + "\">\n" + 
								"               <i class=\"glyphicon glyphicon-chevron-down text-muted\"></i>\n" + 
								"           </div>\n" + 
								"       </div>\n" + 
								"       <div class=\"row user-infos " + entry.userid + "\">\n" + 
								"           <div class=\"col-xs-12 col-sm-12 col-md-10 col-lg-10 col-xs-offset-0 col-sm-offset-0 col-md-offset-1 col-lg-offset-1\">\n" + 
								"               <div class=\"panel panel-primary\">\n" + 
								"                   <div class=\"panel-heading\">\n" + 
								"                       <h3 class=\"panel-title\">회원 정보</h3> \n" + 
								"                   </div>\n" + 
								"                   <div class=\"panel-body\">\n" + 
								"                       <div class=\"row\">\n" + 
								"                           <div class=\"col-md-2 col-lg-2 hidden-xs hidden-sm\">\n" + 
								"                               <img class=\"img-circle\"\n" + 
								"				                    src=\"images/" + ((entry.status == 2)?"unable.jpg":"able.jpg") + "\" width=\"50px\" height=\"50px\"\n" + 
								"				                    alt=\"User Pic\">\n" + 
								"                           </div>\n" + 
								"                           <div class=\"col-xs-2 col-sm-2 hidden-md hidden-lg\">\n" + 
								"                               <img class=\"img-circle\"\n" + 
								"				                    src=\"images/" + ((entry.status == 2)?"unable.jpg":"able.jpg") + "\" width=\"50px\" height=\"50px\"\n" + 
								"				                    alt=\"User Pic\">\n" + 
								"                           </div>\n" + 
								"                           <div class=\"col-xs-10 col-sm-10 hidden-md hidden-lg\" style=\"padding-left: 10%;\">\n" + 
								"                               <strong>" + entry.userid + "</strong><br>\n" + 
								"                               <dl>\n" + 
								"                                   <dt style='color:red;'>회원번호:</dt>\n" + 
								"                                   <dd>" + entry.idx + "</dd>\n" + 
								"                                   <dt style='color:red;'>이름:</dt>\n" + 
								"                                   <dd>" + entry.name + "</dd>\n" + 
								"                                   <dt style='color:red;'>가입 일자:</dt>\n" + 
								"                                   <dd>" + entry.registDate + "</dd>\n" + 
								"                                   <dt style='color:red;'>생년월일:</dt>\n" + 
								"                                   <dd>" + entry.birth + "</dd>\n" + 
								"                                   <dt style='color:red;'>성별:</dt>\n" + 
								"                                   <dd>" + entry.gender + "</dd>\n" + 
								"                                   <dt style='color:red;'>주소:</dt>\n" + 
								"                                   <dd>" + entry.addr + "</dd>\n" + 
								"                                   <dt style='color:red;'>상세주소:</dt>\n" + 
								"                                   <dd>" + entry.addrDetail + "</dd>\n" + 
								"                                   <dt style='color:red;'>회원상태:</dt>\n" + 
								"                                   <dd>" + status + "</dd>\n" + 
								"                               </dl>\n" + 
								"                           </div>\n" + 
								"                           <div class=\" col-md-10 col-lg-10 hidden-xs hidden-sm\">\n" + 
								"                               <strong>" + entry.userid + "</strong><br>\n" + 
								"                               <table class=\"table table-user-information\">\n" + 
								"                                   <tbody>\n" + 
								"                                   <tr>\n" + 
								"                                       <td style='color:red;'>회원번호:</td>\n" + 
								"                                   	   <td>" + entry.idx + "</td>\n" + 
								"                                   </tr>\n" + 
								"                                   <tr>\n" + 
								"                                       <td style='color:red;'>이름:</td>\n" + 
								"                                       <td>" + entry.name + "</td>\n" + 
								"                                   </tr>\n" + 
								"                                   <tr>\n" + 
								"                                       <td style='color:red;'>가입일자:</td>\n" + 
								"                                       <td>" + entry.registDate + "</td>\n" + 
								"                                   </tr>\n" + 
								"                                   <tr>\n" + 
								"                                       <td style='color:red;'>생년월일:</td>\n" + 
								"                                       <td>" + entry.birth + "</td>\n" + 
								"                                   </tr>\n" + 
								"                                   <tr>\n" + 
								"                                       <td style='color:red;'>성별:</td>\n" + 
								"                                       <td>" + (entry.gender == "0" ?"남자":"여자") + "</td>\n" + 
								"                                   </tr>\n" + 
								"                                   <tr>\n" + 
								"                                       <td style='color:red;'>주소:</td>\n" + 
								"                                       <td>" + entry.addr + "</td>\n" + 
								"                                   </tr>\n" + 
								"                                   <tr>\n" + 
								"                                       <td style='color:red;'>상세주소:</td>\n" + 
								"                                       <td>" + entry.addrDetail + "</td>\n" + 
								"                                   </tr>\n" + 
								"                                   <tr>\n" + 
								"                                       <td style='color:red;'>회원상태:</td>\n" + 
								"                                       <td>" + status + "</td>\n" + 
								"                                   </tr>\n" + 
								"                                   </tbody>\n" + 
								"                               </table>\n" + 
								"                           </div>\n" + 
								"                       </div>\n" + 
								"                   </div>\n" + 
								"                   <div class=\"panel-footer\">\n" + 
								((entry.status < 2)?"                       <button class=\"btn btn-sm btn-danger\" type=\"button\"\n" + 
								"                               data-toggle=\"tooltip\"\n" + 
								"                               data-original-title=\"회원탈퇴\" onclick='deleteUser(\""+ entry.idx +"\")'><i class=\"glyphicon glyphicon-remove\"></i></button>\n"
								:"                       <button class=\"btn btn-sm btn-success\" type=\"button\"\n" +
								"                               data-toggle=\"tooltip\"\n" +
								"                               data-original-title=\"회원복원\" onclick='recoveryUser(\""+ entry.idx +"\")'><i class=\"glyphicon glyphicon-repeat\"></i></button>\n") + 
								((entry.status == 1)?"                       <button class=\"btn btn-sm btn-warning\" type=\"button\"\n" + 
								"                               data-toggle=\"tooltip\"\n" + 
								"                               data-original-title=\"휴면계정 활성화\" onclick='ableUser(\""+ entry.idx +"\")'><i class=\"glyphicon glyphicon-edit\"></i></button>\n":"") + 
								"                   </div>\n" + 
								"               </div>\n" + 
								"           </div>\n" + 
								"       </div>\n";
						
					});
					
					
					
					
				}
				else {
					html += "<div align='center'>회원이 존재하지 않습니다.<div>"; 
				}
				
				$("#allUserList").html(html);
				panels = $(".user-infos");
				panels.hide();
				
				$('[data-toggle="tooltip"]').tooltip();
				
				makePagebar(sort, pageNo)
				
			},// end of success: function()------
			error: function(request, status, error){
				alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
			}
		});// end of $.ajax()-------------------------------- 
		
		
		
	}// end of userList()----------------------------
	
	
	function makePagebar(sort, currentPageNo) {
		
		var form_data = {sizePerPage:sizePerPage};
		
		
		$.ajax({
			url: "userListPageBarJSON.do",
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
				    	 pageBarHTML += "<div class='page_prev d-flex flex-column align-items-center justify-content-center' onclick='javascript:userList(\"" + sort + "\", \"" + (pageNo-1) + "\")'>" +
										"<i class='fas fa-chevron-left'></i>" +
										"</div>";
				     }
				     pageBarHTML += "<ul class='page_nav d-flex flex-row'>"
				     while( !(loop > blockSize || pageNo > totalPage) ) {
				       	 
				    	  if(pageNo == currentPageNo) {
				    		  pageBarHTML += "<li style='cursor: default; color:red;'>" + pageNo + "</li>"; 
				    	  }
				    	  else {
				    	  	  pageBarHTML += "<li onclick='javascript:userList(\"" + sort + "\", \"" + pageNo + "\")'><a href='javascript:userList(\"" + sort + "\", \"" + pageNo + "\")'>" + pageNo + "</a></li>";
				     	  }
                     
				       	 loop++;
				    	 pageNo++;
				     } // end of while-----------------------------------

				     pageBarHTML += "</ul>";
				     
				  	  // *** [다음] 만들기 *** //
				     if( !(pageNo > totalPage) ) {
				    	 pageBarHTML +=  "<div class='page_next d-flex flex-column align-items-center justify-content-center' onclick='javascript:userList(\"" + sort + "\", \"" + pageNo + "\")'>" +
										 "<i class='fas fa-chevron-right'></i>" +
										 "</div>";
				     }
					 	
				  	 console.log(pageBarHTML); 
				     $("#pageBar").empty().html(pageBarHTML);
				     
				}
				
				else { // 검색된 데이터가 없는 경우
					 $("#pageBar").empty();
				}
				
				$("#findUser").text(json.totalCount);

			},// end of success: function()------
			error: function(request, status, error){
				alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
			}
		});// end of $.ajax()-------------------
		
	}// end of makePagebar()---------------------
	
	
	// 회원 휴면해제 // 
	function ableUser(idx) {
		
		var bool = confirm("휴면을 해제하시겠습니까?");
		
		console.log(bool);
		
		if(bool){
			
			var form_data = {idx:idx};
			
			$.ajax({
				url: "userAbleJSON.do",
				type: "POST",
				data: form_data,  // 위의 URL 페이지로 사용자가 보내는 ajax 요청 데이터.
				dataType: "JSON", // ajax 요청에 의해 URL 페이지 서버로 부터 리턴받는 데이터 타입. xml, json, html, script, text 이 있음.
				success: function(json){
					
					if(json.result == 1)
						alert("휴면계정이 활성화 되었습니다.");
					else {
						alert("휴면계정이 활성화가 실패했습니다.");
					}
					
					location.reload();
					
				},error: function(request, status, error){
					alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
				}
			});// end of $.ajax()-------------------
				
		}
		
	}// end of ableUser()---------------------------------
	
	
	// 회원 삭제 //
	function deleteUser(idx) {
		
		var bool = confirm("회원을 탈퇴시키시겠습니까?");
		
		console.log(bool);
		
		if(bool){
			
			var form_data = {idx:idx};
			
			$.ajax({
				url: "userDeleteJSON.do",
				type: "POST",
				data: form_data,  // 위의 URL 페이지로 사용자가 보내는 ajax 요청 데이터.
				dataType: "JSON", // ajax 요청에 의해 URL 페이지 서버로 부터 리턴받는 데이터 타입. xml, json, html, script, text 이 있음.
				success: function(json){
					
					if(json.result == 1)
						alert("회원이 탈퇴 되었습니다.");
					else {
						alert("회원 탈퇴가 실패했습니다.");
					}
					
					location.reload();
					
				},error: function(request, status, error){
					alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
				}
			});// end of $.ajax()-------------------
				
		}
		
	}// end of deleteUser()---------------------------------
	
	
	// 회원 복원 //
	function recoveryUser(idx) {
		
		var bool = confirm("회원을 복원시키시겠습니까?");
		
		console.log(bool);
		
		if(bool){
			
			var form_data = {idx:idx};
			
			$.ajax({
				url: "userRecoveryJSON.do",
				type: "POST",
				data: form_data,  // 위의 URL 페이지로 사용자가 보내는 ajax 요청 데이터.
				dataType: "JSON", // ajax 요청에 의해 URL 페이지 서버로 부터 리턴받는 데이터 타입. xml, json, html, script, text 이 있음.
				success: function(json){
					
					if(json.result == 1)
						alert("회원이 복원이 되었습니다.");
					else {
						alert("회원 복원이 실패했습니다.");
					}
					
					location.reload();
					
				},error: function(request, status, error){
					alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
				}
			});// end of $.ajax()-------------------
				
		}
		
	}// end of deleteUser()---------------------------------
	
</script> 


<div class="home">
	<div class="home_overlay"></div>
	<div class="home_content d-flex flex-column align-items-center justify-content-center">
		<h2 class="home_title">회원관리</h2>
	</div>
</div>

<!------ Include the above in your HEAD tag ----------> 

<div class="shop_bar clearfix col-xs-10 col-sm-10 col-md-10 col-lg-10 col-xs-offset-1 col-sm-offset-1 col-md-offset-1 col-lg-offset-1" style="margin-top: 30px;margin-bottom: 30px;">
	<div class="shop_product_count">
		<span id="findUser">1</span>명의 회원을 찾았습니다.
	</div>
	<div class="shop_sorting">
		<span>정렬:</span>
		<ul>
			<li><span class="sorting_text" id="sort">이름순</span>
				<ul>
					<li class="shop_sorting_button" onclick="userList('이름순', '1');">이름순</li>
					<li class="shop_sorting_button" onclick="userList('가입순', '1');">가입순</li>
					<li class="shop_sorting_button" onclick="userList('등급순', '1');">등급순</li>
				</ul>
			</li>
		</ul>
	</div>
</div>


<br><br>
<div class="container" style="margin-bottom: 50px;">
	<div class="well col-xs-10 col-sm-10 col-md-10 col-lg-10 col-xs-offset-1 col-sm-offset-1 col-md-offset-1 col-lg-offset-1" id="allUserList">
        
       
   </div>
   
	<!-- Shop Page Navigation -->
	<div class="shop_page_nav d-flex flex-row  col-xs-10 col-sm-10 col-md-10 col-lg-10 col-xs-offset-1 col-sm-offset-1 col-md-offset-1 col-lg-offset-1" id="pageBar">
		
	</div>
		
</div>

<jsp:include page="../adminFooter.jsp"/>
