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
import com.kh.hobbycloud.vo.gather.Criteria;
import com.kh.hobbycloud.vo.notice.NoticeEditVO;
import com.kh.hobbycloud.vo.notice.NoticeFileVO;
import com.kh.hobbycloud.vo.notice.NoticeVO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class NoticeServiceImpl implements NoticeService {

	@Autowired
	private NoticeDao noticeDao;

	@Autowired
	private NoticeFileDao noticeFileDao;
	
	

	@Override
	public int save(NoticeFileVO noticeFileVO) throws IllegalStateException, IOException {
		// 1. 모임글 등록
		log.debug("=============================noticeService.save 실행");

		// 모임글 DTO 설정
		NoticeDto noticeDto = new NoticeDto();
		int noticeIdx = noticeDao.getsequences();
		noticeDto.setNoticeIdx(noticeIdx);
		noticeDto.setMemberIdx(noticeFileVO.getMemberIdx());
		noticeDto.setNoticeName(noticeFileVO.getNoticeName());
		noticeDto.setNoticeDetail(noticeFileVO.getNoticeDetail());
		// noticeDto.setnoticeRegistered(noticeFileVO.getnoticeRegistered());

		// notice DTO를 테이블에 삽입
		log.debug("=============================noticeService.save - noticeDao.insert() 불러오기 실행. DTO = {}", noticeDto);
		noticeDao.insert(noticeDto);
		log.debug("=============================noticeService.save - noticeDao.insert() 불러오기 실행 완료.");

		// 2. 모임글 파일 저장
		// 실제 파일 업로드 시도 → 성공 시 파일정보를 DB에 저장
		log.debug("=============================모임글 파일 저장 실행");
		List<MultipartFile> attach = noticeFileVO.getAttach();
		log.debug("=============================attach 정의: {}", attach);
		// attach가 하나도 안 넘어왔다면, 아무 처리도 하지 않고 넘긴다.
		// (때문에 기존 첨부파일을 삭제하고 싶다면 글 수정 페이지에서 파일을 하나하나 눌러 삭제해야 한다.
		if (attach == null) {
			log.debug("파일 정보를 담고 있는 List<MultipartFile> attach이 비었습니다. 진짜인가 한번 보세요. attach 정보 = {}", attach);
		}
		// 만약에 impl로 넘어온 attach가 존재한다면, 모든 파일을 업로드 처리한다.
		else {
			int count = 1;
			for (MultipartFile file : attach) {
				log.debug("=============================모임글 파일 저장 {}번", count++);

				// 우선 각 파일 비어있는지 확인. 파일이 비어있으면 이 파일 처리 생략
				if (file.isEmpty())
					continue;

				// 파일 정보에 대한 DTO 생성
				NoticeFileDto noticeFileDto = new NoticeFileDto();
				noticeFileDto.setNoticeIdx(noticeIdx);
				noticeFileDto.setNoticeFileMemberName(file.getOriginalFilename());
				noticeFileDto.setNoticeFileType(file.getContentType());
				noticeFileDto.setNoticeFileSize(file.getSize());
				// 파일 업로드 후, 파일정보를 DB에 저장
				noticeFileDao.save(noticeFileDto, file);

			}
		}
		// 3. 모임글 번호를 회신
		log.debug("=============================공지사항 파일 저장 완젼히 끝");
		return noticeIdx;
	}

	@Override
	public int listCount() {

		return noticeDao.listCount();
	}

	@Override
	public List<NoticeVO> list(Criteria cri) {

		return noticeDao.list(cri);
	}

	@Override
	public void edit(NoticeEditVO noticeEditVO) throws IllegalStateException, IOException {
		// 1. 모임글 수정

		// 모임글 DTO 설정
		NoticeVO noticeVO = new NoticeVO();

		noticeVO.setNoticeIdx(noticeEditVO.getNoticeIdx());
		noticeVO.setMemberIdx(noticeEditVO.getMemberIdx());
		noticeVO.setNoticeName(noticeEditVO.getNoticeName());
		noticeVO.setNoticeDetail(noticeEditVO.getNoticeDetail());
		noticeVO.setNoticeRegistered(noticeEditVO.getNoticeRegistered());
		

		// Notice DTO를 테이블에 삽입
		boolean isSucecess = noticeDao.edit(noticeVO);
		log.debug("======================== noticeDao.update() 실시 완료. 결과 = {}", isSucecess);

		List<String> fileRemoveList = noticeEditVO.getFileDelTargetList();
		log.debug("  ㄴ 삭제요청된 파일 리스트: {}", fileRemoveList);
		if (fileRemoveList != null && fileRemoveList.size() > 0) {
			log.debug("==== 삭제할 파일 리스트가 있으므로 이에 대해 삭제 작업합니다.");
			noticeFileDao.deleteList(noticeEditVO.getNoticeIdx(), fileRemoveList);
		}

		log.debug("======================== 2. 추가된 첨부파일을 저장합니다.");
		// (선택) 강좌 파일을 파일 테이블과 실제 하드디스크에 저장
		List<MultipartFile> attach = noticeEditVO.getAttach();
		// attach가 하나도 안 넘어왔다면, 아무 처리도 하지 않고 넘긴다.
		// (때문에 기존 첨부파일을 삭제하고 싶다면 글 수정 페이지에서 파일을 하나하나 눌러 삭제해야 한다.
		if (attach == null) {
			log.debug("파일 정보를 담고 있는 List<MultipartFile> attach이 비었습니다. 진짜인가 한번 보세요. attach 정보 = {}", attach);
		}
		// 만약에 impl로 넘어온 attach가 존재한다면, 모든 파일을 업로드 처리한다.
		else {
			log.debug("파일 정보를 담고 있는 List<MultipartFile> attach가 존재합니다. 파일을 업로드하겠습니다.");
			int i = 1;
			for (MultipartFile file : attach) {

				log.debug("{}번째 파일: {}", i, file);

				// 우선 각 파일 비어있는지 확인.
				if (file.isEmpty()) {
					// 파일이 비어있으면 이 파일 처리 생략
					log.debug("  ㄴ 파일이 비었습니다. 다음으로 넘어가겠습니다.");
					continue;
				} else {
					// 파일이 비어있지 않는다면, 이 파일을 업로드하고 DB에 등록한다.
					log.debug("  ㄴ 파일이 존재합니다. 업로드하고 DB에 등록하겠습니다.");

					// 파일 정보에 대한 DTO 생성
					NoticeFileDto noticeFileDto = new NoticeFileDto();
					noticeFileDto.setNoticeIdx(noticeEditVO.getNoticeIdx());
					noticeFileDto.setNoticeFileMemberName(file.getOriginalFilename());
					noticeFileDto.setNoticeFileType(file.getContentType());
					noticeFileDto.setNoticeFileSize(file.getSize());
					log.debug("  ㄴ 완성된 파일 정보: {}", noticeFileDto);

					// 파일 업로드 후, 파일정보를 DB에 저장
					noticeFileDao.save(noticeFileDto, file);
					log.debug("  ㄴ 파일을 업로드하고 그 정보를 DB에 등록하였습니다.");

				}
			}
		}

	}

}
