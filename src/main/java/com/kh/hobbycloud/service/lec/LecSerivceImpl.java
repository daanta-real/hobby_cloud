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
import com.kh.hobbycloud.vo.lec.LecEditVO;
import com.kh.hobbycloud.vo.lec.LecLikeVO;
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
		//= MemberJoinVO에서 정보를 뽑아서 MemberDto를 생성
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
		//(필수) 회원정보를 뽑아서 회원테이블에 저장
		//= MemberJoinVO에서 정보를 뽑아서 MemberDto를 생성
		int lecIdx = lecDao.getSequence();
		LecDto lecDto = new LecDto();
		lecDto.setLecIdx(lecIdx);
		lecDto.setTutorIdx(1);
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
		
		lecDao.register(lecDto);
		
		//(선택) 강사 파일을 파일 테이블과 실제 하드디스크에 저장
		List<MultipartFile> attach = lecEditVO.getAttach();
		if(attach==null) {
			System.out.println("이거파일널이니까 지우기" + attach);
			lecFileDao.delete(lecEditVO.getLecIdx());
		}
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
	public void likeUpdate(LecLikeVO lecLikeVO) {
		lecLikeDao.likeUpdate(lecLikeVO);
	}
}
