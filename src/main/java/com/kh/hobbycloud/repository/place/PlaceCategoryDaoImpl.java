package com.kh.hobbycloud.repository.place;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.hobbycloud.entity.place.PlaceTargetDto;

@Repository
public class PlaceCategoryDaoImpl implements PlaceCategoryDao {

	@Autowired SqlSession sqlSession;

	// 추가
	@Override
	public void insert(PlaceTargetDto placeTargetDto) {
		sqlSession.insert("placeCategory.insert", placeTargetDto);
	}

	// 목록획득
	@Override
	public List<String> select() {
		List<String> list = sqlSession.selectList("placeCategory.select");
		return list;
	}

	// 수정
	@Override
	public boolean update(PlaceTargetDto placeTargetDto) {
		int count = sqlSession.update("placeCategory.update", placeTargetDto);
		System.out.println(count+"카운트개수");
		return count > 0;
	}


	// 삭제
	@Override
	public void delete(PlaceTargetDto placeTargetDto) {
		sqlSession.delete("placeCategory.delete", placeTargetDto);
	}


}
