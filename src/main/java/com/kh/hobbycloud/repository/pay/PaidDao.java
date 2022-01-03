package com.kh.hobbycloud.repository.pay;

import java.util.List;

import com.kh.hobbycloud.entity.pay.PaidDto;
import com.kh.hobbycloud.vo.pay.PaidSearchVO;

public interface PaidDao {

	// 새 시퀀스 획득
	public Integer getSequence();

	// 단일조회 By idx (String)
	public PaidDto getByIdx(String idx);
	public PaidDto getByIdx(Integer idx);

	// 결제이력 등록
	public void insert(PaidDto dto);

	// 결제 취소
	public boolean cancel(String idx);
	public boolean cancel(Integer idx);

	// 결제이력 검색
	public List<PaidDto> search(PaidSearchVO searchVO);

}
