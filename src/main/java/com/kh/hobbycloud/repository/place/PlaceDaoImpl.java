package com.kh.hobbycloud.repository.place;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.hobbycloud.entity.place.PlaceDto;
import com.kh.hobbycloud.vo.place.PlaceCriteria;
import com.kh.hobbycloud.vo.place.PlaceListVO;
import com.kh.hobbycloud.vo.place.PlaceSearchVO;
import com.kh.hobbycloud.vo.place.PlaceVO;

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
	public PlaceVO get(int placeIdx) {
		return sqlSession.selectOne("place.get",placeIdx);
	}

	@Override
	public boolean update(PlaceDto placeDto) {
		int count  = sqlSession.update("place.update",placeDto);
		System.out.println(count+"카운트개수");
		return count>0;
		
	}
	
	@Override
	public List<PlaceListVO> list(PlaceCriteria cri) {
		return sqlSession.selectList("place.list");
	}


	@Override
	public int listCount() {
		return sqlSession.selectOne("place.listCount");
	}
	
	public List<PlaceListVO> listSearch(PlaceSearchVO placeSearchVO) {
		return sqlSession.selectList("Place.listSearch", placeSearchVO);
	}
	
	//페이지네이션을 이용한 목록조회
	@Override
	public List<PlaceListVO> listPage(int startRow, int endRow) {
		Map<String, Object> param = new HashMap<>();
		param.put("startRow", startRow);
		param.put("endRow", endRow);
		return sqlSession.selectList("place.listPage",param);
	}

	@Override
	public List<PlaceListVO> listBy(int startRow, int endRow) {
		Map<String, Object> param = new HashMap<>();
		param.put("startRow", startRow);
		param.put("endRow", endRow);
		System.out.println("------다오옴"); 
		return sqlSession.selectList("place.listBy", param);
	}



}
