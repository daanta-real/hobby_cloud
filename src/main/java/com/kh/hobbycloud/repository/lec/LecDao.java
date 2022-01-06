package com.kh.hobbycloud.repository.lec;

import java.util.List;
import java.util.Map;

import com.kh.hobbycloud.entity.lec.LecDto;
import com.kh.hobbycloud.vo.gather.GatherVO;
import com.kh.hobbycloud.vo.lec.LecCriteria;
import com.kh.hobbycloud.vo.lec.LecDetailVO;
import com.kh.hobbycloud.vo.lec.LecListVO;

public interface LecDao {
	void register(LecDto lecDto);//강좌 등록
	List<LecListVO> list();
	List<LecListVO> listSearch(Map<String,Object> param);//목록 및 검색
	LecDetailVO get(int lecIdx);//단일 조회
	void delete(int lecIdx);//삭제
	int getSequence();//시퀀스 생성
	
	List<LecListVO> listPage(int startRow, int endRow);
		
	//게시글 목록 조회
	List<LecListVO> list(LecCriteria cri);
	//게시글 총개수
	int listCount();
}
