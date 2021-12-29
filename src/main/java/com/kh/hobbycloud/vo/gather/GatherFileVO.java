package com.kh.hobbycloud.vo.gather;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

@Data
public class GatherFileVO {
	//소모임 게시판에 파일저장을 위한 VO
	private int gatherIdx ,memberIdx, placeIdx, gatherHeadCount, 
	gatherLocLatitude, gatherLocLogitude, gatherMax, gatherStaus;
	private String lecCategoryName, gatherName, gatherDetail, gatherLocRegion;
	private String gatherRegistered, gatherStart,gatherEnd;
	//private MultipartFile[] attach;
	private List<MultipartFile> attach;
}
