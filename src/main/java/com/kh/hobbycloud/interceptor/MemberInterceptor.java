package com.kh.hobbycloud.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.HandlerInterceptor;

public class MemberInterceptor implements HandlerInterceptor{
	
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		String memberId = (String) request.getSession().getAttribute("memberId");
		boolean isLogin = memberId != null;
		if(isLogin) {
			return true;
		}
		else {
			response.sendError(401);
			return false;
		}
	}
	
}