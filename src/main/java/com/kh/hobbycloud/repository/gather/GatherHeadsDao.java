package com.kh.hobbycloud.repository.gather;

import java.util.List;

import com.kh.hobbycloud.entity.gather.GatherHeadsDto;
import com.kh.hobbycloud.vo.gather.GatherHeadsVO;

public interface GatherHeadsDao {

	void join(GatherHeadsDto gatherHeadsDto);
	List<GatherHeadsVO> list(int gatherIdx);
	boolean cancel(GatherHeadsDto gatherHeadsDto);
}
