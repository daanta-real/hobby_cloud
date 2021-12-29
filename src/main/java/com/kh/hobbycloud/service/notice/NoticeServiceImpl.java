package com.kh.hobbycloud.service.notice;

import java.io.IOException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.kh.hobbycloud.entity.notice.NoticeDto;
import com.kh.hobbycloud.entity.notice.NoticeFileDto;
import com.kh.hobbycloud.repository.notice.NoticeDao;
import com.kh.hobbycloud.repository.notice.NoticeFileDao;
import com.kh.hobbycloud.vo.notice.NoticeVO;

@Service
public class NoticeServiceImpl implements NoticeService{
	
	@Autowired
	private NoticeDao noticeDao;
	
	@Autowired
	private NoticeFileDao noticeFileDao;
	

	
	
	

	@Override
	public void insert(NoticeVO noticeVO) throws IllegalStateException, IOException {
		
		NoticeDto noticeDto = new NoticeDto();
		
		noticeDto.setNoticeIdx(noticeVO.getNoticeIdx());
	
		noticeDto.setMemberIdx(noticeVO.getMemberIdx());
		noticeDto.setNoticeName(noticeVO.getNoticeName());
		noticeDto.setNoticeDetail(noticeVO.getNoticeDetail());
		noticeDto.setNoticeRegistered(noticeVO.getNoticeRegistered());
		noticeDto.setNoticeReplies(noticeVO.getNoticeReplies());
		noticeDto.setNoticeView(noticeVO.getNoticeViews());
		noticeDao.insert(noticeDto);
		
		// 파일 선택시
		List<MultipartFile> attach = noticeVO.getAttach();
		
		NoticeFileDto noticeFileDto = new NoticeFileDto();
		for(MultipartFile file : attach) {
		if(!file.isEmpty()) { 
		  noticeFileDto.setNoticeIdx(noticeIdx);
		  noticeFileDto.setNoticeFileMemberName(multipartFile.getOriginalFilename());
		  noticeFileDto.setNoticeFileType(multipartFile.getContentType());
		  noticeFileDto.setNoticeFileSize(multipartFile.getSize());
		  noticeFileDao.save(noticeFileDto, multipartFile);
		  
		 
		  }
		
		}
	return noticeIdx;
	
	


