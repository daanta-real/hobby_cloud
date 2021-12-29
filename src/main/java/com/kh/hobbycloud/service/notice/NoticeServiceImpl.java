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
	
	NoticeDto noticeDto = new NoticeDto();
	

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
		
		List<MultipartFile> multipartFile = noticeVO.getAttach();
		
		 /*if(!multipartFile.isEmpty()) { 
		NoticeFileDto noticeFileDto = new NoticeFileDto();
		  
		  noticeFileDto.setNoticeIdx(noticeVO.getNoticeIdx());
		  noticeFileDto.setNoticeFileMemberName(multipartFile.getOriginalFilename());
		  noticeFileDto.setNoticeFileType(multipartFile.getContentType());
		  noticeFileDto.setNoticeFileSize(multipartFile.getSize());
		  noticeFileDao.save(noticeFileDto, multipartFile);
		  
		 
		  }*/
		
		
	}
	
	

}
