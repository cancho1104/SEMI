<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<script src="//code.jquery.com/jquery-1.11.1.min.js"></script>
<link href="//netdna.bootstrapcdn.com/bootstrap/3.0.0/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
<link href='https://fonts.googleapis.com/css?family=Passion+One' rel='stylesheet' type='text/css'>
<link href='https://fonts.googleapis.com/css?family=Oxygen' rel='stylesheet' type='text/css'>
<script src="//netdna.bootstrapcdn.com/bootstrap/3.0.0/js/bootstrap.min.js"></script>

<script type="text/javascript">
  
	$(document).ready(function() {

		$("#userid, #email").keydown(function(event) {
			if (event.keyCode == 13) { // 엔터를 했을 경우
				pwdSearch();
			}
		});// end of $("#loginPwd").keydown()-----------------------------------
		
		$(document).on("keydown", "#certificationCode", function(event){
			if (event.keyCode == 13) { // 엔터를 했을 경우
				$("#panel-body").find("#certificationCodebtn").trigger('click');
			}
		});
		
		$(document).on("keydown", "#pwd, #pwdCheck", function(event){
			if (event.keyCode == 13) { // 엔터를 했을 경우
				$("#panel-body").find("#pwdbtn").trigger('click');
			}
		});


	});

	function pwdSearch() {

		if ($("#userid").val().trim() == "") {
			alert("아이디를 입력하세요.");
			return;
		}

		if ($("#email").val().trim() == "") {
			alert("이메일을 입력하세요.");
			return;
		}
		<%-- 이메일 검사 --%>
		regExp = new RegExp(/^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/i);

		bool = regExp.test($("#email").val());

		if (!bool) {
			alert("이메일 형식에 맞게 입력해주세요");
			return;
		}
		
		var userid = $("#userid").val();
		var email =  $("#email").val();
		
		sendMeil(userid, email);

	}// end of pwdSearch()--------------------------
	
	function sendMeil(userid, email) {
		
		var form_data = {userid:userid, email:email};

		$.ajax({
			url : "pwdFindCheck.do",
			type : "POST",
			data : form_data,
			dataType : "JSON",
			success : function(json) {

				var html = "";

				if (json.certificationCode == "") {

					html = "일치하는 정보가 없습니다.";
					$("#notFound").html(html);
				} else {

					html = "<div class='form-group'>"
						+  "<input class='form-control' placeholder='인증코드' id='certificationCode' name='certificationCode' type='text' required>"
						+  "</div>"
						+  "<button type='button' class='btn btn-light btn-xs' style='margin-bottom: 10px' onclick='resendMeil(), sendMeil(\"" + json.userid + "\", \"" + json.email + "\")'>인증번호 재발송</button>"
						+  "<button class='btn btn-lg btn-info btn-block' id='certificationCodebtn' type='button' onClick='checkCertificationCode(\""
						+  json.certificationCode + "\", \"" +  json.userid + "\", \"" + json.email +  "\");'>인증하기</button>";

					$("#pwdSearchFrm").empty().html(html);
					$("#notFound").html("");

				}
				
			},
			error : function(request, status, error) {
				alert("code: " + request.status + "\n" + "message: "
						+ request.responseText + "\n" + "error: "
						+ error);
			}
		});
	}
	
	function resendMeil() {
		alert("메일을 재발송 했습니다.");
	}

	function checkCertificationCode(certificationCode, userid, email) {

		var userCertificationCode = $("#panel-body").find("#certificationCode").val();

		if (certificationCode == userCertificationCode) {
			
			var html = "<div class='form-group'>" +
					   "<input class='form-control' placeholder='비밀번호' id='pwd' name='pwd' type='password' required>" +
					   "</div>" +
					   "<div class='form-group'>" +
					   "<input class='form-control' placeholder='비밀번호 확인' id='pwdCheck' name='pwdCheck' type='password' required>" +
					   "</div>" +
					   "<button class='btn btn-lg btn-info btn-block' id='pwdbtn' type='button' onClick='pwdConfirm(\"" + userid + "\");''>변경</button>" +
					   "<input type='hidden' id='userid' name='userid' value=''/>";
					   
			$(".panel-title").html("비밀번호 변경");
			$("#pwdSearchFrm").empty().html(html);
			$("#notFound").html("");
		} else {
			$("#notFound").html("코드가 일치하지 않습니다.");
		}

	}// end of checkCertificationCode()-------------------------------
	
	function pwdConfirm(userid) {
		
		var pwd = $("#pwdSearchFrm").find("#pwd").val();
		
		var pwdCheck = $("#pwdSearchFrm").find("#pwdCheck").val();
		
		if(pwd.trim() == ""){
			alert("비밀번호를 입력하세요");
			return;
		}
		
		var regExp = new RegExp(/^.*(?=^.{8,15}$)(?=.*\d)(?=.*[a-zA-Z])(?=.*[^a-zA-Z0-9]).*$/g);
		
		var bool = regExp.test(pwd);
		
		if(!bool){
			alert("비밀번호는 영문자,숫자,특수기호가 혼합된 8~15 글자로만 입력가능합니다.");
			$("#pwdSearchFrm").find("pwd").val("");
			$("#pwdSearchFrm").find("pwd").focus();
			return;
		}
		
		if(pwd != pwdCheck) {
			alert("비밀번호가 일치하지 않습니다.");
			return;
		}
		
		
		var form_data = {userid:userid, pwd:pwd};
		
		$.ajax({
			url : "pwdDuplicate.do",
			type : "POST",
			data : form_data,
			dataType : "JSON",
			success : function(json) {

				var html = "";
				
				if(json.n > 0){
					html = "이미 사용하던 비밀번호입니다.";
					$("#notFound").html(html);
				}
				else{
					var frm = document.pwdSearchFrm;
					
					frm.userid.value = userid;
					frm.method = "POST";
					frm.action = "pwdConfirm.do";
					frm.submit();
				}
				
			},
			error : function(request, status, error) {
				alert("code: " + request.status + "\n" + "message: "
						+ request.responseText + "\n" + "error: "
						+ error);
			}
		});
		
	}// end of pwdConfirm()
	
