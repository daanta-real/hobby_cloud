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
		gatherDao.insert(gatherDto);
		

		// 파일 선택시
		MultipartFile multipartFile = gatherFileVO.getAttach();
		if (!multipartFile.isEmpty()) {				
			GatherFileDto gatherFileDto = new GatherFileDto();
			gatherFileDto.setGatherIdx(gatherIdx);
			gatherFileDto.setGatherFileUserName(multipartFile.getOriginalFilename());
			gatherFileDto.setGatherFileType(multipartFile.getContentType());
			gatherFileDto.setGatherFileSize(multipartFile.getSize());
			
			gatherFileDao.save(gatherFileDto, multipartFile);
		}
			return gatherIdx;
		}

	}


