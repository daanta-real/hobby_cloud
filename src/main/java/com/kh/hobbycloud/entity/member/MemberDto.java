package com.kh.hobbycloud.entity.member;

import java.sql.Date;

import lombok.Data;

@Data
public class MemberDto {
	private String memberId;
	private String memberPw;
	private String memberNick;
	private String memberBirth;
	private String memberEmail;
	private String memberPhone;
	private Date memberJoin;
	private int memberPoint;
	private String memberGrade;

	public String getmemberBirthDay() {
		return this.memberBirth.substring(0, 10);
	}
}





