package com.kh.hobbycloud.repository.notice;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.hobbycloud.entity.notice.NoticeDto;
import com.kh.hobbycloud.vo.gather.Criteria;
import com.kh.hobbycloud.vo.notice.NoticeVO;

@Repository
public class NoticeDaoImpl implements NoticeDao {

	@Autowired
	private SqlSession sqlSession;

	@Override
	public List<NoticeVO> list() {
		return sqlSession.selectList("notice.list");
	}

	@Override
	public NoticeVO get(int noticeIdx) {

		return sqlSession.selectOne("notice.get", noticeIdx);
	}

	@Override
	public void insert(NoticeDto noticeDto) {
		sqlSession.insert("notice.insert", noticeDto);
		

	}

	@Override
	public void delete(int noticeIdx) {
		sqlSession.delete("notice.delete", noticeIdx);

	}

	@Override
	public boolean edit(NoticeVO noticeVO) {
		int count = sqlSession.update("notice.edit", noticeVO);
		return count > 0;
	}

	@Override
	public int getsequences() {

		return sqlSession.selectOne("notice.seq");
	}

	@Override
	public List<NoticeVO> search(String column, String keyword) {
		// 주의 :
		// = 마이바티스 구문을 부를 때는 데이터를 1개만 전달할 수 있다.
		// = 보내야 할 값이 여러개라면 객체나 Map을 사용한다.
		Map<String, Object> param = new HashMap<>();
		param.put("column", column);
		param.put("keyword", keyword);
		return sqlSession.selectList("notice.search", param);
	}

	@Override
	public void views(int noticeIdx) {
		sqlSession.update("notice.views",noticeIdx);
		
	}

	@Override
	public void read(NoticeDto noticeDto) {
		sqlSession.update("notice.read",noticeDto);
		
	}

	@Override
	public List<NoticeVO> listPage(int startRow, int endRow) {
		Map<String, Object> param = new HashMap<>();
		param.put("startRow", startRow);
		param.put("endRow", endRow);
		return sqlSession.selectList("notice.listPage",param);
	}

	@Override
	public List<NoticeVO> list(Criteria cri) {
		
		return sqlSession.selectList("notice.listPage",cri);
	}

	@Override
	public int listCount() {
		
		return sqlSession.selectOne("notice.listCount");
	}

	

	

	

	

	

}
