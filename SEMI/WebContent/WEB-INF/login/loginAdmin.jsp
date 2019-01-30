<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="//code.jquery.com/jquery-1.11.1.min.js"></script>
<link href="//netdna.bootstrapcdn.com/bootstrap/3.0.0/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
<script src="//netdna.bootstrapcdn.com/bootstrap/3.0.0/js/bootstrap.min.js"></script>

<title>관리자 Login</title>

<script type="text/javascript">

$(document).ready(function(){

	$("#adminid, #pwd").keydown(function(event) {
		if(event.keyCode == 13) {// 엔터를 했을 경우
			userLoginAction();			
		}
	});// end of $("#loginPwd").keydown()-----------------------------------
	
	if("${cookie.Aremember.value}" != ""){
		$("#adminid").val("${cookie.Aremember.value}");
		$("#remember").attr("checked", true);
	}
	  
  });// end of document ready
  
  function userLoginAction() {
		var adminid = $("#adminid").val().trim();
		var pwd = $("#pwd").val().trim();
		
		<%-- 아이디 검사 --%>
		if(adminid == "") {
			alert("아이디를 입력하세요!")
			$("#adminid").val("");
			$("#adminid").focus();
			return;
		} 
		
		<%-- 비밀번호 검사 --%>
		if(pwd == "") {
			alert("비밀번호를 입력하세요!")
			$("#pwd").val("");
			$("#pwd").focus();
			return ;
		}
		
		var frm = document.loginAdminFrm;
		frm.method="POST" 
		frm.action="loginAdminEnd.do" 
		frm.submit();
	}// end of function goLogin()

</script>
</head>
<body>

	<div id="wrap">
		<!-- 스킵네비게이션 : 웹접근성대응-->

		<!-- //스킵네비게이션 -->
		<!-- header -->
		<div id="header" style="text-align: center;"> 
			<h1> 
				<a href="http://localhost:9090/SEMI/index.do" class="sp h_logo"
					><img src="images/adminlogo.jpg" width="20%" height="20%"></a>
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
								<div class="panel-heading" align="center"><h3 class="panel-title">관리자 로그인</h3></div>
								<div class="panel-body">
									<form name="loginAdminFrm" accept-charset="UTF-8" role="form">
										<fieldset>
											<div class="form-group">
												<input class="form-control" id="adminid" placeholder="ID"
													name="adminid" type="text">
											</div>
											<div class="form-group">
												<input class="form-control" placeholder="PASSWORD"
													name="pwd" id="pwd" type="password" value=""> 
											</div>
											<div class="checkbox">
												<label> <input id="remember" name="remember" type="checkbox"
													value="Remember Me"> 아이디저장
												</label>
											</div>
											<button type="button" class="btn btn-lg btn-dark btn-block"
												style="background-color: #000000; color: #ffffff;" onclick="userLoginAction();">Login</button>
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