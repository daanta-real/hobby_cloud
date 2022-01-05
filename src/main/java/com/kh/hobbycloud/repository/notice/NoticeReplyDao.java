package com.kh.hobbycloud.repository.notice;

import java.util.List;

import com.kh.hobbycloud.entity.notice.NoticeReplyDto;
import com.kh.hobbycloud.vo.notice.NoticeReplyVO;

public interface NoticeReplyDao {
	// 댓글등록
	void insert(NoticeReplyDto noticeReplyDto);

	// 시퀀스 번호
	int sequence();

	// 댓글 목록
	List<NoticeReplyVO> list(int noticeIdx);

	// 댓글 삭제 기능
	void delete(int noticeReplyIdx);
	
    //댓글 수정 기능
	void edit(NoticeReplyVO noticeReplyVO);

}
