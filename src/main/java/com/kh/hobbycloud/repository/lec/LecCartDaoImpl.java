package com.kh.hobbycloud.repository.lec;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.hobbycloud.vo.lec.LecCartVO;

@Repository
public class LecCartDaoImpl implements LecCartDao{

	@Autowired
	private SqlSession sqlSession;
	
	@Override
	public List<LecCartVO> cartMoney() {
		// TODO Auto-generated method stub
		return null;
	}
	
	//찜 추가
	@Override
	public void insert(LecCartVO lecCartVO) {
		//VO에 저장된 값을 받아 sql세션에 저장하고 cart.insert(mapper)로 넘어감
		sqlSession.insert("lecCart.insert", lecCartVO);
	}
	
	@Override
	public List<LecCartVO> listCart(int memberIdx) {
		return sqlSession.selectList("lecCart.listCart", memberIdx);
	}
	
	@Override
	public void delete(int cartIdx) {
		sqlSession.delete("lecCart.delete", cartIdx);
	}
	
	@Override
	public void deleteAll(int memberIdx) {
		sqlSession.delete("lecCart.deleteAll", memberIdx);	
	}
	
	@Override
	public void update(int cartIdx) {
		sqlSession.update("lecCart.update", cartIdx);	
	}
	
	@Override
	public int totalPrice(int memberIdx) {
		return sqlSession.selectOne("lecCart.totalPrice", memberIdx);
	}
	
	@Override
	public void updateCart(LecCartVO lecCartVO) {
		// TODO Auto-generated method stub
		
	}
	
	@Override
	public void modifyCart(LecCartVO lecCartVO) {
		sqlSession.update("lecCart.modifyCart", lecCartVO);	
	}
}
