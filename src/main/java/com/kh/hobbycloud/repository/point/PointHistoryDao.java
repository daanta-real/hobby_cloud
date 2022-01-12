package com.kh.hobbycloud.repository.point;

import java.util.List;

import com.kh.hobbycloud.entity.point.PointHistoryDto;
import com.kh.hobbycloud.vo.point.PointHistorySearchVO;
import com.kh.hobbycloud.vo.point.PointHistoryVO;

public interface PointHistoryDao {
	public Integer getSequence();
	public PointHistoryDto getByIdx(Integer pointHistoryIdx);
	public PointHistoryDto getByPaidIdx(Integer paidIdx);
	public List<PointHistoryVO> select(PointHistorySearchVO vo);
	public boolean insert(PointHistoryDto dto);
	public boolean delete(Integer pointHistoryIdx);
	public boolean update(PointHistoryDto dto);
}
