package com.kh.hobbycloud.repository.gather;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.hobbycloud.entity.gather.GatherDto;
import com.kh.hobbycloud.vo.gather.GatherSearchVO;
import com.kh.hobbycloud.vo.gather.GatherVO;

@Repository
public class GatherDaoImpl implements GatherDao {

	@Autowired
	private SqlSession sqlSession;

	@Override
	public List<GatherVO> listSearch(List<GatherSearchVO> categorys) {
		System.out.println("카테고리"+categorys);
		return sqlSession.selectList("gather.listSearch", categorys);
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



//	@Override
//	public List<GatherVO> getUpdate(int gatherIdx) {	
//		return sqlSession.selectList("gather.getUpdate",gatherIdx);
//	}
	

}