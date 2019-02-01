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
		$(".ramSearch").hide();
 		var i = 0;
		$("#add_row").click(function() {
			i++;
			$(".tbl-ram").append("<tr id='addr"+i+"' class='ramRow'><td><span class='idx'>"+i+"</span></td><td id='ram"+i+"'>"+$("#ram0").html()+"</td></tr>");
			$("#addr"+i).find(".idx").empty().text(i+1);
			console.log(i);
		});
		
		$("#delete_row").click(function() {
			if(i<1) {
				alert("삭제불가");
				return ;
			}
			$("#tbl-ram").find("#addr"+i).remove();
			i--;
			console.log(i);
		});
		
		$(document).on("click", ".btnRam", function() {
			$(this).parent().parent().find(".ramSearch").trigger("click");
		});
		
		$(document).on("change", ".ramSearch", function() {
			var rams = $(".ramSearch").val();
			console.log(rams);
			$(this).parent().parent().find(".ramcode").val(rams);
		});

		$(document).on("click",".ram", function() {
			var $target = $(event.target);
			var ram = $target.val();
			
			$target.css("background-ram", ram);				
		});// end of document on click ram

		$("#applyRam").click(function() {
			var addRam = "";
			
			var bool = false;
			
			$(".ram").each(function() {
				var ram = $(this).val().trim();
					
				var cnt = 0;
				
				$(".ram").each(function() {
					var dupleRam = $(this).val().trim();

					if(ram == dupleRam) {
						cnt++;
						if(cnt > 1){
							bool = true;
							return false;
						}
					}
				});// end of each
				
				if(ram != "") {
					addRam += ram+",";
				}
			});// end of each
			
			if(bool) {
				alert("램이 중복되었습니다.");
				return;
			}
			
			addRam = addRam.substring(0,addRam.length-1);
			
			$(opener.document).find("#rams").val(addRam);
			self.close();
		});// end of applyRam click

/* 		var i = 0;
		
		$("#add_row").on("click", function() {
			i++;
			$(".tbl-ram").append("<tr id='addr"+i+"'>"+$(".ramRow").html()+"</tr>");
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
				<button id="applyRam" class="btn btn-default pull-right"
					style="background-color: #000000; font-weight: bold; color: #ffffff;">등록하기</button>
			</div>
		</div>
	
		<div class="row clearfix" align="center">
			<div class="col-md-12" style="width: 100%;">
				<table class="table table-bordered table-hover" id="tab_logic">
				
					<thead>
						<tr>
							<th class="text-center">번호</th>
							<th class="text-center">용량선택</th>
						</tr>
					</thead>

					<tbody class="tbl-ram" id="tbl-ram">
						<tr id='addr0' class="ramRow">
							<td><span class="idx">1</span></td>

							<td id="ram0">
								<select class="form-control ram" id='ram0' name='rams'>
									<option value="8/0" selected>DDR4 8GB</option>
									<option value="16/80000" >DDR4 16GB</option>
									<option value="32/160000" >DDR4 32GB</option>
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