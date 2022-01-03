package com.kh.hobbycloud.repository.notice;

import java.io.IOException;
import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import com.kh.hobbycloud.entity.gather.GatherFileDto;
import com.kh.hobbycloud.entity.notice.NoticeFileDto;

public interface NoticeFileDao {
	void save(NoticeFileDto noticeFielDto, MultipartFile multipartFile) throws IllegalStateException, IOException;
	NoticeFileDto getNo(int noticeFileIdx);
	List<NoticeFileDto> getIdx(int noticeIdx);
	byte[] load(int noticeFileIdx) throws IOException;


}
