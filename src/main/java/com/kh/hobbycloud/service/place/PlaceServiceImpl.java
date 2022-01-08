package com.kh.hobbycloud.service.place;

import java.io.IOException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.kh.hobbycloud.entity.place.PlaceDto;
import com.kh.hobbycloud.entity.place.PlaceFileDto;
import com.kh.hobbycloud.entity.place.PlaceTargetDto;
import com.kh.hobbycloud.repository.place.PlaceCategoryDao;
import com.kh.hobbycloud.repository.place.PlaceDao;
import com.kh.hobbycloud.repository.place.PlaceFileDao;
import com.kh.hobbycloud.vo.place.PlaceCriteria;
import com.kh.hobbycloud.vo.place.PlaceEditVO;
import com.kh.hobbycloud.vo.place.PlaceFileVO;
import com.kh.hobbycloud.vo.place.PlaceListVO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class PlaceServiceImpl implements PlaceService{
	
	@Autowired
	private PlaceDao placeDao;
	
	@Autowired
	private PlaceFileDao placeFileDao;
	
	@Autowired
	private PlaceCategoryDao placeCategoryDao;
	

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
		placeDto.setPlaceSido(placeFileVO.getPlaceSido());
		placeDto.setPlaceSigungu(placeFileVO.getPlaceSigungu());
		placeDto.setPlaceBname(placeFileVO.getPlaceBname());
		
		// place DTO를 테이블에 삽입
		placeDao.insert(placeDto);

		// 장소 카테고리 DTO 설정
		PlaceTargetDto placeTargetDto = new PlaceTargetDto();
		placeTargetDto.setPlaceIdx(placeIdx);
		placeTargetDto.setLecCategoryName(placeFileVO.getLecCategoryName());
		
		// 장소 카테고리 DTO를 테이블에 삽입
		placeCategoryDao.insert(placeTargetDto);
		
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
		// 3. 장소Idx를 회신
		return placeIdx;
}
	
	//장소 변경
	@Override
	public void update(PlaceEditVO placeEditVO) throws IllegalStateException, IOException {
		log.debug("======================== PlaceService.edit(placeEditVO)가 실행되었습니다.");
		// 장소 DTO 설정
		PlaceDto placeDto = new PlaceDto();
		
		placeDto.setPlaceIdx(placeEditVO.getPlaceIdx());
		placeDto.setMemberIdx(placeEditVO.getMemberIdx());
		placeDto.setPlaceName(placeEditVO.getPlaceName());
		placeDto.setPlaceDetail(placeEditVO.getPlaceDetail());
		placeDto.setPlaceRegistered(placeEditVO.getPlaceRegistered());
		placeDto.setPlacePostcode(placeEditVO.getPlacePostcode());
		placeDto.setPlaceAddress(placeEditVO.getPlaceAddress());
		placeDto.setPlaceDetailAddress(placeEditVO.getPlaceDetailAddress());
		placeDto.setPlaceStart(placeEditVO.getPlaceStart());
		placeDto.setPlaceEnd(placeEditVO.getPlaceEnd());
		placeDto.setPlaceMin(placeEditVO.getPlaceMin());
		placeDto.setPlaceMax(placeEditVO.getPlaceMax());
		placeDto.setPlaceEmail(placeEditVO.getPlaceEmail());
		placeDto.setPlacePhone(placeEditVO.getPlacePhone());
		placeDto.setPlaceSido(placeEditVO.getPlaceSido());
		placeDto.setPlaceSigungu(placeEditVO.getPlaceSigungu());
		placeDto.setPlaceBname(placeEditVO.getPlaceBname());
		
		log.debug("======================== PlaceService.update() 실시. DTO = {}", placeDto);
		// place DTO를 테이블에 삽입
		boolean isSucceed = placeDao.update(placeDto);
		log.debug("======================== PlaceService.update() 실시 완료. 결과 = {}", isSucceed);
		
		// 장소 카테고리 DTO 설정
		PlaceTargetDto placeTargetDto = new PlaceTargetDto();
		placeTargetDto.setPlaceIdx(placeEditVO.getPlaceIdx());
		placeTargetDto.setLecCategoryName(placeEditVO.getLecCategoryName());
		log.debug("======================== PlaceService.update() 실시. placeTargetDto = {}", placeTargetDto);
		
		// 장소 카테고리 DTO를 테이블에 삽입
		boolean isSucceedCt = placeCategoryDao.update(placeTargetDto);
		log.debug("======================== PlaceService.update() 실시 완료. 결과 = {}", isSucceedCt);
		
		// (선택) 파일삭제 idx 목록에 해당되는 첨부파일들을 place_file 테이블에서 삭제한다.
		List<String> placeFileDelTargetList = placeEditVO.getPlaceFileDelTargetList();
		log.debug("========삭제할 파일 리스트: {}", placeFileDelTargetList);
		if(placeFileDelTargetList != null && placeFileDelTargetList.size() > 0) {
			log.debug("==== 삭제할 파일 리스트가 있으므로 이에 대해 삭제 작업합니다.");
			placeFileDao.deleteList(placeEditVO.getPlaceIdx(), placeEditVO.getPlaceFileDelTargetList());
		}
		
		// (선택) 장소 파일을 파일 테이블과 실제 하드디스크에 저장
				List<MultipartFile> attach = placeEditVO.getAttach();
		// 만약에 attach가 아예 안 넘어왔다면, 이 강좌와 관련된 모든 파일을 지운다
				if(attach==null) {
					log.debug("파일 정보를 담고 있는 List<MultipartFile> attach이 비었습니다. attach 정보 = {}", attach);
					placeFileDao.delete(placeEditVO.getPlaceIdx());
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
							PlaceFileDto placeFileDto = new PlaceFileDto();
							placeFileDto.setPlaceIdx(placeEditVO.getPlaceIdx());
							placeFileDto.setPlaceFileUserName(file.getOriginalFilename());
							placeFileDto.setPlaceFileType(file.getContentType());
							placeFileDto.setPlaceFileSize(file.getSize());
							log.debug("  ㄴ 완성된 파일 정보: {}", placeFileDto);
							// 파일 업로드 후, 파일정보를 DB에 저장
							placeFileDao.save(placeFileDto, file);
							log.debug("  ㄴ 파일을 업로드하고 그 정보를 DB에 등록하였습니다.");
						}
					}
				}
			}

	@Override
	public List<PlaceListVO> list(PlaceCriteria cri) {
		return placeDao.list(cri);
	}

	@Override
	public int listCount() {
		return placeDao.listCount();
	}
}
