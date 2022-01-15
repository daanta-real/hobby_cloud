package com.kh.hobbycloud.entity.petitions;

import java.sql.Date;

import lombok.Data;

@Data
public class PetitionsReplyDto {
	private int petitionsReplyIdx;
	private int memberIdx;
	private int petitionsIdx;
	private String petitionsReplyDetail;
	private Date petitionsReplyRegistered;

}
