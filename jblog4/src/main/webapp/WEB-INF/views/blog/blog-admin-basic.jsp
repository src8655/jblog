<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!doctype html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>JBlog</title>
<Link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/jblog.css">
<script type="text/javascript">
function form_basic_check(var1) {
	var form = document.getElementById(var1);
	if(form.title.value == "") {
		alert("블로그 제목을 입력해 주세요.");
		return;
	}
	
	form.submit();
}
</script>
</head>
<body>
	<div id="container">
		<div id="header">
			<h1><a href="${pageContext.request.contextPath}/${blogVo.blogId}" style="color:#ffffff;">${blogVo.title}</a></h1>
			<c:import url="/WEB-INF/views/includes/blog-navigation.jsp"></c:import>
		</div>
		<div id="wrapper">
			<div id="content" class="full-screen">
				<c:import url="/WEB-INF/views/includes/blog-admin-navigation.jsp"></c:import>
				<form action="${pageContext.request.contextPath}/${blogVo.blogId}/admin/basic" method="post" enctype="multipart/form-data" id="form-basic">
	 		      	<table class="admin-config">
			      		<tr>
			      			<td class="t">블로그 제목</td>
			      			<td><input type="text" size="40" name="title" value="${blogVo.title}" /></td>
			      		</tr>
			      		<tr>
			      			<td class="t">로고이미지</td>
			      			<td>
			      				<c:if test="${blogVo.logo eq null}">
			      					<img src="${pageContext.request.contextPath}/assets/images/spring-logo.jpg">
			      				</c:if>
			      				<c:if test="${blogVo.logo ne null}">
			      					<img src="${pageContext.request.contextPath}${blogVo.logo}">
			      				</c:if>
			      			</td>
			      		</tr>      		
			      		<tr>
			      			<td class="t">&nbsp;</td>
			      			<td><input type="file" name="logo_file"></td>      			
			      		</tr>           		
			      		<tr>
			      			<td class="t">&nbsp;</td>
			      			<td class="s"><input type="button" value="기본설정 변경" onclick="form_basic_check('form-basic');" /></td>      			
			      		</tr>           		
			      	</table>
				</form>
			</div>
		</div>
		<div id="footer">
			<p>
				<strong>${blogVo.title}</strong> is powered by JBlog (c)2016
			</p>
		</div>
	</div>
</body>
</html>