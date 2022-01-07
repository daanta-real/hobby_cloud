package com.kh.hobbycloud.repository.gather;

import java.util.List;

import com.kh.hobbycloud.entity.gather.GatherHeadsDto;
import com.kh.hobbycloud.vo.gather.GatherChartVO;
import com.kh.hobbycloud.vo.gather.GatherHeadsVO;

public interface GatherHeadsDao {
	//소모임 참가
	void join(GatherHeadsDto gatherHeadsDto);
	//소모임 참가자 목록
	List<GatherHeadsVO> list(int gatherIdx);
	//소모임 취소
	boolean cancel(GatherHeadsDto gatherHeadsDto);
	//소모임 인원수 구하기
	List<GatherChartVO> countByGender(int gatherIdx);
}
