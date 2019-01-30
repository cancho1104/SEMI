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
		
		$("#name, #email").keydown(function(event) {
			if(event.keyCode == 13) {// 엔터를 했을 경우
				idSearch();			
			}
		});// end of $("#loginPwd").keydown()-----------------------------------
		
	});
	
	function idSearch() {
		
		if($("#name").val().trim() == "") {
			alert("이름을 입력하세요.");
			return;
		}
		
		if($("#email").val().trim() == "") {
			alert("이메일을 입력하세요.");
			return;
		}
		
		<%-- 이메일 검사 --%>
		regExp = new RegExp(/^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/i);
		
		bool = regExp.test($("#email").val());
		
		
		if(!bool){ 
			alert("이메일 형식에 맞게 입력해주세요");
			return;
		}
		
		var form_data = {name:$("#name").val(), email:$("#email").val()};
		$.ajax({
			url:"idFindEnd.do",
			type:"POST",
			data:form_data,
		    dataType:"JSON",
		    success:function(json){
		    	
		    	var html = "";
		    	
		    	if(json.userid == "") {
		    		
		    		html="<div class='form-group'>일치하는 결과가 없습니다.</div>";
		    		
		    		$("#notFound").empty().html(html);
		    	}
		    	else if(json.userid != "") { 
		    		html = "<div class='form-group'>회원님의 아이디는 <span style='color:red'>\"" + json.userid + "\"</span> 입니다. </div>" +
		    			   "<button class='btn btn-lg btn-info btn-block' type='button' onClick='javascript:location.href=\"login.do\";'>로그인 페이지로</button>";
		    		
		    		$(".panel-body").empty().html(html);
		    	}
		    },
		    error: function(request, status, error){
				alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
			}
		}); 
		
	}
</script>
<title>아이디 찾기</title>
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
									<h3 class="panel-title">아이디 찾기</h3>
								</div>
								<div class="panel-body">
									<span id="notFound"></span>
									<form name="idFindFrm" accept-charset="UTF-8" role="form"> 
										<fieldset>
											<div class="form-group">
												이름<input class="form-control" placeholder="이름을 입력해주세요" id="name" name="name" type="text" required>
											</div>
											<div class="form-group">
												이메일
												<input class="form-control" placeholder="example@gmail.com" id="email" name="email" type="text" required>
											</div>
											<button class="btn btn-lg btn-info btn-block" type="button" onClick="idSearch();">찾기</button>
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