package com.kh.hobbycloud.vo.member;

import java.sql.Date;

public class MemberListVO {
	
	private int memberIdx;
	private String memberGradeName;
	private String memberId;
	private String memberNick;
	private String memberEmail;
	private String memberPhone;
	private Date memberRegistered;
	private int memberPoint;
	private String memberRegion;
	private String memberGender;
	
	//memberProfile 테이블
	private int memberProfileIdx;		
	
	//MemberCategory 테이블
	private String lecCategoryName;

}
