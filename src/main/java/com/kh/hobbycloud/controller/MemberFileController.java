package com.kh.hobbycloud.controller;

import java.io.File;
import java.io.IOException;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;


@Controller
public class MemberFileController {	
	
	@PostMapping("/upload")
	public String upload(
				@RequestParam String memberId,
				@RequestParam String memberPw,
				@RequestParam MultipartFile attach
			) throws IllegalStateException, IOException {
		System.out.println("memberId = " + memberId);
		System.out.println("memberPw = " + memberPw);
		
		System.out.println("empty? " + attach.isEmpty());
		System.out.println("originalFileName = " + attach.getOriginalFilename());
		System.out.println("contentType = " + attach.getContentType());
		System.out.println("size = " + attach.getSize());
		
		//저장할 위치를 파일 객체로 설정한 뒤 저장 명령을 호출
		File dir = new File("D:/upload");//기준 폴더
		File target = new File(dir, attach.getOriginalFilename());//저장 파일 설정
		attach.transferTo(target);//저장
		
		return "redirect:/";
	}	

}




