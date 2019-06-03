<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
	<ul>
		<c:if test="${authUser eq null}">
			<li><a href="${pageContext.request.contextPath}/user/login">로그인</a></li>
		</c:if>
		<c:if test="${authUser ne null}">
			<li><a href="${pageContext.request.contextPath}/user/logout">로그아웃</a></li>
			<c:if test="${authUser.id eq blogVo.blogId}">
				<li><a href="${pageContext.request.contextPath}/${authUser.id}/admin/basic">블로그 관리</a></li>
			</c:if>
		</c:if>
	</ul>