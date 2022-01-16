package com.kh.hobbycloud.repository.notice;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.hobbycloud.entity.notice.NoticeReplyDto;
import com.kh.hobbycloud.vo.notice.NoticeReplyVO;
@Repository
public class NoticeReplyImpl implements NoticeReplyDao{
	
	@Autowired
	private SqlSession sqlSession;

	@Override
	public void insert(NoticeReplyDto noticeReplyDto) {
		sqlSession.insert("notice.replyInsert",noticeReplyDto);
		
	}

	@Override
	public List<NoticeReplyVO> list(int noticeIdx) {
		return sqlSession.selectList("notice.replyList",noticeIdx);
	}

	@Override
	public List<NoticeReplyVO> listBy(int startRow, int endRow, int noticeIdx) {
		Map<String, Object>param = new HashMap<>();
		param.put("startRow", startRow);
		System.out.println("댓글start"+startRow+endRow);
		param.put("endRow", endRow); 
		param.put("noticeIdx",noticeIdx); 
		return sqlSession.selectList("notice.replyList",param);
	}

	@Override
	public boolean delete(int noticeReplyIdx) {
		int count = sqlSession.delete("notice.replyDelete",noticeReplyIdx);
		return count >0;
	}

	@Override
	public void edit(NoticeReplyDto noticeReplyDto) {
		//댓글 수정 void도 가능
		 sqlSession.update("notice.replyEdit",noticeReplyDto);
		
	}

	
}
