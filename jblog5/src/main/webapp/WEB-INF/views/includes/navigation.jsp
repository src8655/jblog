<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
		<ul class="menu">
			<c:if test="${authUser eq null}">
				<li><a href="${pageContext.request.contextPath}/user/login">로그인</a></li>
				<li><a href="${pageContext.request.contextPath}/user/join">회원가입</a></li>
			</c:if>
			<c:if test="${authUser ne null}">
				<li><span style="font-weight:bold;">${authUser.name}</span>님 환영합니다.</li>
				<li><a href="${pageContext.request.contextPath}/user/logout">로그아웃</a></li>
				<li><a href="${pageContext.request.contextPath}/${authUser.id}">내블로그</a></li>
			</c:if>
		</ul>