package com.kh.hobbycloud.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RestController;

@ControllerAdvice(annotations = {Controller.class, RestController.class})

public class ErrorController {


	@ExceptionHandler(Exception.class)
	public String ex(Exception e) {
		System.err.println(e);
		return "error/500";
	}

}