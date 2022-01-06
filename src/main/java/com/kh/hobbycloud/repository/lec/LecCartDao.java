package com.kh.hobbycloud.repository.lec;

import java.util.List;

import com.kh.hobbycloud.vo.lec.LecCartVO;

public interface LecCartDao {
	List<LecCartVO> cartMoney();
	void insert(LecCartVO lecCartVO);//강좌 찜하기
	List<LecCartVO> listCart(int memberIdx); //해당 회원 찜 목록
	void delete(int cartIdx);//찜 개별 삭제
	void deleteAll(int memberIdx); //해당 회원 찜 모두 삭제
	void update(int cartIdx);
	int totalPrice(int memberIdx); //찜 금액 합계
//	int countCart(int memberIdx); //찜 상품 갯수(굳이 필요한가..?)
	void updateCart(LecCartVO lecCartVO); //찜 수정
	void modifyCart(LecCartVO lecCartVO);
}
