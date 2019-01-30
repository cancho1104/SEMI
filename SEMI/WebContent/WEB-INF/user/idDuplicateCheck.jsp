<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
    <head> 
		<meta charset="UTF-8">
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<script src="js/jquery-3.3.1.min.js"></script>
		<link href="//maxcdn.bootstrapcdn.com/bootstrap/3.3.0/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
		<script src="//maxcdn.bootstrapcdn.com/bootstrap/3.3.0/js/bootstrap.min.js"></script>
		

		<!-- Website Font style -->
	    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.6.1/css/font-awesome.min.css">
		<link rel="stylesheet" href="styles/registerstyle.css">
		<!-- Google Fonts -->
		<link href='https://fonts.googleapis.com/css?family=Passion+One' rel='stylesheet' type='text/css'>
		<link href='https://fonts.googleapis.com/css?family=Oxygen' rel='stylesheet' type='text/css'>
		
		<script type="text/javascript">
			
			$(document).ready(function () {
				$("#userid").keydown(function(event) {
					if(event.keyCode == 13) {// 엔터를 했을 경우
						idCheck();			
					}
				});// end of $("#loginPwd").keydown()-----------------------------------
			});
			
			
			
			function idCheck() {
				
				var userid = $("#userid").val().trim();
				
				if(userid == ""){
					alert("아이디를 입력해주세요");
					return;
				}
				
				if( userid.length > 20 || userid.length < 5){
					alert("아이디는 5글자 이상 20 이하로만 가능합니다.");
					return;
				}
				
					
				var form_data = {userid:$("#userid").val()};
				$.ajax({
					url:"idDuplicateCheckEnd.do",
					type:"POST",
					data:form_data,
				    dataType:"JSON",
				    success:function(json){
				    	
				    	var idhtml = "";
				    	var btnhtml = "";
				    	var userid = json.userid;
				    	
				    	if(json.idBool == true) {
				    		idhtml = "<label for='userid' class='cols-sm-12 control-label'>" + userid + " 는 사용 가능한 아이디입니다.</label>";
				    		btnhtml = "<button type='button' name='button2id' class='btn btn-primary btn-lg btn-block login-button' onclick='setUserID();''>사용</button>";
				    		$("#saveid").val(userid);
				    		self.resizeTo(500,300);
				    	}
				    	else if(json.idBool == false) {
				    		self.resizeTo(500,360);
				    		idhtml = "<div class='form-group'>" + 
							"<label for='userid' class='cols-sm-12 control-label'>" + userid + " 는 이미 사용중인 아이디입니다.</label>" +
							"</div>" +
							"<label for='userid' class='cols-sm-2 control-label'>아이디</label>" +
							"<div class='cols-sm-10'>" +
								"<div class='input-group'>" +
									"<span class='input-group-addon'><i class='fa fa-user fa' aria-hidden='true'></i></span>" +
									"<input type='text' class='form-control' name='userid' id='userid'  placeholder='아이디를 입력해주세요'/>" +
								"</div>" +
							"</div>";
				    		btnhtml = "<button type='button' id='button1id' name='button1id' class='btn btn-primary btn-lg btn-block login-button' onclick='idCheck()'>검사</button>";
				    	}
				    	
				    	$("#idcheck").empty().append(idhtml);
				    	$("#checkbtn").empty().append(btnhtml);
				    	
				    },
				    error: function(request, status, error){
						alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
					}
				});
				
			}// end of idCheck()-----------------
			
			function setUserID() {
				
				var userid = $("#saveid").val();
				console.log(userid);
				$(opener.document).find("#userid").val(userid);
				$(opener.document).find("#idDuplicateCheck").val("1");
				
				$(opener.document).find("#pwd").focus();
			
				self.close();
			}// end of setUserID()----------------------------
			
		</script>

		<title>아이디 중복 확인</title>
	</head>
	<body>
		<div class="container" >
			<div class="row main" style="margin: 10px;">
				<div class="main-login main-center">
				<h3>아이디 중복 확인</h3>
					<form class="" name="idCechkFrm" onsubmit="return false">
						
						<div class="form-group"  id="idcheck">
							<label for="userid" class="cols-sm-2 control-label">아이디</label>
							<div class="cols-sm-10">
								<div class="input-group">
									<span class="input-group-addon"><i class="fa fa-user fa" aria-hidden="true"></i></span>
									<input type="text" class="form-control" name="userid" id="userid"  placeholder="아이디를 입력해주세요"/>
								</div>
							</div>
						</div>
						
						<div class="form-group" id="checkbtn">
							<button type="button" id="button1id" name="button1id" class="btn btn-primary btn-lg btn-block login-button" onclick="idCheck()">검사</button>
						</div>
						
					</form>
				</div>
			</div>
		</div>
		<input id="saveid" type="hidden" value=""/>
	</body>
</html>