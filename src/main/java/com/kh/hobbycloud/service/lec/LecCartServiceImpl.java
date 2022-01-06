package com.kh.hobbycloud.service.lec;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.hobbycloud.repository.lec.LecCartDao;
import com.kh.hobbycloud.vo.lec.LecCartVO;

@Service
public class LecCartServiceImpl implements LecCartService{

	@Autowired
	private LecCartDao lecCartDao;
	
	@Override
	public List<LecCartVO> cartMoney() {
		// TODO Auto-generated method stub
		return null;
	}
	
	//찜 추가
	@Override
	public void insert(LecCartVO lecCartVO) {
		lecCartDao.insert(lecCartVO);
	}
	
	@Override
	public List<LecCartVO> listCart(int memberIdx) {
		return lecCartDao.listCart(memberIdx);
	}
	
	@Override
	public void delete(int cartIdx) {
		lecCartDao.delete(cartIdx);
	}
	
	@Override
	public void deleteAll(int memberIdx) {
		lecCartDao.deleteAll(memberIdx);
	}
	
	@Override
	public void update(int cartIdx) {
		lecCartDao.update(cartIdx);
	}
	
	@Override
	public int totalPrice(int memberIdx) {
		return lecCartDao.totalPrice(memberIdx);
	}
	
	@Override
	public void updateCart(LecCartVO lecCartVO) {
		lecCartDao.updateCart(lecCartVO);
	}
	
	@Override
	public void modifyCart(LecCartVO lecCartVO) {
		lecCartDao.modifyCart(lecCartVO);
	}
}
