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
  
  $(document).ready(function(){

	$("#userid, #pwd").keydown(function(event) {
		if(event.keyCode == 13) {// 엔터를 했을 경우
			userLoginAction();			
		}
	});// end of $("#loginPwd").keydown()-----------------------------------
	
	if("${cookie.remember.value}" != ""){
		$("#userid").val("${cookie.remember.value}");
		$("#remember").attr("checked", true);
	}
	  
  });// end of document ready
  
  function userLoginAction() {
		var userid = $("#userid").val().trim();
		var pwd = $("#pwd").val().trim();
		
		<%-- 아이디 검사 --%>
		if(userid == "") {
			alert("아이디를 입력하세요!")
			$("#userid").val("");
			$("#userid").focus();
			return;
		} 
		
		<%-- 비밀번호 검사 --%>
		if(pwd == "") {
			alert("비밀번호를 입력하세요!")
			$("#pwd").val("");
			$("#pwd").focus();
			return ;
		}
		
		var frm = document.loginUserFrm;
		frm.method="POST" 
		frm.action="loginEnd.do" 
		frm.submit();
	}// end of function goLogin()
  

</script>
<title>Login</title>
</head>
<body>

	<div id="wrap">
		<!-- 스킵네비게이션 : 웹접근성대응-->

		<!-- //스킵네비게이션 -->
		<!-- header -->
		<div id="header col-12" style="margin: auto; text-align: center;">
			<a href="http://localhost:9090/SEMI/index.do" class="sp h_logo" style="align-content: center;"><img src="images/mainlogo.png" width="10%" height="10%"></a> 
			
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
									<h3 class="panel-title">로그인</h3>
								</div>
								<div class="panel-body">
									<form name="loginUserFrm" accept-charset="UTF-8" role="form">
										<fieldset>
											<div class="form-group">
												<input class="form-control" id="userid"
													placeholder="ID" name="userid" type="text" required />
											</div>
											<div class="form-group">
												<input class="form-control" id="pwd" placeholder="Password"
													name="pwd" type="password" value="" required />
											</div>
											<div class="checkbox">
												<label> <input name="remember" id="remember" type="checkbox"
													value="Remember Me"> 아이디 저장
												</label>
											</div>
											<button class="btn btn-lg btn-info btn-block" type="button" onClick="userLoginAction();">Login</button>
										</fieldset>
										<span style=""></span>
										<fieldset style="padding-top : 10px;">
											<div align="center">
												<a href="idFind.do">아이디 찾기</a>
												<span>|</span>
												<a href="pwdFind.do">비밀번호 찾기</a>
											</div>
										</fieldset>
									</form>
								</div>
							</div>
						</div>
					</div>
				</div>
				
				
				<div align="center">
					<a href="loginAdmin.do">
						<button type="button" class="btn btn-outline-dark btn-light" style="background-color: #ffffff;"></button>
					</a>
				</div>
				
			</div>
				
		</div>	
	</div>		
</body>
</html>