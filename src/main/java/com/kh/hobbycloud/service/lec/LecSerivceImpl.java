package com.kh.hobbycloud.service.lec;


import java.io.IOException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.kh.hobbycloud.entity.lec.LecDto;
import com.kh.hobbycloud.entity.lec.LecFileDto;
import com.kh.hobbycloud.repository.lec.LecDao;
import com.kh.hobbycloud.repository.lec.LecFileDao;
import com.kh.hobbycloud.vo.lec.LecRegisterVO;

@Service
public class LecSerivceImpl implements LecService{

	@Autowired
	private LecDao lecDao;
	
	@Autowired
	private LecFileDao lecFileDao;
	
	@Override
	public void register(LecRegisterVO lecRegisterVO) throws IllegalStateException, IOException {
		//(필수) 회원정보를 뽑아서 회원테이블에 저장
		//= MemberJoinVO에서 정보를 뽑아서 MemberDto를 생성
		LecDto lecDto = new LecDto();
		lecDto.setLecIdx(lecRegisterVO.getLecIdx());
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
		MultipartFile multipartFile = lecRegisterVO.getAttach();
		if(!multipartFile.isEmpty()) {//파일이 있으면
			LecFileDto lecFileDto = new LecFileDto();
			lecFileDto.setLecIdx(lecRegisterVO.getLecIdx());
			lecFileDto.setLecFileUserName(multipartFile.getOriginalFilename());
			lecFileDto.setLecFileType(multipartFile.getContentType());
			lecFileDto.setLecFileSize(multipartFile.getSize());
			lecFileDao.save(lecFileDto, multipartFile);
		}
	}
}