</script>
<title>비밀번호 찾기</title>
</head>
<body>

	<div id="wrap">
		<!-- 스킵네비게이션 : 웹접근성대응-->

		<!-- //스킵네비게이션 -->
		
		<!-- header -->
		<div id="header" align="center">
			<h1>
				<a href="index.do" class="sp h_logo" style="align-content: center;"><img src="images/mainlogo.png" width="10%" height="10%"></a> 
			</h1>

		</div>
		<!-- //header -->
		
		<!-- container -->
		<div id="container">
			<!-- content -->
			<div id="content">
				<div class="title">
					<p></p>
				</div>
				<!------ Include the above in your HEAD tag ---------->
				<div class="container">
					<div class="row">
						<div class="col-md-4 col-md-offset-4">
							<div class="panel panel-default">
								<div class="panel-heading">
									<h3 class="panel-title">비밀번호 찾기</h3>
								</div>
								<div class="panel-body" id="panel-body">
									<div id="notFound" style="color: red; margin-bottom: 10px;"></div>
									
									<form id="pwdSearchFrm" name="pwdSearchFrm" accept-charset="UTF-8" role="form" onsubmit="return false">
										<fieldset>
											<div class="form-group">
												<input class="form-control" placeholder="ID" id="userid" name="userid" type="text" required>
											</div>
											<div class="form-group">
												<input class="form-control" placeholder="이메일" id="email" name="email" type="text" required>
											</div>
											<button class="btn btn-lg btn-info btn-block" type="button" style="" onClick="pwdSearch();">찾기</button>
										</fieldset>
										
									</form>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	
</body>
</html>