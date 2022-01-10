package com.kh.hobbycloud.repository.pay;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.hobbycloud.entity.pay.PaidDto;
import com.kh.hobbycloud.vo.pay.PaidSearchVO;
import com.kh.hobbycloud.vo.pay.PaidVO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Repository
public class PaidDaoImpl implements PaidDao {

	@Autowired SqlSession sqlSession;

	// 새 시퀀스 획득
	@Override
	public Integer getSequence() {
		Integer sequence = sqlSession.selectOne("paid.getSequence");
		log.debug("ㅡㅡㅡPaidDao.getSequence() 실행. 새로 생성된 시퀀스: {}", sequence);
		return sequence;
	}

	// 단일조회 By idx
	@Override public PaidVO getByIdx(String idx) { return getByIdx(Integer.valueOf(idx)); }
	@Override public PaidVO getByIdx(Integer idx) {
		log.debug("ㅡㅡㅡPaidDao.getByIdx() 실행. 단일조회할 idx: {}", idx);
		return sqlSession.selectOne("paid.getByIdx", idx);
	}

	// 검색조건을 넣어 목록 획득
	// 아무 검색조건을 넣지 않으면, 그냥 전체 목록을 갖고 옴.
	@Override
	public List<PaidVO> select(PaidSearchVO searchVO) {
		log.debug("ㅡㅡㅡPaidDao.select() 실행. 검색조건: {}", searchVO);
		List<PaidVO> list = sqlSession.selectList("paid.search", searchVO);
		for(PaidVO vo: list) vo.prepareDateStr();
		return list;
	}

	// 결제이력 등록
	@Override
	public boolean insert(PaidDto dto) {
		log.debug("ㅡㅡㅡPaidDao.insert() 실행. 새로운 결제이력 넣기: {}", dto);
		Integer result = sqlSession.insert("paid.insert", dto);
		return result > 0;
	}

	// 결제 취소
	@Override public boolean markCancel(String idx) { return markCancel(Integer.valueOf(idx)); }
	@Override public boolean markCancel(Integer idx) {
		log.debug("ㅡㅡㅡPaidDao.markCancel() 실행. 취소할 idx: {}", idx);
		Integer result = sqlSession.update("paid.markCancel", idx);
		return result > 0;
	}

}
