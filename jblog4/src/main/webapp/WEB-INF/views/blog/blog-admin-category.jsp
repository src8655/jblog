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
<script type="text/javascript" src="${pageContext.servletContext.contextPath}/assets/js/jquery/jquery-1.9.0.js"></script>

<script type="text/javascript">
$(function(){
	$("#category-btn").click(function(){
		if($("#input-name").val() == "") {
			alert("카테고리명을 입력해 주세요.");
			return;
		}
		if($("#input-description").val() == "") {
			alert("설명을 입력해 주세요.");
			return;
		}
		
		
		var blogId_tmp = "${blogVo.blogId}";
		$.ajax({
			url: "${pageContext.servletContext.contextPath}/blog/admin/api/category",
			type: "post",
			dataType: "json",
			data:
			{
				"name":$("#input-name").val(),
				"description":$("#input-description").val(),
				"blogId":blogId_tmp
			},
			success: function(response){
				if(response.result != "success") {
					alert(response.message);
					return;
				}
				
				$("#input-name").val("");
				$("#input-description").val("");
				
				//새로고침
				category_list_refresh();
			},
			error: function(xhr, error){
				console.error("error:" + error);
			}
		});
	});
});


function category_list_refresh() {
	var blogId_tmp = "${blogVo.blogId}";
	$.ajax({
		url: "${pageContext.servletContext.contextPath}/blog/admin/api/category",
		type: "get",
		dataType: "json",
		data:
		{
			"blogId":blogId_tmp
		},
		success: function(response){
			if(response.result != "success") {
				alert(response.message);
				return;
			}
			
			var htmls = "";
			htmls += '<table class="admin-cat">';
			htmls += '	<tr>';
			htmls += '		<th>번호</th>';
			htmls += '		<th>카테고리명</th>';
			htmls += '		<th>포스트 수</th>';
			htmls += '		<th>설명</th>';
			htmls += '		<th>삭제</th>';
			htmls += '	</tr>';
			
			var i = 0;
			var cnt = response.data.cnt;
			for(i=0;i<response.data.categoryList.length;i++) {
				var cdata = response.data.categoryList[i];
				htmls += '	<tr>';
				htmls += '		<td>'+cnt+'</td>';
				htmls += '		<td>'+cdata.name+'</td>';
				htmls += '		<td>'+cdata.count+'</td>';
				htmls += '		<td>'+cdata.description+'</td>';
				htmls += '		<td><a href="#100" onclick="category_delete(\''+cdata.no+'\');"><img src="${pageContext.request.contextPath}/assets/images/delete.jpg" /></a></td>';
				htmls += '	</tr>';
				cnt--;
			}
			
			htmls += '</table>';
			
			document.getElementById("table-data").innerHTML = htmls;
			
		},
		error: function(xhr, error){
			console.error("error:" + error);
		}
	});
}

function category_delete(var1) {
	var blogId_tmp = "${blogVo.blogId}";
	$.ajax({
		url: "${pageContext.servletContext.contextPath}/blog/admin/api/category/delete",
		type: "post",
		dataType: "json",
		data:
		{
			"blogId":blogId_tmp,
			"no":var1
		},
		success: function(response){
			if(response.result != "success") {
				alert(response.message);
				return;
			}
			
			//새로고침
			category_list_refresh();
		},
		error: function(xhr, error){
			console.error("error:" + error);
		}
	});
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
				<div id="table-data">
		      	<table class="admin-cat">
		      		<tr>
		      			<th>번호</th>
		      			<th>카테고리명</th>
		      			<th>포스트 수</th>
		      			<th>설명</th>
		      			<th>삭제</th>      			
		      		</tr>
		      		<c:forEach items="${categoryList}" var="cdata">
					<tr>
						<td>${cnt}</td>
						<td>${cdata.name}</td>
						<td>${cdata.count}</td>
						<td>${cdata.description}</td>
						<td><a href="#100" onclick="category_delete('${cdata.no}');"><img src="${pageContext.request.contextPath}/assets/images/delete.jpg" /></a></td>
					</tr>
					<c:set var="cnt" value="${cnt-1}" scope="page"></c:set>
					</c:forEach>
				</table>
				</div>
      	
      			<h4 class="n-c">새로운 카테고리 추가</h4>
		      	<table id="admin-cat-add">
		      		<tr>
		      			<td class="t">카테고리명</td>
		      			<td><input type="text" name="name" id="input-name" /></td>
		      		</tr>
		      		<tr>
		      			<td class="t">설명</td>
		      			<td><input type="text" name="description" id="input-description" /></td>
		      		</tr>
		      		<tr>
		      			<td class="s">&nbsp;</td>
		      			<td><input type="button" value="카테고리 추가" id="category-btn" /></td>
		      		</tr>      		      		
		      	</table> 
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