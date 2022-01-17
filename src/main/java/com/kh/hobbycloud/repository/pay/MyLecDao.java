package com.kh.hobbycloud.repository.pay;

import java.util.List;

import com.kh.hobbycloud.entity.pay.MyLecDto;
import com.kh.hobbycloud.vo.lec.MyLecVO;
import com.kh.hobbycloud.vo.pay.MyLecSearchVO;

public interface MyLecDao {
	public Integer getSequence();
	public MyLecDto getByIdx(Integer myLecIdx);
	public List<MyLecVO> select();
	public List<MyLecVO> select(MyLecSearchVO vo);
	public boolean insert(MyLecDto dto);
	public boolean delete(Integer myLecIdx);
	public boolean update(MyLecDto dto);
	public List<MyLecVO> getMyLec(Integer memberIdx);//내 강좌 보기



}