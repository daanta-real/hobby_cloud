package com.kh.hobbycloud.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.HandlerInterceptor;

public class TeacherInterceptor implements HandlerInterceptor{
	
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
	
		String memberGrade = (String)request.getSession().getAttribute("memberGrade");
		//등급이 강사 or 관리자만 가능하다.
		boolean isValid = memberGrade.equals("강사") || memberGrade.equals("관리자");    
		if(isValid) {
			return true;
		}
		else {
			//response.sendError(401);
			//비회원은 차단
			response.sendRedirect(request.getContextPath()+"/"); //리다이렉트처리
			return false;
		}
	}
	
}