package com.kh.hobbycloud.repository.pay;

import java.util.List;

import com.kh.hobbycloud.entity.pay.LecMyDto;
import com.kh.hobbycloud.vo.lec.LecMyVO;

public interface LecMyDao {
	public Integer getSequence();
	public LecMyDto getByIdx(Integer myLecIdx);
	public List<LecMyDto> select();
	public List<LecMyDto> select(LecMyDto dto);
	public boolean insert(LecMyDto dto);
	public boolean delete(Integer myLecIdx);
	public boolean update(LecMyDto dto);
	public List<LecMyVO> getMyLec(Integer memberIdx);//내 강좌 보기
	public int getNowCount(int lecIdx);//강좌의 현재 신청 인원수 조회
	
}