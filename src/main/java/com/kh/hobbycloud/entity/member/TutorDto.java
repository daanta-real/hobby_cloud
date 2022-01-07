package com.kh.hobbycloud.entity.member;

import java.sql.Date;

import lombok.Data;

@Data
public class TutorDto {
	private int tutorIdx;
	private int memberIdx;
	private String tutorDetail;//강사 소개
	private Date tutorRegistered;//강사 등록일
}
