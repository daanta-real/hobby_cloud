package com.kh.hobbycloud.repository.petitions;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.hobbycloud.entity.petitions.PetitionsReplyDto;
import com.kh.hobbycloud.vo.petitions.PetitionsReplyVO;

@Repository
public class PetitionsReplyDaoImpl implements PetitionsReplyDao{
	@Autowired
	private SqlSession sqlSession;
	@Override
	public void insert(PetitionsReplyDto petitionsReplyDto) {
		
		sqlSession.insert("petitions.replyInsert",petitionsReplyDto);
		
	}
	@Override
	public List<PetitionsReplyVO> list(int petitionsIdx) {
		
		return sqlSession.selectList("petitions.replyList",petitionsIdx);
	}
	@Override
	public List<PetitionsReplyVO> listBy(int startRow, int endRow, int petitionsIdx) {
		Map<String, Object>param = new HashMap<>();
		param.put("startRow", startRow);
		System.out.println("댓글start"+startRow+endRow);
		param.put("endRow", endRow); 
		param.put("petitionsIdx",petitionsIdx); 
		return sqlSession.selectList("petitions.replyList",param);
	}
	@Override
	public boolean delete(int petitionsReplyIdx) {
		int count = sqlSession.delete("petitions.replyDelete",petitionsReplyIdx);
		return count >0;
	}
	@Override
	public void edit(PetitionsReplyDto petitionsReplyDto) {
		//댓글 수정 void도 가능
		 sqlSession.update("petitions.replyEdit",petitionsReplyDto);
		
	}
	
}
