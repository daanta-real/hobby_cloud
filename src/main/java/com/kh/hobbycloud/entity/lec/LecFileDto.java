package com.kh.hobbycloud.entity.lec;

import lombok.Data;

@Data
public class LecFileDto {
	private int lecFileIdx;
	private int lecIdx;
	private String lecFileUserName;
	private String lecFileServerName;
	private long lecFileSize;
	private String lecFileType;
}