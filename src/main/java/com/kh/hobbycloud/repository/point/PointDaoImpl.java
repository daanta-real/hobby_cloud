package com.kh.hobbycloud.repository.point;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.hobbycloud.entity.point.PointDto;
import com.kh.hobbycloud.vo.point.PointSearchVO;

@Repository
public class PointDaoImpl implements PointDao {

	@Autowired SqlSession sqlSession;

	// 새 시퀀스 획득
	@Override
	public Integer getSequence() {
		return sqlSession.selectOne("point.getSequence");
	}

	// IDX로 단일 데이터 획득
	@Override
	public PointDto getByIdx(Integer pointIdx) {
		return sqlSession.selectOne("point.getByIdx", pointIdx);
	}

	// 이름으로 단일 데이터 획득
	@Override
	public PointDto getByName(String pointName) {
		return sqlSession.selectOne("point.getByName", pointName);
	}

	// 검색조건을 넣어 목록 획득
	// 아무 검색조건을 넣지 않으면, 그냥 전체 목록을 갖고 옴.
	@Override
	public List<PointDto> select(PointSearchVO vo) {
		return sqlSession.selectList("point.select", vo);
	}

	// 포인트상품 신규
	@Override
	public boolean insert(PointDto dto) {
		Integer result = sqlSession.insert("point.insert", dto);
		return result > 0;
	}

	// 포인트상품 삭제
	@Override
	public boolean delete(Integer pointIdx) {
		Integer result = sqlSession.delete("point.delete", pointIdx);
		return result > 0;
	}

	// 포인트상품 수정
	@Override
	public boolean update(PointDto dto) {
		Integer result = sqlSession.update("point.update", dto);
		return result > 0;
	}

}
