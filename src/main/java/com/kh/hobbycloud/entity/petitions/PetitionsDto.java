package com.kh.hobbycloud.entity.petitions;

import java.sql.Date;

import lombok.Data;

@Data
public class PetitionsDto {
	private int petitonsIdx;
	private int memberIdx;
	private String petitionsName;
	private Date petitionsRegistered;
	private int petitonsView;
	private int petitonsReplies;
	

}
