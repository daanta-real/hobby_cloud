package com.kh.hobbycloud.entity.member;

import lombok.Data;

@Data
public class MemberProfileDto {
	private int userProfileNo;
	private String userId;
	private String userProfileUploadname;
	private String userProfileSavename;
	private long userProfileSize;
	private String userProfileType;
}
