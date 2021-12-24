package com.kh.hobbycloud.entity.gather;

import lombok.Data;

@Data
public class GatherFileDto {
private int GatherFileIdx, GatherIdx, GatherFileSize;
private String GatherFileUserName, GatherFileServerName, GatherFileType;
}
