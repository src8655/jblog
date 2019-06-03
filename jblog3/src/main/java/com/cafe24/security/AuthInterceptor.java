package com.cafe24.security;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.method.HandlerMethod;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.cafe24.jblog.vo.UserVo;


public class AuthInterceptor extends HandlerInterceptorAdapter {

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		
		//Auth가 안붙어있으면 무시
		//Auth가 붙어있으면 진행
		
		
		//1. handler종류 확인 HanlderMethod, DefaultHandlerServlet
		if(handler instanceof HandlerMethod == false) {		// images, css, js
			return true;
		}
		
		//2. casting
		HandlerMethod handlerMethod = (HandlerMethod)handler;
		
		//3. Method의 @Auth 받아오기
		Auth auth = handlerMethod.getMethodAnnotation(Auth.class);
		
		//5. @Auth가 안 붇는 경우
		if(auth == null) {
			return true;
		}
		
		//6. @Auth가 (class 또는 method에) 붙어있기 때문에
		//   인증 여부 체크
		HttpSession session = request.getSession();
		if(session == null) {
			response.sendRedirect(request.getContextPath()+"/");
			return false;
		}
		UserVo authUser = (UserVo)session.getAttribute("authUser");
		if(authUser == null) {
			response.sendRedirect(request.getContextPath()+"/");
			return false;
		}
		//request.setAttribute("authUser", authUser);
		/*
		 * //7. Role 가져오기 Auth.Role role = auth.role();
		 * 
		 * //8. role이 Auth.Role.USER라면 // 인증된 모든 사용자는 접근 if(role == Auth.Role.USER) {
		 * return true; }
		 * 
		 * //9. Admin Role 권한 체크 if(role == Auth.Role.ADMIN) {
		 * if(authUser.getRole().equals(Auth.Role.ADMIN.toString())) { return true;
		 * }else { response.sendRedirect(request.getContextPath()+"/"); return false; }
		 * }
		 */
		
		
		return true;
	}

}
