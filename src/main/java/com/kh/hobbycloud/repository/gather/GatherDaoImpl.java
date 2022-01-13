package com.kh.hobbycloud.repository.gather;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.hobbycloud.entity.gather.GatherDto;
import com.kh.hobbycloud.vo.gather.Criteria;
import com.kh.hobbycloud.vo.gather.CriteriaSearch;
import com.kh.hobbycloud.vo.gather.GatherSearchVO;
import com.kh.hobbycloud.vo.gather.GatherVO;


@Repository
public class GatherDaoImpl implements GatherDao {

	@Autowired
	private SqlSession sqlSession;

	@Override
	public List<GatherVO> listSearch(GatherSearchVO gatherSearchVO) {
		return sqlSession.selectList("gather.listSearch", gatherSearchVO);
	}

	@Override
	public List<GatherVO> list() {
		return sqlSession.selectList("gather.list");
	}

	@Override
	public void insert(GatherDto gatherDto) {
		sqlSession.insert("gather.insert", gatherDto);
	}

	@Override
	public GatherVO get(int gatherIdx) {
		
		return sqlSession.selectOne("gather.get",gatherIdx);
	}

	@Override
	public int getSequence() {		
		return sqlSession.selectOne("gather.getSequence");
	}

	@Override
	public void delete(int gatherIdx) {
	sqlSession.delete("gather.delete",gatherIdx);
	
	}

	//게시판 수정
	@Override
	public boolean update(GatherDto gatherDto) {
	
		int count  = sqlSession.update("gather.update",gatherDto);
		System.out.println(count+"카운트개수");
		return count>0;
	}

	//페이지네이션을 이용한 목록조회

	@Override
	public List<GatherVO> list(Criteria cri) {
		return sqlSession.selectList("gather.listPage",cri);
	}

	@Override
	public int listCount() {
		return sqlSession.selectOne("gather.listCount");
	}

	@Override
	public List<GatherVO> listBy(CriteriaSearch cri2) {
		System.out.println("다오"+cri2); 
		return sqlSession.selectList("gather.listSearchBy",cri2);
	}
 
	@Override
	public int listCountBy(GatherSearchVO gatherSearchVO) {
		int number =sqlSession.selectOne("gather.listCountBy",gatherSearchVO);
		System.out.println("다오 숫자"+number);
		return sqlSession.selectOne("gather.listCountBy",gatherSearchVO);
	}







}