package com.kh.hobbycloud.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.HandlerInterceptor;

public class MemberInterceptor implements HandlerInterceptor{
	
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		String memberNick = (String)request.getSession().getAttribute("memberNick");
		
		boolean isLogin = memberNick != null;    
		if(isLogin) {
			return true;
		}
		else {
			//response.sendError(401);
			//비회원은 차단
			response.sendRedirect(request.getContextPath()+"/member/login"); //리다이렉트처리
			return false;
		}
	}
	
}