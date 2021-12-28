package com.kh.hobbycloud.entity.member;

import java.sql.Date;

import lombok.Data;

@Data
public class TutorDto {
	private int tutorIdx;
	private int memberIdx;
	private String tutorDetail;
	private Date tutorRegistered;
}
