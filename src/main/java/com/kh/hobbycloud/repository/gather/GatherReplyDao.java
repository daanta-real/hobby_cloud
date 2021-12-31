package com.kh.hobbycloud.repository.gather;

import java.util.List;

import com.kh.hobbycloud.entity.gather.GatherReplyDto;
import com.kh.hobbycloud.vo.gather.GatherReplyVO;

public interface GatherReplyDao {
	void insert(GatherReplyDto gatherReplyDto);
	List<GatherReplyVO> list(int gatherIdx);
	boolean delete (int gatherReplyIdx);
}
