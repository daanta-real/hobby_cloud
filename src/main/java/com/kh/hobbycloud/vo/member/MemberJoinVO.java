package com.kh.hobbycloud.vo.member;

import java.sql.Date;

import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

/**
 * 	회원 가입 정보를 받기 위한 VO
 *	회원정보(MemberDto)와 프로필 이미지(attach)를 저장한다
 */
@Data
public class MemberJoinVO {
	//member 테이블
	private int memberIdx;
	private String memberId;
	private String memberPw;
	private String memberNick;
	private String memberEmail;
	private String memberPhone;
	private Date memberRegistered;
	private int memberPoint;
	private String memberRegion;
	private String memberGender;
	
	//memberProfile 테이블
	private MultipartFile attach;		
	
	//MemberCategory 테이블
	private String lecCategoryName;

}