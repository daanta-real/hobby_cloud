package com.kh.hobbycloud.repository.notice;

import java.io.IOException;
import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import com.kh.hobbycloud.entity.notice.NoticeFileDto;

public interface NoticeFileDao {
	void save(NoticeFileDto noticeFielDto, List<MultipartFile> multipartFile) throws IllegalStateException, IOException;


}
