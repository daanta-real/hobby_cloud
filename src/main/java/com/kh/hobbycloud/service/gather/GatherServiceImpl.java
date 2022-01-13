package com.kh.hobbycloud.service.gather;

import java.io.IOException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.kh.hobbycloud.entity.gather.GatherDto;
import com.kh.hobbycloud.entity.gather.GatherFileDto;
import com.kh.hobbycloud.repository.gather.GatherDao;
import com.kh.hobbycloud.repository.gather.GatherFileDao;
import com.kh.hobbycloud.vo.gather.Criteria;
import com.kh.hobbycloud.vo.gather.CriteriaSearch;
import com.kh.hobbycloud.vo.gather.GatherFileVO;
import com.kh.hobbycloud.vo.gather.GatherSearchVO;
import com.kh.hobbycloud.vo.gather.GatherVO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class GatherServiceImpl implements GatherService {

	@Autowired
	private GatherDao gatherDao;

	@Autowired
	private GatherFileDao gatherFileDao;

	@Override
	public int save(GatherFileVO gatherFileVO) throws IllegalStateException, IOException {

		// 1. 모임글 등록
		log.debug("=============================gatherService.save 실행");

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
		gatherDto.setGatherLocLongitude(gatherFileVO.getGatherLocLongitude());
		gatherDto.setGatherStart(gatherFileVO.getGatherStart());
		gatherDto.setGatherEnd(gatherFileVO.getGatherEnd());
		gatherDto.setGatherMax(gatherFileVO.getGatherMax());
		gatherDto.setGatherStaus(gatherFileVO.getGatherMax());

		// Gather DTO를 테이블에 삽입
		log.debug("=============================gatherService.save - gatherDao.insert() 불러오기 실행. DTO = {}", gatherDto);
		gatherDao.insert(gatherDto);
		log.debug("=============================gatherService.save - gatherDao.insert() 불러오기 실행 완료.");

		// 2. 모임글 파일 저장
		// 실제 파일 업로드 시도 → 성공 시 파일정보를 DB에 저장
		log.debug("=============================모임글 파일 저장 실행");
		List<MultipartFile> attach = gatherFileVO.getAttach();
		log.debug("=============================attach 정의: {}", attach);
		int count = 1;
		for (MultipartFile file : attach) {
			log.debug("=============================모임글 파일 저장 {}번", count++);

			// 우선 각 파일 비어있는지 확인. 파일이 비어있으면 이 파일 처리 생략
			if (file.isEmpty())
				continue;

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
		log.debug("=============================모임글 파일 저장 완젼히 끝");
		return gatherIdx;
	}

	@Override
	public void update(GatherFileVO gatherFileVO) throws IllegalStateException, IOException {
		// 1. 모임글 수정

		// 모임글 DTO 설정
		GatherDto gatherDto = new GatherDto();

		gatherDto.setGatherIdx(gatherFileVO.getGatherIdx());
		gatherDto.setMemberIdx(gatherFileVO.getMemberIdx());
		gatherDto.setLecCategoryName(gatherFileVO.getLecCategoryName());
		gatherDto.setPlaceIdx(gatherFileVO.getPlaceIdx());
		gatherDto.setGatherName(gatherFileVO.getGatherName());
		gatherDto.setGatherDetail(gatherFileVO.getGatherDetail());
		gatherDto.setGatherRegistered(gatherFileVO.getGatherRegistered());
		gatherDto.setGatherHeadCount(gatherFileVO.getGatherHeadCount());
		gatherDto.setGatherLocRegion(gatherFileVO.getGatherLocRegion());
		gatherDto.setGatherLocLatitude(gatherFileVO.getGatherLocLatitude());
		gatherDto.setGatherLocLongitude(gatherFileVO.getGatherLocLongitude());
		gatherDto.setGatherStart(gatherFileVO.getGatherStart());
		gatherDto.setGatherEnd(gatherFileVO.getGatherEnd());
		gatherDto.setGatherMax(gatherFileVO.getGatherMax());
		gatherDto.setGatherStaus(gatherFileVO.getGatherMax());

		// Gather DTO를 테이블에 삽입
		gatherDao.update(gatherDto);

		List<MultipartFile> attach = gatherFileVO.getAttach();
		if(attach==null) {
			System.out.println("헬로우헬로우"+attach);
			gatherFileDao.delete(gatherFileVO.getGatherIdx());
		}
		for (MultipartFile file : attach) {

			// 우선 각 파일 비어있는지 확인. 파일이 비어있으면 이 파일 처리 생략
			if (file.isEmpty())
				continue;

			// 파일 정보에 대한 DTO 생성
			GatherFileDto gatherFileDto = new GatherFileDto();
			gatherFileDto.setGatherIdx(gatherFileVO.getGatherIdx());
			gatherFileDto.setGatherFileUserName(file.getOriginalFilename());
			gatherFileDto.setGatherFileType(file.getContentType());
			gatherFileDto.setGatherFileSize(file.getSize());
			// 파일 업로드 후, 파일정보를 DB에 저장
			gatherFileDao.save(gatherFileDto, file);

		}
	}

	@Override
	public List<GatherVO> list(Criteria cri) {
		return gatherDao.list(cri);
	}

	@Override
	public int listCount() {
		return gatherDao.listCount();
	}

	@Override
	public List<GatherVO> listBy(CriteriaSearch cri2) {
		System.out.println("서비스"+cri2);
		return gatherDao.listBy(cri2);
	}

	@Override
	public int listCountBy(GatherSearchVO gatherSearchVO) {
		int number = gatherDao.listCountBy(gatherSearchVO);
		System.out.println("서비스 숫자"+number);
		return gatherDao.listCountBy(gatherSearchVO);
	}


}
