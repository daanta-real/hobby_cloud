package com.kh.hobbycloud.repository.lec;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.hobbycloud.entity.lec.LecReplyDto;

@Repository
public class LecReplyDaoImpl implements LecReplyDao{
	
	@Autowired
	private SqlSession sqlSession;
	
	@Override
	public void write(LecReplyDto lecReplyDto) {
		sqlSession.insert("lecReply.reply_write", lecReplyDto);
	}
}
