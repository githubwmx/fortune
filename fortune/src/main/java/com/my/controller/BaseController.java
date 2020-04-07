package com.my.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.bind.annotation.ModelAttribute;

public class BaseController  {

	protected HttpServletRequest request;  
	protected HttpServletResponse response;  
	protected HttpSession session; 
	
	@ModelAttribute  
	public void setHttp(HttpServletRequest request, HttpServletResponse response){  
		this.request = request;  
		this.response = response;  
		this.session = request.getSession(true);  
	} 
	
	public HttpServletRequest getRequest() {
		return request;
	}

	public void setRequest(HttpServletRequest request) {
		this.request = request;
	}

	public HttpServletResponse getResponse() {
		return response;
	}

	public void setResponse(HttpServletResponse response) {
		this.response = response;
	}

	public HttpSession getSession() {
		return session;
	}

	public void setSession(HttpSession session) {
		this.session = session;
	}
	
}
