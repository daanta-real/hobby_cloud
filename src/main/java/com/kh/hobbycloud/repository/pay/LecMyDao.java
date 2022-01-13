package com.kh.hobbycloud.repository.pay;

import java.util.List;

import com.kh.hobbycloud.entity.pay.LecMyDto;

public interface LecMyDao {
	public Integer getSequence();
	public LecMyDto getByIdx(Integer myLecIdx);
	public List<LecMyDto> select();
	public List<LecMyDto> select(LecMyDto dto);
	public boolean insert(LecMyDto dto);
	public boolean delete(Integer myLecIdx);
	public boolean update(LecMyDto dto);
}