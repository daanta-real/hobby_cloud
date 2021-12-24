package com.kh.hobbycloud.entity.petitions;

import java.sql.Date;

import lombok.Data;

@Data
public class UserDto {
	private String userId;
	private String userPw;
	private String userNick;
	private String userBirth;
	private String userEmail;
	private String userPhone;
	private Date userJoin;
	private int userPoint;
	private String userGrade;

	public String getuserBirthDay() {
		return this.userBirth.substring(0, 10);
	}
}




