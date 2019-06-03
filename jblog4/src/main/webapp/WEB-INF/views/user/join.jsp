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
var check_id = false;


	$(function(){
		$("#blog-id").change(function(){
			$("#btn-checkemail").show();
			$("#img-checkemail").hide();
			check_id = false;
		});
		
		$("#btn-checkemail").click(function(){
			var id = $("#blog-id").val();
			if(id == "") {
				alert("아이디를 입력해 주세요.");
				return;
			}
			
			/* ajax 통신 */
			$.ajax({
				url: "${pageContext.servletContext.contextPath}/user/api/checkid?id="+id,
				type: "get",
				dataType: "json",
				data: "",
				success: function(response){
					if(response.result != "success") {
						console.log(response);
						check_id = false;
						return;
					}

					if(response.data == true) {
						alert("이미 존재하는 아이디입니다.\n다른 아이디를 사용해 주세요.");
						$("#blog-id").val("");
						check_id = false;
						return;
					}
					$("#btn-checkemail").hide();
					$("#img-checkemail").show();
					check_id = true;
					
				},
				error: function(xhr, error){
					console.error("error:" + error);
				}
			});
		});
	});

function join_form_check(var1) {
	var forms = document.getElementById(var1);
	
	if(forms.name.value == "") {
		alert("이름을 입력해 주세요.");
		return;
	}
	if(check_id == false) {
		alert("아이디 중복확인을 해주세요.");
		return;
	}
	if(forms.password.value == "") {
		alert("비밀번호를 입력해 주세요.");
		return;
	}
	if(forms.agreeProv.checked == false) {
		alert("서비스 약관에 동의해 주세요.");
		return;
	}
	
	forms.submit();
}
</script>

</head>
<body>
	<div class="center-content">
		<h1 class="logo">JBlog</h1>
		<c:import url="/WEB-INF/views/includes/navigation.jsp"></c:import>
		<form class="login-form" id="join-form" method="post" action="${pageContext.request.contextPath}/user/join">
			<label class="block-label" for="name">이름</label>
			<input id="name"name="name" type="text" value="">
			
			<label class="block-label" for="blog-id">아이디</label>
			<div style="overflow:hidden;line-height:40px;">
			<input id="blog-id" name="id" type="text" style="width:50%;float:left;margin-right:3px;" /> 
			<input id="btn-checkemail" type="button" value="id 중복체크" style="float:left;height:28px;padding:0 5px 0 5px;" />
			<img id="img-checkemail" style="display:none;float:left;" src="${pageContext.request.contextPath}/assets/images/check.png">
			</div>

			<label class="block-label" for="password">패스워드</label>
			<input id="password" name="password" type="password" />

			<fieldset>
				<label class="block-label">약관동의</label>
				<input id="agree-prov" type="checkbox" name="agreeProv" value="y" style="float:left;" />
				<label class="l-float" for="agree-prov">서비스 약관에 동의합니다.</label>
			</fieldset>

			<input type="button" value="가입하기" onclick="join_form_check('join-form');" style="padding:5px;" />

		</form>
	</div>
</body>
</html>
