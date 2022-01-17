package com.kh.hobbycloud.repository.pay;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.hobbycloud.entity.pay.MyLecDto;
import com.kh.hobbycloud.vo.lec.MyLecVO;
import com.kh.hobbycloud.vo.pay.MyLecSearchVO;

@Repository
public class MyLecDaoImpl implements MyLecDao {

	@Autowired SqlSession sqlSession;

	// 새 시퀀스 획득
	@Override
	public Integer getSequence() {
		return sqlSession.selectOne("myLec.getSequence");
	}

	// IDX로 단일 데이터 획득
	@Override
	public MyLecDto getByIdx(Integer myLec) {
		return sqlSession.selectOne("myLec.getByIdx");
	}

	// 검색조건을 넣어 목록 획득
	// 아무 검색조건을 넣지 않으면, 그냥 전체 목록을 갖고 옴.
	@Override
	public List<MyLecVO> select() { return select(new MyLecSearchVO()); }
	@Override
	public List<MyLecVO> select(MyLecSearchVO vo) {
		return sqlSession.selectList("myLec.select", vo);
	}

	@Override
	public boolean insert(MyLecDto dto) {
		int result = sqlSession.insert("myLec.insert", dto);
		return result > 0;
	}

	@Override
	public boolean delete(Integer myLecIdx) {
		int result = sqlSession.delete("myLec.delete", myLecIdx);
		return result > 0;
	}

	@Override
	public boolean update(MyLecDto dto) {
		int result = sqlSession.update("lecMy.update", dto);
		return result > 0;
	}

	@Override
	public List<MyLecVO> getMyLec(Integer memberIdx) {
		return sqlSession.selectList("myLec.getMyLec", memberIdx);
	}

}
