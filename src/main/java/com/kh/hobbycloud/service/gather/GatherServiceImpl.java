package com.kh.hobbycloud.service.gather;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.kh.hobbycloud.entity.gather.GatherDto;
import com.kh.hobbycloud.entity.gather.GatherFileDto;
import com.kh.hobbycloud.repository.gather.GatherDao;
import com.kh.hobbycloud.repository.gather.GatherFileDao;
import com.kh.hobbycloud.vo.gather.GatherFileVO;

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
		List<MultipartFile> attach = gatherFileVO.getAttach();
		
		GatherFileDto gatherFileDto = new GatherFileDto();
		for (MultipartFile file : attach) {
			if (!file.isEmpty()) {
				gatherFileDto.setGatherIdx(gatherIdx);
				gatherFileDto.setGatherFileUserName(file.getOriginalFilename());
				gatherFileDto.setGatherFileType(file.getContentType());
				gatherFileDto.setGatherFileSize(file.getSize());
				gatherFileDao.save(gatherFileDto, file);	
			}
			
		}
		return gatherIdx;
	}
}
