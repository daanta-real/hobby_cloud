package com.kh.hobbycloud.repository.point;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.hobbycloud.entity.point.PointHistoryDto;
import com.kh.hobbycloud.vo.point.PointHistorySearchVO;

@Repository
public class PointHistoryDaoImpl implements PointHistoryDao {

	@Autowired SqlSession sqlSession;

	// 새 시퀀스 획득
	@Override
	public Integer getSequence() {
		return sqlSession.selectOne("pointHistory.getSequence");
	}

	// IDX로 단일 데이터 획득
	@Override
	public PointHistoryDto getByIdx(Integer pointHistoryIdx) {
		return sqlSession.selectOne("pointHistory.getByIdx", pointHistoryIdx);
	}

	// 이름으로 단일 데이터 획득
	@Override
	public PointHistoryDto getByPaidIdx(Integer paidIdx) {
		return sqlSession.selectOne("pointHistory.getByPaidIdx", paidIdx);
	}

	// 검색조건을 넣어 목록 획득
	// 아무 검색조건을 넣지 않으면, 그냥 전체 목록을 갖고 옴.
	@Override
	public List<PointHistoryDto> select(PointHistorySearchVO vo) {
		return sqlSession.selectList("pointHistory.select", vo);
	}

	// 신규
	@Override
	public boolean insert(PointHistoryDto dto) {
		Integer result = sqlSession.insert("pointHistory.insert", dto);
		return result > 0;
	}

	// 삭제
	@Override
	public boolean delete(Integer pointHistoryIdx) {
		Integer result = sqlSession.delete("pointHistory.delete", pointHistoryIdx);
		return result > 0;
	}

	// 수정
	@Override
	public boolean update(PointHistoryDto dto) {
		Integer result = sqlSession.update("pointHistory.update", dto);
		return result > 0;
	}

}
