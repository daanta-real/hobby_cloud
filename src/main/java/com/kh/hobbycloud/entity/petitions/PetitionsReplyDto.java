package com.kh.hobbycloud.entity.petitions;

import lombok.Data;

@Data
public class PetitionsReplyDto {
	private int petitonsReplyIdx;
	private int memberIdx;
	private int petitonsIdx;
	private String petitionsReplyDetail;
	private String petitionsReplyRegistered;

}
