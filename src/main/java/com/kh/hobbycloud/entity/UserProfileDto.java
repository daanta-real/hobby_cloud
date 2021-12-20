package com.kh.hobbycloud.entity;

import lombok.Data;

@Data
public class UserProfileDto {
	private int userProfileNo;
	private String userId;
	private String userProfileUploadname;
	private String userProfileSavename;
	private long userProfileSize;
	private String userProfileType;
}
