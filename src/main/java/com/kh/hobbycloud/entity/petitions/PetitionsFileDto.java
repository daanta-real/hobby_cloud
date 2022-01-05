package com.kh.hobbycloud.entity.petitions;

import lombok.Data;

@Data
public class PetitionsFileDto {
	private int petitionsFileIdx;
	private int petitionsIdx;
	private String petitionsFileMemberName;
	private String petitionsFileServerName;
	private long petitionsFileSize;
	private String petitionsFileType;

}
