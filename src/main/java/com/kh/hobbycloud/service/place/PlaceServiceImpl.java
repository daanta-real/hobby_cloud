package com.kh.hobbycloud.service.place;

import java.io.IOException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.kh.hobbycloud.entity.place.PlaceDto;
import com.kh.hobbycloud.entity.place.PlaceFileDto;
import com.kh.hobbycloud.repository.place.PlaceDao;
import com.kh.hobbycloud.repository.place.PlaceFileDao;
import com.kh.hobbycloud.vo.place.PlaceFileVO;

@Service
public class PlaceServiceImpl implements PlaceService{
	
	@Autowired
	private PlaceDao placeDao;
	
	@Autowired
	private PlaceFileDao placeFileDao;
	

	@Override
	public int save(PlaceFileVO placeFileVO) throws IllegalStateException, IOException {

		// 1. 장소 등록

		// 장소 DTO 설정
		PlaceDto placeDto = new PlaceDto();
		int placeIdx = placeDao.getSequence();
		placeDto.setPlaceIdx(placeIdx);
		placeDto.setMemberIdx(placeFileVO.getMemberIdx());
		placeDto.setPlaceName(placeFileVO.getPlaceName());
		placeDto.setPlaceDetail(placeFileVO.getPlaceDetail());
		placeDto.setPlacePostcode(placeFileVO.getPlacePostcode());
		placeDto.setPlaceAddress(placeFileVO.getPlaceAddress());
		placeDto.setPlaceDetailAddress(placeFileVO.getPlaceDetailAddress());
		placeDto.setPlaceStart(placeFileVO.getPlaceStart());
		placeDto.setPlaceEnd(placeFileVO.getPlaceEnd());
		placeDto.setPlaceMin(placeFileVO.getPlaceMin());
		placeDto.setPlaceMax(placeFileVO.getPlaceMax());
		placeDto.setPlaceEmail(placeFileVO.getPlaceEmail());
		placeDto.setPlacePhone(placeFileVO.getPlacePhone());


		// place DTO를 테이블에 삽입
		placeDao.insert(placeDto);
		// 2. 장소 사진 저장
		// 실제 파일 업로드 시도 → 성공 시 파일정보를 DB에 저장
		List<MultipartFile> attach = placeFileVO.getAttach();
			for (MultipartFile file : attach) {
			// 우선 각 파일 비어있는지 확인. 파일이 비어있으면 이 파일 처리 생략
				if (file.isEmpty())
				continue;

			// 파일 정보에 대한 DTO 생성
			PlaceFileDto placeFileDto = new PlaceFileDto();
			placeFileDto.setPlaceIdx(placeIdx);
			placeFileDto.setPlaceFileUserName(file.getOriginalFilename());
			placeFileDto.setPlaceFileType(file.getContentType());
			placeFileDto.setPlaceFileSize(file.getSize());
			// 파일 업로드 후, 파일정보를 DB에 저장
			placeFileDao.save(placeFileDto, file);
			
			}
		// 3. 모임글 번호를 회신
		return placeIdx;
}

	@Override
	public void update(PlaceFileVO placeFileVO) throws IllegalStateException, IOException {
		// 1. 장소 수정

		// 장소 DTO 설정
		PlaceDto placeDto = new PlaceDto();
		
		placeDto.setPlaceIdx(placeFileVO.getPlaceIdx());
		placeDto.setMemberIdx(placeFileVO.getMemberIdx());
		placeDto.setPlaceName(placeFileVO.getPlaceName());
		placeDto.setPlaceDetail(placeFileVO.getPlaceDetail());
		placeDto.setPlacePostcode(placeFileVO.getPlacePostcode());
		placeDto.setPlaceAddress(placeFileVO.getPlaceAddress());
		placeDto.setPlaceDetailAddress(placeFileVO.getPlaceDetailAddress());
		placeDto.setPlaceStart(placeFileVO.getPlaceStart());
		placeDto.setPlaceEnd(placeFileVO.getPlaceEnd());
		placeDto.setPlaceMin(placeFileVO.getPlaceMin());
		placeDto.setPlaceMax(placeFileVO.getPlaceMax());
		placeDto.setPlaceEmail(placeFileVO.getPlaceEmail());
		placeDto.setPlacePhone(placeFileVO.getPlacePhone());

		// place DTO를 테이블에 삽입
		placeDao.update(placeDto);
		
		List<MultipartFile> attach = placeFileVO.getAttach();
		if(attach==null) {
			placeFileDao.delete(placeFileVO.getPlaceIdx());
		}
			for (MultipartFile file : attach) {
			// 우선 각 파일 비어있는지 확인. 파일이 비어있으면 이 파일 처리 생략
				if (file.isEmpty())
				continue;

			// 파일 정보에 대한 DTO 생성
			PlaceFileDto placeFileDto = new PlaceFileDto();
			placeFileDto.setPlaceIdx(placeFileVO.getPlaceIdx());
			placeFileDto.setPlaceFileUserName(file.getOriginalFilename());
			placeFileDto.setPlaceFileType(file.getContentType());
			placeFileDto.setPlaceFileSize(file.getSize());
			// 파일 업로드 후, 파일정보를 DB에 저장
			placeFileDao.save(placeFileDto, file);
			}
	}
}
