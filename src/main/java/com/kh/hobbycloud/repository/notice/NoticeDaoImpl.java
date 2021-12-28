package com.kh.hobbycloud.repository.notice;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.hobbycloud.entity.notice.NoticeDto;
import com.kh.hobbycloud.entity.notice.NoticeVO;
@Repository
public class NoticeDaoImpl implements NoticeDao{
	
	@Autowired
	private SqlSession sqlSession;
 
	@Override
	public List<NoticeVO> list() {
		return sqlSession.selectList("notice.list");
	}

	@Override
	public NoticeVO get(int noticeIdx) {
		
		return sqlSession.selectOne("notice.get",noticeIdx);
	}

	@Override
	public void insert(NoticeDto noticeDto) {
		sqlSession.insert("notice.insert",noticeDto);
		
		
	}

	@Override
	public void delete(int noticeIdx) {
		sqlSession.delete("notice.delete",noticeIdx);
		
	}

	@Override
	public boolean edit(NoticeVO noticeVO) {
		int count = sqlSession.update("notice.edit",noticeVO);
		return count>0;
	}

	@Override
	public int getsequences() {
		
		return sqlSession.selectOne("notice.seq");
	}

}
