package com.kh.hobbycloud.repository.pay;

import java.util.List;

import com.kh.hobbycloud.entity.pay.PaidDto;
import com.kh.hobbycloud.vo.pay.PaidSearchVO;
import com.kh.hobbycloud.vo.pay.PaidVO;

public interface PaidDao {

	// 새 시퀀스 획득
	public Integer getSequence();

	// 단일조회 By idx (String)
	public PaidVO getByIdx(String idx);
	public PaidVO getByIdx(Integer idx);

	// 결제이력 검색
	public List<PaidVO> select(PaidSearchVO searchVO);

	// 결제이력 등록
	public boolean insert(PaidDto dto);

	// 결제 취소
	public boolean markCancel(String idx);
	public boolean markCancel(Integer idx);

}
