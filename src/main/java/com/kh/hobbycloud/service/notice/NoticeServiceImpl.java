package com.kh.hobbycloud.service.notice;

import java.io.IOException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.kh.hobbycloud.entity.gather.GatherFileDto;
import com.kh.hobbycloud.entity.notice.NoticeDto;
import com.kh.hobbycloud.entity.notice.NoticeFileDto;
import com.kh.hobbycloud.repository.notice.NoticeDao;
import com.kh.hobbycloud.repository.notice.NoticeFileDao;
import com.kh.hobbycloud.vo.notice.NoticeVO;

@Service
public class NoticeServiceImpl implements NoticeService {

	@Autowired
	private NoticeDao noticeDao;

	@Autowired
	private NoticeFileDao noticeFileDao;

	@Override
	public void save(NoticeVO noticeVO) throws IllegalStateException, IOException {
		NoticeDto noticeDto = new NoticeDto();

		noticeDto.setNoticeIdx(noticeVO.getNoticeIdx());

		noticeDto.setMemberIdx(noticeVO.getMemberIdx());
		noticeDto.setNoticeName(noticeVO.getNoticeName());
		noticeDto.setNoticeDetail(noticeVO.getNoticeDetail());
		noticeDto.setNoticeRegistered(noticeVO.getNoticeRegistered());
		noticeDto.setNoticeReplies(noticeVO.getNoticeReplies());
		noticeDto.setNoticeView(noticeVO.getNoticeViews());
		noticeDao.insert(noticeDto);
		noticeDao.edit(noticeVO);
		// 실제 파일 업로드 시도 → 성공 시 파일정보를 DB에 저장
		List<MultipartFile> attach = noticeVO.getAttach();
		for (MultipartFile file : attach) {

			// 우선 각 파일 비어있는지 확인. 파일이 비어있으면 이 파일 처리 생략
			if (file.isEmpty())
				continue;

			// 파일 정보에 대한 DTO 생성
			NoticeFileDto noticeFileDto = new NoticeFileDto();
			noticeFileDto.setNoticeIdx(noticeVO.getNoticeIdx());
			noticeFileDto.setNoticeFileMemberName(file.getOriginalFilename());
			noticeFileDto.setNoticeFileType(file.getContentType());
			noticeFileDto.setNoticeFileSize(file.getSize());
			// 파일 업로드 후, 파일정보를 DB에 저장
			noticeFileDao.save(noticeFileDto, file);

		}

		// 3. 모임글 번호를 회신

	}
}
