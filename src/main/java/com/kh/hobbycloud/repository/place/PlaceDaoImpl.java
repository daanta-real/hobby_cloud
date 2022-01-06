package com.kh.hobbycloud.repository.place;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.hobbycloud.entity.place.PlaceDto;
import com.kh.hobbycloud.vo.place.PlaceRegisterVO;

@Repository
public class PlaceDaoImpl implements PlaceDao{
	
	@Autowired
	private SqlSession sqlSession;

	@Override
	public void delete(int placeIdx) {
		sqlSession.delete("place.delete",placeIdx);		
	}

	@Override
	public int getSequence() {
		return sqlSession.selectOne("place.getSequence");
	}

	@Override
	public void insert(PlaceDto placeDto) {
		sqlSession.insert("place.save", placeDto);		
	}

	@Override
	public PlaceRegisterVO get(int placeIdx) {
		return sqlSession.selectOne("place.get",placeIdx);
	}

	@Override
	public List<PlaceRegisterVO> list() {
		return sqlSession.selectList("place.list");
	}

	@Override
	public boolean update(PlaceDto placeDto) {
		int count  = sqlSession.update("place.update",placeDto);
		System.out.println(count+"카운트개수");
		return count>0;
		
	}

}
