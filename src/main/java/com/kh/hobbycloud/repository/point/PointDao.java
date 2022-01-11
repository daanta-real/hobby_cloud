package com.kh.hobbycloud.repository.point;

import java.util.List;

import com.kh.hobbycloud.entity.point.PointDto;
import com.kh.hobbycloud.vo.point.PointSearchVO;

public interface PointDao {
	public Integer getSequence();
	public PointDto getByIdx(Integer pointIdx);
	public PointDto getByName(String pointName);
	public List<PointDto> select(PointSearchVO vo);
	public boolean insert(PointDto dto);
	public boolean delete(Integer pointIdx);
	public boolean update(PointDto dto);
}
