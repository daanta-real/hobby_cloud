package com.kh.hobbycloud.repository.notice;

import java.io.IOException;
import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import com.kh.hobbycloud.entity.gather.GatherFileDto;
import com.kh.hobbycloud.entity.notice.NoticeFileDto;

public interface NoticeFileDao {
	void save(NoticeFileDto noticeFileDto, MultipartFile multipartFile) throws IllegalStateException, IOException;
	NoticeFileDto getNo(int noticeFileIdx);
	List<NoticeFileDto> getIdx(int noticeIdx);
	byte[] load(int noticeFileIdx) throws IOException;
	
	// DELETE
		boolean delete(int noticeIdx);
		boolean deleteAjax(int noticeFileIdx);
		boolean deleteList(int noticeIdx, List<String> list);


}
