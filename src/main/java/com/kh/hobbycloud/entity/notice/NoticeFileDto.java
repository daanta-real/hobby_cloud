package com.kh.hobbycloud.entity.notice;

import lombok.Data;

@Data
public class NoticeFileDto {
    private int noticeFileIdx;
    private int noticeIdx;
    private String noticeFileMemberName;
    private String noticeFileServerName;
    private long noticeFileSize;
    private String noticeFileType;

}
