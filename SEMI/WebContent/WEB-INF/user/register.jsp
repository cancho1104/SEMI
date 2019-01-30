<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!------ Include the above in your HEAD tag ---------->

<!DOCTYPE html>
<html lang="en">
    <head> 
    	<meta charset="UTF-8">
		<meta name="viewport" content="width=device-width, initial-scale=1">
		
		<script src="js/jquery-3.3.1.min.js"></script>
		<link href="//maxcdn.bootstrapcdn.com/bootstrap/3.3.0/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
		<link rel="stylesheet" type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/1.1.3/sweetalert.min.css" /> 
		<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/1.1.3/sweetalert.min.js"></script>

		<!-- Website Font style -->
	    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.6.1/css/font-awesome.min.css">
		<link rel="stylesheet" href="styles/registerstyle.css">
		<!-- Google Fonts -->
		<link href='https://fonts.googleapis.com/css?family=Passion+One' rel='stylesheet' type='text/css'>
		<link href='https://fonts.googleapis.com/css?family=Oxygen' rel='stylesheet' type='text/css'>
		<script src="https://ssl.daumcdn.net/dmaps/map_js_init/postcode.v2.js"></script>
		
		

		<title>회원가입</title>
		
		
		<script type="text/javascript">
		
			$(document).ready(function() {
				
				var today = new Date();
				var dd = today.getDate();
				var mm = today.getMonth()+1; //January is 0!
				var yyyy = today.getFullYear();
				
				$("#zipcodeSearch").click(function () {
					
					new daum.Postcode({
						oncomplete: function(data) {
							$("#post").val(data.zonecode); // 우편번호 (5자리)
							$("#addr").val(data.address + " " + data.buildingName);
						}
					}).open();
					
				});
				
				$("#birthyyyy, #birthmm, #birthdd").change(function () {
					
					var regExp = /^[0-9]+$/;
					
					var bool = regExp.test($("#birthyyyy").val());
					
					if(!bool){
						swal("년도를 정상적으로 입력해주세요");
						$("#birthyyyy").val(yyyy);
						return;
					}
					
					mm = "" + mm;
					dd = "" + dd;
					
					if(Number(mm) < 10){
						mm = "0" + mm;
					}
					
					if(Number(dd) < 10){
						dd = "0" + dd;
					}
					
					
					var nowdate = yyyy + mm + dd;
					
					var birthdate = $("#birthyyyy").val() + $("#birthmm").val() + $("#birthdd").val(); 
					
					console.log(nowdate);
					
					if(Number(birthdate) > Number(nowdate)){
						swal("생년월일은 현재 날짜보다 넘어갈 수 없습니다.");
						$("#birthyyyy").val(yyyy);
						$("#birthmm").val(mm);
						$("#birthdd").val(dd);
						dd = today.getDate();
						mm = today.getMonth()+1;
						return;
					}
					
					dd = today.getDate();
					mm = today.getMonth()+1;
					
				});
				
			});// $(document).ready()------------------------------------
		
			function goRegister() {
				
				if($("#idDuplicateCheck").val().trim() == ""){
					swal("id중복검사를 해주세요");
					return;
				}
				
				var regExp = new RegExp(/^.*(?=^.{8,15}$)(?=.*\d)(?=.*[a-zA-Z])(?=.*[^a-zA-Z0-9]).*$/g);
				
				var bool = regExp.test($("#pwd").val());
				
				<%-- 비밀번호검사 --%>
				if(!bool){
					swal("비밀번호는 영문자,숫자,특수기호가 혼합된 8~15 글자로만 입력가능합니다.");
					$("#pwd").val("");
					$("#pwd").focus();
					return;
				}
				
				<%-- 비밀번호 확인 검사 --%>
				if($("#pwd").val() != $("#pwdCheck").val()){
					swal("비밀번호가 일치하지 않습니다.");
					$("#pwdCheck").focus();
					return;
				}
				
				<%-- 성명 검사 --%>
				if($("#name").val().trim() == ""){
					swal("이름을 입력해주세요");
					return;
				}
				
				<%-- 이메일 검사 --%>
				regExp = new RegExp(/^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/i);
				
				bool = regExp.test($("#email").val());
				
				
				if(!bool){
					swal("이메일 형식에 맞게 입력해주세요");
					return;
				}
				
				<%-- 연락처 검사 --%>
				regExp = /^\d{3}\d{3,4}\d{4}$/;
				
				bool = regExp.test($("#hp").val());
				
				if(!bool){
					swal("연락처를 올바르게 입력해주세요.");
					return;
				}
				
				if($("#addr").val().trim() == "" || $("#addrDetail").val().trim() == ""){
					swal("주소를 입력해주세요");
					return;
				}
				
				var frm = document.registerFrm;
				frm.method="POST" 
				frm.action="userRegisterEnd.do"
				frm.submit();
				
				
			}// end of goRegister()----------------
			
			function goIdDuplicateCheck() {
				
				var frm = document.registerFrm;
				
				
				var url="idDuplicateCheck.do";
				window.open("", "idcheck", "left=500px, top=100px, width=500px, height=250px");
				
				frm.target = "idcheck";
				frm.action = url;
				frm.method = "POST";
				frm.submit();
			
			}// end of goIdDuplicateCheck()----------------
		
		</script>
		
	</head>
	<body>
	
		<div class="header_main">
			<div class="container">
				<div class="row">
	
					<!-- Logo -->
					<div class="col-lg-12 col-sm-12 col-12 order-12" align="center">
						<div class="logo_container">
							<div class="logo" style="margin-top: 30px;"><a href="index.do"><img src="images/mainlogo.png" width="10%" height="10%"></a></div>
						</div>
					</div>
				</div>
			</div>
		</div>
		
		<div class="container">
			<div class="row main">
				<div class="main-login main-center">
				<h3>회원가입</h3>
					<form class="" name="registerFrm" accept-charset="UTF-8">
						
						<div class="form-group">
							<label for="userid" class="cols-sm-2 control-label">아이디&nbsp;&nbsp;
							<img id="idcheck" src="images/b_id_check.gif" style="vertical-align: middle;" onclick="goIdDuplicateCheck();"/></label>
							<div class="cols-sm-10">
								<div class="input-group">
									<span class="input-group-addon"><i class="fa fa-user fa" aria-hidden="true"></i></span>
									<input type="text" class="form-control" name="userid" id="userid"  placeholder="아이디" required/>
									<input type="hidden" id="idDuplicateCheck" value="">
								</div>
							</div>
						</div>
						
						<div class="form-group">
							<label for="pwd" class="cols-sm-2 control-label">비밀번호</label>
							<div class="cols-sm-10">
								<div class="input-group">
									<span class="input-group-addon"><i class="fa fa-lock fa-lg" aria-hidden="true"></i></span>
									<input type="password" class="form-control" name="pwd" id="pwd"  placeholder="비밀번호" required/>
								</div>
							</div>
						</div>

						<div class="form-group">
							<label for="pwdCheck" class="cols-sm-2 control-label">비밀번호 확인</label>
							<div class="cols-sm-10">
								<div class="input-group">
									<span class="input-group-addon"><i class="fa fa-lock fa-lg" aria-hidden="true"></i></span>
									<input type="password" class="form-control" id="pwdCheck"  placeholder="비밀번호 확인" required/>
								</div>
							</div>
						</div>
						
						<div class="form-group">
							<label for="name" class="cols-sm-2 control-label">성명</label>
							<div class="cols-sm-10">
								<div class="input-group">
									<span class="input-group-addon"><i class="fa fa-users fa" aria-hidden="true"></i></span>
									<input type="text" class="form-control" name="name" id="name"  placeholder="성명" required/>
								</div>
							</div>
						</div>

						<div class="form-group">
							<label for="email" class="cols-sm-2 control-label">이메일</label>
							<div class="cols-sm-10">
								<div class="input-group">
									<span class="input-group-addon"><i class="fa fa-envelope fa" aria-hidden="true"></i></span>
									<input type="text" class="form-control" name="email" id="email"  placeholder="example@google.com" required/>
								</div>
							</div>
						</div>
						
						<div class="form-group">
							<label for="hp" class="cols-sm-2 control-label">연락처</label>
							<div class="cols-sm-10">
								<div class="input-group">
									<span class="input-group-addon"><i class="fa fa-phone fa" aria-hidden="true"></i></span>
									<input type="text" class="form-control" name="hp" id="hp"  placeholder="- 없이 입력해주세요" required/>
								</div>
							</div>
						</div>
						
						<div class="form-group">
							<label for="post" class="cols-sm-2 control-label">우편번호 &nbsp;&nbsp;<img id="zipcodeSearch" src="images/b_zipcode.gif"></label>
							<div class="cols-sm-10">
								<div class="input-group">
									<span class="input-group-addon"><i class="fa fa-home fa" aria-hidden="true"></i></span>
									<input type="text" class="form-control" name="post" id="post"  placeholder="" required/>
								</div>
							</div>
						</div>
						
						<div class="form-group">
							<label for="addr" class="cols-sm-2 control-label">주소</label>
							<div class="cols-sm-10" style="margin-bottom: 10px;">
								<div class="input-group">
									<span class="input-group-addon"><i class="fa fa-home fa" aria-hidden="true"></i></span>
									<input type="text" class="form-control" name="addr" id="addr"  placeholder="주소" required/>
								</div>
							</div>
							<div class="cols-sm-10">
								<div class="input-group">
									<span class="input-group-addon"><i class="fa fa-home fa" aria-hidden="true"></i></span>
									<input type="text" class="form-control" name="addrDetail" id="addrDetail"  placeholder="상세주소" required/>
								</div>
							</div>
						</div>
						
						<div class="form-group">
							<label for="birthyyyy" class="cols-sm-2 control-label">생년월일</label>
							<div class="cols-sm-10">
								<div class="col-sm-12" style="padding-left: 0px; padding-right: 0px; padding-bottom: 10px;">
									<div class="col-sm-4">
										<input type="number" id="birthyyyy" name="birthyyyy" min="1950" max="2050" step="1" value="1995" class="form-control"/>
									</div>
									<div class="col-sm-4">
										<select id="birthmm" name="birthmm" class="form-control">
											<option value="01">01</option>
											<option value="02">02</option>
											<option value="03">03</option>
											<option value="04">04</option>
											<option value="05">05</option>
											<option value="06">06</option>
											<option value="07">07</option>
											<option value="08">08</option>
											<option value="09">09</option>
											<option value="10">10</option>
											<option value="11">11</option>
											<option value="12">12</option>
										</select>
									</div>
									<div class="col-sm-4">
										<select id="birthdd" name="birthdd" class="form-control">
											<option value ="01">01</option>
											<option value ="02">02</option>
											<option value ="03">03</option>
											<option value ="04">04</option>
											<option value ="05">05</option>
											<option value ="06">06</option>
											<option value ="07">07</option>
											<option value ="08">08</option>
											<option value ="09">09</option>
											<option value ="10">10</option>
											<option value ="11">11</option>
											<option value ="12">12</option>
											<option value ="13">13</option>
											<option value ="14">14</option>
											<option value ="15">15</option>
											<option value ="16">16</option>
											<option value ="17">17</option>
											<option value ="18">18</option>
											<option value ="19">19</option>
											<option value ="20">20</option>
											<option value ="21">21</option>
											<option value ="22">22</option>
											<option value ="23">23</option>
											<option value ="24">24</option>
											<option value ="25">25</option>
											<option value ="26">26</option>
											<option value ="27">27</option>
											<option value ="28">28</option>
											<option value ="29">29</option>
											<option value ="30">30</option>
											<option value ="31">31</option>
										</select>
									</div>
								</div>
							</div>
						</div>
						
						<div class="form-group">
							<label for="gender" class="cols-sm-2 control-label">성별</label>
							<div class="cols-sm-10">
								<div class="">
									<label class="radio-inline" for="gender-0">
										<input type="radio" name="gender" id="gender-0" value="0" checked="checked"> 남자
									</label> 
									<label class="radio-inline" for="gender-1"> 
										<input type="radio" name="gender" id="gender-1" value="1"> 여자
									</label>
								</div>
							</div>
						</div>
						
						<div class="form-group">
							
							<button type="button" id="button1id" name="button1id" class="btn btn-primary btn-lg btn-block login-button" onclick="goRegister();">가입하기</button>
						</div>
						
					</form>
				</div>
			</div>
		</div>

	</body>
</html>