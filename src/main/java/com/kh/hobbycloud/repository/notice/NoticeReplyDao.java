package com.kh.hobbycloud.repository.notice;

import java.util.List;

import com.kh.hobbycloud.entity.notice.NoticeReplyDto;
import com.kh.hobbycloud.vo.notice.NoticeReplyVO;

public interface NoticeReplyDao {
	//댓글 등록
			void insert(NoticeReplyDto noticeReplyDto);
			//댓글 조회
			List<NoticeReplyVO> list(int noticeIdx);
			//댓글 조회
			List<NoticeReplyVO> listBy(int startRow,int endRow,int noticeIdx);
			//댓글 삭제
			boolean delete (int noticeReplyIdx);
			//댓글 수정
			void edit(NoticeReplyDto noticeReplyDto);

}
