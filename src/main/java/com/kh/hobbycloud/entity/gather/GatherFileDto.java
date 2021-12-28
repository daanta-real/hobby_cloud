package com.kh.hobbycloud.entity.gather;

import lombok.Data;

@Data
public class GatherFileDto {
private int GatherFileIdx, GatherIdx;
private String GatherFileUserName, GatherFileServerName, GatherFileType;
private long GatherFileSize;
}
