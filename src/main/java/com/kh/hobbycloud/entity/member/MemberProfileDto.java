package com.kh.hobbycloud.entity.member;

import lombok.Data;

@Data
public class MemberProfileDto {
	private int memberProfileIdx;
	private int memberIdx;
	private String memberProfileUploadname;
	private String memberProfileSavename;
	private long memberProfileSize;
	private String memberProfileType;
}
