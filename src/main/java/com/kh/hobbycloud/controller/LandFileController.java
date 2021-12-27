package com.kh.hobbycloud.controller;

import java.util.List;

import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.kh.hobbycloud.vo.member.MemberUploadVO;

public class LandFileController {
		
		/**
		 * 	파일이 여러 개 첨부될 경우(multiple)에 대한 처리
		 * (주의) 
		 * - 파일이 첨부되지 않아도 배열이나 리스트의 개수가 1개
		 * - 단순하게 반복으로 처리하지 말고 꼭! 파일이 있는지 확인을 해서 처리하도록 코드를 작성
		 */
		@PostMapping("/upload2")
		public String upload2(
				@RequestParam String memberId,
				@RequestParam String memberPw,
//				@RequestParam MultipartFile[] attach
				@RequestParam List<MultipartFile> attach
				) {
			System.out.println("memberId = " + memberId);
			System.out.println("memberPw = " + memberPw);		
			
//			System.out.println("파일개수 : "+attach.length);//배열
			System.out.println("파일개수 : "+attach.size());//List
			
			for(MultipartFile file : attach) {
				if(!file.isEmpty()) {
					System.out.println("originalFileName = " + file.getOriginalFilename());
					System.out.println("contentType = " + file.getContentType());
					System.out.println("size = " + file.getSize());
				}
			}
			
			return "redirect:/";
		}
		
		@PostMapping("/upload3")
		public String upload3(@ModelAttribute MemberUploadVO vo) {
			System.out.println(vo);
			return "redirect:/";
		}
	}




