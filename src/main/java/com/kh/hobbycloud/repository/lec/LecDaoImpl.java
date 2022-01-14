package com.kh.hobbycloud.repository.lec;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.hobbycloud.entity.lec.LecDto;
import com.kh.hobbycloud.vo.lec.LecCriteria;
import com.kh.hobbycloud.vo.lec.LecCriteriaSearch;
import com.kh.hobbycloud.vo.lec.LecDetailVO;
import com.kh.hobbycloud.vo.lec.LecListVO;
import com.kh.hobbycloud.vo.lec.LecSearchVO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Repository
public class LecDaoImpl implements LecDao{

	@Autowired
	private SqlSession sqlSession;

	@Override
	public void register(LecDto lecDto) {
		log.debug("============렉DTO {}", lecDto);
		sqlSession.insert("lec.register", lecDto);
	}

	@Override
	public List<LecListVO> list() {
		return sqlSession.selectList("lec.list");
	}

	@Override
	public List<LecListVO> listSearch(LecSearchVO vo) {
		return sqlSession.selectList("lec.listSearch", vo);
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
	
	
	@Override
	public List<LecListVO> listBy(LecCriteriaSearch cri) {
		System.out.println("Lec 디에이오에서 cri : " + cri);
		return sqlSession.selectList("lec.listSearchBy", cri);
	}
	
	@Override
	public int listCountBy(LecSearchVO lecSearchVO) {
		int number = sqlSession.selectOne("lec.listCountBy", lecSearchVO);
		System.out.println("Lec 디에이오에서 검색 카운트 수 : " + number);
		return sqlSession.selectOne("lec.listCountBy", lecSearchVO);
	}
}
