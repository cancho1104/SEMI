<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<script type="text/javascript">



</script>

</head>
<body>

<form name="prodInputFrm" 
	  action="<%= request.getContextPath() %>/productRegisterEnd.do" 
	  method="POST" 
	  enctype="multipart/form-data">	
	<input type="file" id="filetext" />
	<button type="button" onclick="submit();">gogo</button>
</form>



</body>
</html>