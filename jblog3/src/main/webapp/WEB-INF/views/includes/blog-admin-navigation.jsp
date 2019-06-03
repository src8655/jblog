<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
				<ul class="admin-menu">
					<c:if test="${position eq 'basic'}">
						<li class="selected">기본설정</li>
					</c:if>
					<c:if test="${position ne 'basic'}">
						<li><a href="${pageContext.request.contextPath}/${blogVo.blogId}/admin/basic">기본설정</a></li>
					</c:if>
					
					<c:if test="${position eq 'category'}">
						<li class="selected">카테고리</li>
					</c:if>
					<c:if test="${position ne 'category'}">
						<li><a href="${pageContext.request.contextPath}/${blogVo.blogId}/admin/category">카테고리</a></li>
					</c:if>
					
					<c:if test="${position eq 'write'}">
						<li class="selected">글작성</li>
					</c:if>
					<c:if test="${position ne 'write'}">
						<li><a href="${pageContext.request.contextPath}/${blogVo.blogId}/admin/write">글작성</a></li>
					</c:if>
				</ul>