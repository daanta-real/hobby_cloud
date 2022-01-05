package com.kh.hobbycloud.repository.lec;

import java.util.List;

import com.kh.hobbycloud.entity.lec.LecDto;
import com.kh.hobbycloud.entity.lec.LecReplyDto;
import com.kh.hobbycloud.vo.lec.LecReplyVO;

public interface LecReplyDao {

	List<LecReplyVO> replyList(int lecIdx);

	LecDto lecWriteReply(LecReplyVO lecReplyVO);

	LecDto lecWriteReReply(LecReplyVO lecReplyVO);

	LecDto lecDeleteReply(LecReplyVO lecReplyVO);

	LecDto lecDeleteReReply(LecReplyVO lecReplyVO);
	
}
