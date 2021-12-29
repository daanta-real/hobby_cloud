package com.kh.hobbycloud.service.gather;

import java.io.IOException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.kh.hobbycloud.entity.gather.GatherDto;
import com.kh.hobbycloud.entity.gather.GatherFileDto;
import com.kh.hobbycloud.repository.gather.GatherDao;
import com.kh.hobbycloud.repository.gather.GatherFileDao;
import com.kh.hobbycloud.vo.gather.GatherFileVO;

@Service
public class GatherServiceImpl implements GatherService {

	@Autowired
	private GatherDao gatherDao;

	@Autowired
	private GatherFileDao gatherFileDao;

	@Override
	public int save(GatherFileVO gatherFileVO) throws IllegalStateException, IOException {



		// 1. 모임글 등록

		// 모임글 DTO 설정
		GatherDto gatherDto = new GatherDto();
		int gatherIdx = gatherDao.getSequence();
		gatherDto.setGatherIdx(gatherIdx);
		gatherDto.setMemberIdx(gatherFileVO.getMemberIdx());
		gatherDto.setLecCategoryName(gatherFileVO.getLecCategoryName());
		gatherDto.setPlaceIdx(gatherFileVO.getPlaceIdx());
		gatherDto.setGatherName(gatherFileVO.getGatherName());
		gatherDto.setGatherDetail(gatherFileVO.getGatherDetail());
		gatherDto.setGatherRegistered(gatherFileVO.getGatherRegistered());
		gatherDto.setGatherHeadCount(gatherFileVO.getGatherHeadCount());
		gatherDto.setGatherLocRegion(gatherFileVO.getGatherLocRegion());
		gatherDto.setGatherLocLatitude(gatherFileVO.getGatherLocLatitude());
		gatherDto.setGatherLocLogitude(gatherFileVO.getGatherLocLogitude());
		gatherDto.setGatherStart(gatherFileVO.getGatherStart());
		gatherDto.setGatherEnd(gatherFileVO.getGatherEnd());
		gatherDto.setGatherMax(gatherFileVO.getGatherMax());
		gatherDto.setGatherStaus(gatherFileVO.getGatherMax());

		// Gather DTO를 테이블에 삽입
		gatherDao.insert(gatherDto);



		// 2. 모임글 파일 저장
		// 실제 파일 업로드 시도 → 성공 시 파일정보를 DB에 저장
		MultipartFile[] files = gatherFileVO.getAttach();
		for(MultipartFile file: files) {

			// 우선 각 파일 비어있는지 확인. 파일이 비어있으면 이 파일 처리 생략
			if(file.isEmpty()) continue;

			// 파일 정보에 대한 DTO 생성
			GatherFileDto gatherFileDto = new GatherFileDto();
			gatherFileDto.setGatherIdx(gatherIdx);
			gatherFileDto.setGatherFileUserName(file.getOriginalFilename());
			gatherFileDto.setGatherFileType(file.getContentType());
			gatherFileDto.setGatherFileSize(file.getSize());
			// 파일 업로드 후, 파일정보를 DB에 저장
			gatherFileDao.save(gatherFileDto, file);

		}



		// 3. 모임글 번호를 회신
		return gatherIdx;

	}

}

