package com.kh.hobbycloud.repository.lec;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.hobbycloud.entity.lec.LecDto;
import com.kh.hobbycloud.vo.lec.LecCriteria;
import com.kh.hobbycloud.vo.lec.LecDetailVO;
import com.kh.hobbycloud.vo.lec.LecListVO;

@Repository
public class LecDaoImpl implements LecDao{

	@Autowired
	private SqlSession sqlSession;

	@Override
	public void register(LecDto lecDto) {
		sqlSession.insert("lec.register", lecDto);
	}

	@Override
	public List<LecListVO> list() {
		return sqlSession.selectList("lec.list");
	}

	@Override
	public List<LecListVO> listSearch(Map<String, Object> param) {
		return sqlSession.selectList("lec.listSearch", param);
	}

	@Override
	public LecDetailVO get(int lecIdx) {
		return sqlSession.selectOne("lec.get", lecIdx);
	}

	@Override
	public void delete(int lecIdx) {
		sqlSession.delete("lec.delete", lecIdx);
	}

	@Override
	public int getSequence() {
		return sqlSession.selectOne("lec.seq");
	}

	//페이지네이션을 이용한 목록조회
	@Override
	public List<LecListVO> listPage(int startRow, int endRow) {
		Map<String, Object> param = new HashMap<>();
		param.put("startRow", startRow);
		param.put("endRow", endRow);
		return sqlSession.selectList("lec.listPage",param);
	}

	@Override
	public List<LecListVO> list(LecCriteria cri) {
		return sqlSession.selectList("lec.listPage", cri);
	}

	@Override
	public int listCount() {
		return sqlSession.selectOne("lec.listCount");
	}

	@Override
	public boolean update(LecDto lecDto) {
		int count = sqlSession.update("lec.update", lecDto);
		return count > 0;
	}
}
