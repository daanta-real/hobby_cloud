package com.kh.hobbycloud.repository.pay;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.hobbycloud.entity.pay.PaidDto;
import com.kh.hobbycloud.vo.pay.PaidSearchVO;
import com.kh.hobbycloud.vo.pay.PaidVO;

@Repository
public class PaidDaoImpl implements PaidDao {

	@Autowired SqlSession sqlSession;

	// 새 시퀀스 획득
	@Override
	public Integer getSequence() {
		return sqlSession.selectOne("paid.getSequence");
	}

	// 단일조회 By idx
	@Override public PaidDto getByIdx(String idx) { return getByIdx(Integer.valueOf(idx)); }
	@Override public PaidDto getByIdx(Integer idx) {
		return sqlSession.selectOne("paid.getByIdx", idx);
	}

	// 결제이력 등록
	@Override
	public void insert(PaidDto dto) {
		sqlSession.insert("paid.insert", dto);
	}

	// 결제 취소
	@Override public boolean cancel(String idx) { return cancel(Integer.valueOf(idx)); }
	@Override public boolean cancel(Integer idx) {
		int result = sqlSession.update("paid.cancel", idx);
		return result > 0;
	}

	// 결제이력 검색
	@Override
	public List<PaidVO> search(PaidSearchVO searchVO) {
		List<PaidVO> list = sqlSession.selectList("paid.search", searchVO);
		for(PaidVO vo: list) vo.prepareDateStr();
		return list;
	}

}
