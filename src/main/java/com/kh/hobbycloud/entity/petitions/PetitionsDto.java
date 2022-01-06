package com.kh.hobbycloud.entity.petitions;

import java.sql.Date;

import lombok.Data;

@Data
public class PetitionsDto {
	private int petitionsIdx;
	private int memberIdx;
	private String petitionsName;
	private String petitionsDetail;
	private Date petitionsRegistered;
	private int petitionsView;
	private int petitionsReplies;
	

}
