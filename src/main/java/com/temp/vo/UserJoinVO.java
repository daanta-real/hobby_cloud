package com.temp.vo;

import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

/**
 * 	회원 가입 정보를 받기 위한 VO
 *	회원정보(MemberDto)와 프로필 이미지(attach)를 저장한다
 */
@Data
public class UserJoinVO {
	private String userId;
	private String userPw;
	private String userNick;
	private String userBirth;
	private String userEmail;
	private String userPhone;
	private MultipartFile attach;
}
