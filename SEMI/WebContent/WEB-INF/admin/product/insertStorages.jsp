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
		$(".storageSearch").hide();
 		var i = 0;
		$("#add_row").click(function() {
			i++;
			$(".tbl-storage").append("<tr id='addr"+i+"' class='storageRow'><td><span class='idx'>"+i+"</span></td><td id='storage"+i+"'>"+$("#storage0").html()+"</td></tr>");
			$("#addr"+i).find(".idx").empty().text(i+1);
			console.log(i);
		});
		
		$("#delete_row").click(function() {
			if(i<1) {
				alert("삭제불가");
				return ;
			}
			$("#tbl-storage").find("#addr"+i).remove();
			i--;
			console.log(i);
		});
		
		$(document).on("click", ".btnStorage", function() {
			$(this).parent().parent().find(".storageSearch").trigger("click");
		});
		
		$(document).on("change", ".storageSearch", function() {
			var storages = $(".storageSearch").val();
			console.log(storages);
			$(this).parent().parent().find(".storagecode").val(storages);
		});
		
		$(document).on("click",".storage", function() {
			var $target = $(event.target);
			var storage = $target.val();
			
			$target.css("background-storage", storage);				
		});// end of document on click storage
		
		$("#applyStorage").click(function() {
			var addStorage = "";
			
			var bool = false;
			
			$(".storage").each(function() {
				var storage = $(this).val().trim();
				
				var cnt = 0;
				
				$(".storage").each(function() {
					var dupleStorage = $(this).val().trim();

					if(storage == dupleStorage) {
						cnt++;
						if(cnt > 1){
							bool = true;
							return false;
						}
					}
					
				});// end of each

				if(storage != "") {
					addStorage += storage+",";
				}
			});// end of each
			
			if(bool) {
				alert("저장장치가 중복되었습니다.");
				return;
			}
			
			addStorage = addStorage.substring(0,addStorage.length-1);
			
			$(opener.document).find("#storages").val(addStorage);
			self.close();
		});// end of applyStorage click

/* 		var i = 0;
		
		$("#add_row").on("click", function() {
			i++;
			$(".tbl-storage").append("<tr id='addr"+i+"'>"+$(".storageRow").html()+"</tr>");
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
				<button id="applyStorage" class="btn btn-default pull-right"
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

					<tbody class="tbl-storage" id="tbl-storage">
						<tr id='addr0' class="storageRow">
							<td><span class="idx">1</span></td>

							<td id="storage0">
								<select class="form-control storage" id='storage0' name='storages'>
									<option value="s256GB/30000" selected>SSD 256GB</option>
									<option value="s512GB/110000" >SSD 512GB</option>
									<option value="h512GB/0" >HDD 512GB</option>
									<option value="h1TB/30000" >HDD 1TB</option>
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