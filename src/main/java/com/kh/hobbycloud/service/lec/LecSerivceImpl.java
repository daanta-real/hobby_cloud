package com.kh.hobbycloud.service.lec;


import java.io.IOException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.kh.hobbycloud.entity.lec.LecDto;
import com.kh.hobbycloud.entity.lec.LecFileDto;
import com.kh.hobbycloud.repository.lec.LecDao;
import com.kh.hobbycloud.repository.lec.LecFileDao;
import com.kh.hobbycloud.repository.lec.LecLikeDao;
import com.kh.hobbycloud.vo.lec.LecCriteria;
import com.kh.hobbycloud.vo.lec.LecEditVO;
import com.kh.hobbycloud.vo.lec.LecLikeVO;
import com.kh.hobbycloud.vo.lec.LecListVO;
import com.kh.hobbycloud.vo.lec.LecRegisterVO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class LecSerivceImpl implements LecService{

	@Autowired
	private LecDao lecDao;

	@Autowired
	private LecFileDao lecFileDao;

	@Autowired
	private LecLikeDao lecLikeDao;

	@Override
	public int register(LecRegisterVO lecRegisterVO) throws IllegalStateException, IOException {

		//(필수) 회원정보를 뽑아서 회원테이블에 저장
		//= LecRegisterVO에서 정보를 뽑아서 LecDto를 생성
		int lecIdx = lecDao.getSequence();
		LecDto lecDto = new LecDto();
		lecDto.setLecIdx(lecIdx);
		lecDto.setTutorIdx(1);
		lecDto.setLecCategoryName(lecRegisterVO.getLecCategoryName());
		lecDto.setPlaceIdx(lecRegisterVO.getPlaceIdx());//보류
		lecDto.setLecName(lecRegisterVO.getLecName());
		lecDto.setLecDetail(lecRegisterVO.getLecDetail());
		lecDto.setLecPrice(lecRegisterVO.getLecPrice());
		lecDto.setLecHeadCount(lecRegisterVO.getLecHeadCount());
		lecDto.setLecContainsCount(lecRegisterVO.getLecContainsCount());
		lecDto.setLecStart(lecRegisterVO.getLecStart());
		lecDto.setLecEnd(lecRegisterVO.getLecEnd());
		lecDto.setLecLocRegion(lecRegisterVO.getLecLocRegion());
		lecDto.setLecLocLatitude(lecRegisterVO.getLecLocLatitude());
		lecDto.setLecLocLongitude(lecRegisterVO.getLecLocLongitude());
		lecDao.register(lecDto);

		//(선택) 강사 파일을 파일 테이블과 실제 하드디스크에 저장
		List<MultipartFile> attach = lecRegisterVO.getAttach();
		for(MultipartFile file: attach) {

			// 우선 각 파일 비어있는지 확인. 파일이 비어있으면 이 파일 처리 생략
			if(file.isEmpty()) continue;

			// 파일 정보에 대한 DTO 생성
			LecFileDto lecFileDto = new LecFileDto();
			lecFileDto.setLecIdx(lecIdx);
			lecFileDto.setLecFileUserName(file.getOriginalFilename());
			lecFileDto.setLecFileType(file.getContentType());
			lecFileDto.setLecFileSize(file.getSize());
			// 파일 업로드 후, 파일정보를 DB에 저장
			lecFileDao.save(lecFileDto, file);

		}

		return lecIdx;
	}

	@Override
	public void edit(LecEditVO lecEditVO) throws IllegalStateException, IOException {

		log.debug("======================== LecService.edit(lecEditVO)가 실행되었습니다.");

		log.debug("======================== 1. 변경된 강의글을 저장합니다.");
		//(필수) 회원정보를 뽑아서 회원테이블에 저장
		//= MemberJoinVO에서 정보를 뽑아서 MemberDto를 생성
		LecDto lecDto = new LecDto();
		lecDto.setLecIdx(lecEditVO.getLecIdx()); // 편집이므로 시퀀스를 뽑으면 안 된다.
		// 강사 변경 가능하게 할지 안 할지 고민해봐야 한다.
		// 물론 변경 가능하게 할 경우, 강사 스스로는 강사정보를 못 바꾸고
		// 관리자만 수정 가능하게 처리해야 한다.
		// lecDto.setTutorIdx(1);
		lecDto.setLecCategoryName(lecEditVO.getLecCategoryName());
		lecDto.setPlaceIdx(lecEditVO.getPlaceIdx());//보류
		lecDto.setLecName(lecEditVO.getLecName());
		lecDto.setLecDetail(lecEditVO.getLecDetail());
		lecDto.setLecPrice(lecEditVO.getLecPrice());
		lecDto.setLecHeadCount(lecEditVO.getLecHeadCount());
		lecDto.setLecContainsCount(lecEditVO.getLecContainsCount());
		lecDto.setLecStart(lecEditVO.getLecStart());
		lecDto.setLecEnd(lecEditVO.getLecEnd());
		lecDto.setLecLocRegion(lecEditVO.getLecLocRegion());
		lecDto.setLecLocLatitude(lecEditVO.getLecLocLatitude());
		lecDto.setLecLocLongitude(lecEditVO.getLecLocLongitude());
		log.debug("======================== lecDao.update() 실시. DTO = {}", lecDto);
		boolean isSucceed = lecDao.update(lecDto);
		log.debug("======================== lecDao.update() 실시 완료. 결과 = {}", isSucceed);

		// (선택) 파일삭제 idx 목록에 해당되는 첨부파일들을 lec_file 테이블에서 삭제한다.
		log.debug("======================== 2. 삭제요청한 첨부자료를 삭제합니다.");
		List<String> fileRemoveList = lecEditVO.getLecFileDelTargetList();
		log.debug("  ㄴ 삭제요청된 파일 리스트: {}", fileRemoveList);
		if(fileRemoveList != null && fileRemoveList.size() > 0) {
			log.debug("==== 삭제할 파일 리스트가 있으므로 이에 대해 삭제 작업합니다.");
			lecFileDao.deleteList(lecEditVO.getLecIdx(), fileRemoveList);
		}

		log.debug("======================== 2. 추가된 첨부파일을 저장합니다.");
		// (선택) 강좌 파일을 파일 테이블과 실제 하드디스크에 저장
		List<MultipartFile> attach = lecEditVO.getAttach();
		// attach가 하나도 안 넘어왔다면, 아무 처리도 하지 않고 넘긴다.
		// (때문에 기존 첨부파일을 삭제하고 싶다면 글 수정 페이지에서 파일을 하나하나 눌러 삭제해야 한다.
		if(attach==null) {
			log.debug("파일 정보를 담고 있는 List<MultipartFile> attach이 비었습니다. 진짜인가 한번 보세요. attach 정보 = {}", attach);
		}
		// 만약에 impl로 넘어온 attach가 존재한다면, 모든 파일을 업로드 처리한다.
		else {
			log.debug("파일 정보를 담고 있는 List<MultipartFile> attach가 존재합니다. 파일을 업로드하겠습니다.");
			int i = 1;
			for(MultipartFile file: attach) {

				log.debug("{}번째 파일: {}", i, file);

				// 우선 각 파일 비어있는지 확인.
				if(file.isEmpty()) {
					// 파일이 비어있으면 이 파일 처리 생략
					log.debug("  ㄴ 파일이 비었습니다. 다음으로 넘어가겠습니다.");
					continue;
				} else {
					// 파일이 비어있지 않는다면, 이 파일을 업로드하고 DB에 등록한다.
					log.debug("  ㄴ 파일이 존재합니다. 업로드하고 DB에 등록하겠습니다.");

					// 파일 정보에 대한 DTO 생성
					LecFileDto lecFileDto = new LecFileDto();
					lecFileDto.setLecIdx(lecEditVO.getLecIdx());
					lecFileDto.setLecFileUserName(file.getOriginalFilename());
					lecFileDto.setLecFileType(file.getContentType());
					lecFileDto.setLecFileSize(file.getSize());
					log.debug("  ㄴ 완성된 파일 정보: {}", lecFileDto);

					// 파일 업로드 후, 파일정보를 DB에 저장
					lecFileDao.save(lecFileDto, file);
					log.debug("  ㄴ 파일을 업로드하고 그 정보를 DB에 등록하였습니다.");

				}
			}
		}

	}

	//좋아요
	@Override
	public int likeCount(LecLikeVO lecLikeVO) {
		return lecLikeDao.likeCount(lecLikeVO);
	}

	@Override
	public int likeGetInfo(LecLikeVO lecLikeVO) {
		return lecLikeDao.likeGetInfo(lecLikeVO);
	}

	@Override
	public void likeInsert(LecLikeVO lecLikeVO) {
		lecLikeDao.likeInsert(lecLikeVO);
	}

	@Override
	public int likeUpdate(LecLikeVO lecLikeVO) {
		lecLikeDao.likeUpdate(lecLikeVO);
		return lecLikeVO.getAllIsLike();
	}

	@Override
	public int likeCountEvery(int lecIdx) {
		return lecLikeDao.likeCountEvery(lecIdx);
	}

	@Override
	public List<LecListVO> list(LecCriteria cri) {
		return lecDao.list(cri);
	}

	@Override
	public int listCount() {
		return lecDao.listCount();
	}
}
