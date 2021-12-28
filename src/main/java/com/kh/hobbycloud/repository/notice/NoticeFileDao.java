package com.kh.hobbycloud.repository.notice;

import java.io.IOException;

import org.springframework.web.multipart.MultipartFile;

import com.kh.hobbycloud.entity.notice.NoticeFileDto;

public interface NoticeFileDao {
	void save(NoticeFileDto noticeFileDto, MultipartFile multipartFile) throws IllegalStateException, IOException;

}
