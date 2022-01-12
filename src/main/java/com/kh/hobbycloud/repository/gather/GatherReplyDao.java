package com.kh.hobbycloud.repository.gather;

import java.util.List;

import com.kh.hobbycloud.entity.gather.GatherReplyDto;
import com.kh.hobbycloud.vo.gather.GatherReplyVO;

public interface GatherReplyDao {
	//댓글 등록
	void insert(GatherReplyDto gatherReplyDto);
	//댓글 조회
	List<GatherReplyVO> list(int gatherIdx);
	//댓글 조회
		List<GatherReplyVO> listBy(int startRow,int endRow,int gatherIdx);
	//댓글 삭제
	boolean delete (int gatherReplyIdx);
	//댓글 수정
	void edit(GatherReplyDto gatherReplyDto);
}
