package com.kh.hobbycloud.repository.lec;

import java.util.List;
import java.util.Map;

import com.kh.hobbycloud.entity.lec.LecDto;
import com.kh.hobbycloud.vo.lec.LecDetailVO;

public interface LecDao {
	void register(LecDto lecDto);//강좌 등록
	List<LecDto> listSearch(Map<String,Object> param);//목록 및 검색
	LecDetailVO get(int lecIdx);//단일 조회
	void delete(int lecIdx);//삭제
	int  getSequence();//시퀀스 생성
	boolean update(LecDto lecDto);
}
