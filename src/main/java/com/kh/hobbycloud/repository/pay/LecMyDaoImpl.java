package com.kh.hobbycloud.repository.pay;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.hobbycloud.entity.pay.LecMyDto;
import com.kh.hobbycloud.vo.lec.LecMyVO;

@Repository
public class LecMyDaoImpl implements LecMyDao {

	@Autowired SqlSession sqlSession;

	// 새 시퀀스 획득
	@Override
	public Integer getSequence() {
		return sqlSession.selectOne("lecMy.getSequence");
	}

	// IDX로 단일 데이터 획득
	@Override
	public LecMyDto getByIdx(Integer lecMyIdx) {
		return sqlSession.selectOne("lecMy.getByIdx");
	}

	// 검색조건을 넣어 목록 획득
	// 아무 검색조건을 넣지 않으면, 그냥 전체 목록을 갖고 옴.
	@Override
	public List<LecMyDto> select() { return select(new LecMyDto()); }
	@Override
	public List<LecMyDto> select(LecMyDto dto) {
		return sqlSession.selectList("lecMy.select", dto);
	}

	@Override
	public boolean insert(LecMyDto dto) {
		int result = sqlSession.insert("lecMy.insert", dto);
		return result > 0;
	}

	@Override
	public boolean delete(Integer lecMyIdx) {
		int result = sqlSession.delete("lecMy.delete", lecMyIdx);
		return result > 0;
	}

	@Override
	public boolean update(LecMyDto dto) {
		int result = sqlSession.update("lecMy.update", dto);
		return result > 0;
	}

	@Override
	public List<LecMyVO> getMyLec(Integer memberIdx) {
		return sqlSession.selectList("lecMy.getMyLec", memberIdx);
	}
	
}
