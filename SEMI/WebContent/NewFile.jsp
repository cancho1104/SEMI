<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<script src="//code.jquery.com/jquery-1.11.1.min.js"></script>
<link href="//maxcdn.bootstrapcdn.com/bootstrap/3.3.0/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
<script src="//maxcdn.bootstrapcdn.com/bootstrap/3.3.0/js/bootstrap.min.js"></script>


<style type="text/css">
.center {
	margin-top: 50px;
}

.modal-header {
	padding-bottom: 5px;
}

.modal-footer {
	padding: 0;
}

.modal-footer .btn-group button {
	height: 40px;
	border-top-left-radius: 0;
	border-top-right-radius: 0;
	border: none;
	border-right: 1px solid #ddd;
}

.modal-footer .btn-group:last-child>button {
	border-right: 0;
}
</style>

</head>
<body>

	<!------ Include the above in your HEAD tag ---------->


	<div class="center">
		<button data-toggle="modal" data-target="#squarespaceModal" class="btn btn-primary center-block">Click Me</button>
	</div>


	<!-- line modal -->
	<div class="modal fade" id="squarespaceModal" tabindex="-1" role="dialog" aria-labelledby="modalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">
						<span aria-hidden="true">×</span><span class="sr-only">Close</span>
					</button>
					<h3 class="modal-title" id="lineModalLabel">My Modal</h3>
				</div>
				
				<div class="modal-body">

					<!-- content goes here -->


					<div class="form-group">

						<div class="row clearfix" style="padding-top: 2%; padding-bottom: 2%;">
							<div class="col-md-12">
								<button id="applyImg" class="btn btn-default pull-right" style="background-color: #000000; font-weight: bold; color: #ffffff;">등록하기</button>
							</div>
						</div>

						<div class="row clearfix">
							<div class="col-md-12">

								<table class="table table-bordered table-hover" id="tab_logic">

									<thead>
										<tr>
											<th class="text-center">번호</th>
											<th class="text-center">이미지파일 경로</th>
											<th class="text-center">파일찾기</th>
										</tr>
									</thead>

									<tbody class="tbl-img" id="tbl-img">
										<tr id='addr0' class="imgRow">
											<td><span class="idx">1</span></td>
											<td><input type="text" name='pimage' placeholder='경로명' class="form-control pimages" value="" /></td>
											<td><button type="button" class="btnFile form-control btn btn-dark" style="background-color: #000000;">
													<span style="font-weight: bold; color: #ffffff;">첨부</span>
												</button> <span id="imagesPath" class="imagesPath"><input type="file" class="fileSearch" value="" /></span></td>
										</tr>

									</tbody>
								</table>

							</div>
						</div>
						<div class="row clearfix">
							<div class="col-md-12">
								<button id="add_row" class="btn btn-default pull-left">Add Row</button>
								<button id='delete_row' class="pull-right btn btn-default">Delete Row</button>
							</div>
						</div>



					</div>


				</div>
				
				<div class="modal-footer">
					<div class="btn-group btn-group-justified" role="group" aria-label="group button">
						<div class="btn-group" role="group">
							<button type="button" class="btn btn-default" data-dismiss="modal" role="button">Close</button>
						</div>
						<div class="btn-group btn-delete hidden" role="group">
							<button type="button" id="delImage" class="btn btn-default btn-hover-red" data-dismiss="modal" role="button">Delete</button>
						</div>
						<div class="btn-group" role="group">
							<button type="button" id="saveImage" class="btn btn-default btn-hover-green" data-action="save" role="button">Save</button>
						</div>
					</div>
				</div>
				
			</div>
		</div>
	</div>
	
</body>
</html>