package com.kh.hobbycloud.entity.member;

import lombok.Data;

@Data
public class MemberProfileDto {
	private int memberProfileNo;
	private String memberId;
	private String memberProfileUploadname;
	private String memberProfileSavename;
	private long memberProfileSize;
	private String memberProfileType;
}
