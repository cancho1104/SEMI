<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="//code.jquery.com/jquery-1.11.1.min.js"></script>
<link href="//maxcdn.bootstrapcdn.com/bootstrap/3.3.0/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
<script src="//maxcdn.bootstrapcdn.com/bootstrap/3.3.0/js/bootstrap.min.js"></script>

<script type="text/javascript">
	$(document).ready(function() {
		$(".colorSearch").hide();
 		var i = 0;
		$("#add_row").click(function() {
			i++;
			$(".tbl-color").append("<tr id='addr"+i+"' class='colorRow'><td><span class='idx'>"+i+"</span></td><td id='color"+i+"'>"+$("#color0").html()+"</td></tr>");
			$("#addr"+i).find(".idx").empty().text(i+1);
			console.log(i);
		});
		
		$("#delete_row").click(function() {
			if(i<1) {
				alert("삭제불가");
				return ;
			}
			$("#tbl-color").find("#addr"+i).remove();
			i--;
			console.log(i);
		});
		
		$(document).on("click", ".btnColor", function() {
			$(this).parent().parent().find(".colorSearch").trigger("click");
		});
		
		$(document).on("change", ".colorSearch", function() {
			var colors = $(".colorSearch").val();
			console.log(colors);
			$(this).parent().parent().find(".colorcode").val(colors);
		});
		
		$(document).on("click",".color", function() {
			var $target = $(event.target);
			var color = $target.val();
			
			$target.css("background-color", color);				
		});// end of document on click color
		
		$("#applyColor").click(function() {
			
			var addColor = "";
			
			var bool = false;
			
			$(".color").each(function() {
				
				var color = $(this).val().trim();
				
				var cnt = 0;
				
				$(".color").each(function() {
					var dupleColor = $(this).val().trim();
					
					if(color == dupleColor) {
						cnt++;
						if(cnt > 1){
							bool = true;
							return false;
						}
					}

					
				});// end of each
				
				if(bool)
					return false;
				
				if(color != "") {
					addColor += color+",";
				}
			});// end of each
			
			if(bool) {
				alert("색이 중복되었습니다.");
				return;
			}
				
			
			addColor = addColor.substring(0,addColor.length-1);
			
			$(opener.document).find("#colors").val(addColor);
			self.close();
		});// end of applyColor click

/* 		var i = 0;
		
		$("#add_row").on("click", function() {
			i++;
			$(".tbl-color").append("<tr id='addr"+i+"'>"+$(".colorRow").html()+"</tr>");
		});// end of add_row on

		$("#delete_row").on("click", function() {
			
			if(i<1) {
				alert("삭제불가");
				return ;
			}
			$("#addr" + i).remove();
			i--;
		}); */

	});// end of document ready

</script>
<title>이미지 추가</title>
</head>
<body>
	<div class="container">
	
		<div class="row clearfix" style="padding-top: 2%; padding-bottom: 2%;">
			<div class="col-md-12">
				<button id="applyColor" class="btn btn-default pull-right"
					style="background-color: #000000; font-weight: bold; color: #ffffff;">등록하기</button>
			</div>
		</div>
	
		<div class="row clearfix" align="center">
			<div class="col-md-12" style="width: 100%;">
				<table class="table table-bordered table-hover" id="tab_logic">
				
					<thead>
						<tr>
							<th class="text-center">번호</th>
							<th class="text-center">색깔입력</th>
						</tr>
					</thead>

					<tbody class="tbl-color" id="tbl-color">
						<tr id='addr0' class="colorRow">
							<td><span class="idx">1</span></td>

							<td id="color0">
								<select class="form-control color" id='color0' name='colors'>
									<option value="#000000" style="background-color: #000000;" selected></option>
									<option value="#b19c83" style="background-color: #b19c83;"></option>
									<option value="#999999" style="background-color: #999999;"></option>
									<option value="#0e8ce4" style="background-color: #0e8ce4;"></option>
									<option value="#df3b3b" style="background-color: #df3b3b;"></option>
									<option value="#ffffff" style="background-color: #ffffff;"></option>
								</select>
							</td>
						</tr>
						  
					</tbody>
				</table>
			</div>
		</div>

		<div class="row clearfix">
			<div class="col-md-12">
				<button id="add_row" class="btn btn-default pull-left" >Add Row</button>
				<button id='delete_row' class="pull-right btn btn-default" >Delete Row</button>
			</div>
		</div>

	</div>
</body>
</html>