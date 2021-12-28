package com.kh.hobbycloud.service;

import java.io.IOException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.kh.hobbycloud.entity.notice.NoticeDto;
import com.kh.hobbycloud.entity.notice.NoticeFileDto;
import com.kh.hobbycloud.repository.notice.NoticeDao;
import com.kh.hobbycloud.repository.notice.NoticeFileDao;
import com.kh.hobbycloud.vo.NoticeFileVO;

@Service
public class NoticeServiceImpl implements NoticeService{
	
	@Autowired
	private NoticeDao noticeDao;
	
	@Autowired
	private NoticeFileDao noticeFileDao;
	
	NoticeDto noticeDto = new NoticeDto();
	

	@Override
	public void insert(NoticeFileVO noticeFileVO) throws IllegalStateException, IOException {
		//(필수) 글작성 정보 뽑아서 회원테이블에 저장
				//= MemberJoinVO에서 정보를 뽑아서 MemberDto를 생성하고 설정
		NoticeDto noticeDto = new NoticeDto();
		noticeDto.setNoticeIdx(noticeFileVO.getNoticeIdx());
		noticeDto.setMemberIdx(noticeFileVO.getMemberIdx());
		noticeDto.setNoticeName(noticeFileVO.getNoticeName());
		noticeDto.setNoticeDetail(noticeFileVO.getNoticeDetail());
		noticeDto.setNoticeRegistered(noticeFileVO.getNoticeRegistered());
		noticeDto.setNoticeReplies(noticeFileVO.getNoticeReplies());
		noticeDto.setNoticeView(noticeFileVO.getNoticeView());
		noticeDao.insert(noticeDto);
		
		MultipartFile multipartFile = noticeFileVO.getAttach();
		if(!multipartFile.isEmpty()) {
			NoticeFileDto noticeFileDto = new NoticeFileDto();
			noticeFileDto.setNoticeIdx(noticeFileVO.getNoticeIdx());
			noticeFileDto.setNoticeFileMemberName(multipartFile.getOriginalFilename());
			noticeFileDto.setNoticeFileType(multipartFile.getContentType());
			noticeFileDto.setNoticeFileSize(multipartFile.getSize());
			noticeFileDao.save(noticeFileDto, multipartFile);
		}
		
	}
	
	

}
