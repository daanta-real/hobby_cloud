package com.kh.hobbycloud.repository.notice;

import java.util.List;

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
		sqlSession.insert("noticeReply.insert",noticeReplyDto);
		
	}

	@Override
	public int sequence() {
		
		return sqlSession.selectOne("noticeReply.seq");
	}

	@Override
	public List<NoticeReplyVO> list(int noticeIdx) {
		
		return sqlSession.selectList("noticeReply.list",noticeIdx);
	}

	@Override
	public void delete(int noticeReplyIdx) {
		
		sqlSession.delete("noticeReply.delete", noticeReplyIdx);
	}

	@Override
	public void edit(NoticeReplyVO noticeReplyVO) {
		sqlSession.update("noticeReply.edit",noticeReplyVO);
		
	}

}
