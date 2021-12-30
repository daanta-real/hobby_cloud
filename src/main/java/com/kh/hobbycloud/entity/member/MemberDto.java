package com.kh.hobbycloud.entity.member;

import java.sql.Date;

import lombok.Data;

@Data
public class MemberDto {
	private int memberIdx;
	private String memberGradeName;
	private String memberId;
	private String memberPw;
	private String memberNick;
	private String memberEmail;
	private String memberPhone;
	private Date memberRegistered;
	private int memberPoint;
	private String memberRegion;
	private String memberGender;
}





