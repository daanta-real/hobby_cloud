package com.kh.hobbycloud.repository.lec;

import java.util.List;
import java.util.Map;

import com.kh.hobbycloud.entity.lec.LecDto;

public interface LecDao {
	void register(LecDto lecDto);//강좌 등록
	List<LecDto> list();
	List<LecDto> listSearch(Map<String,Object> param);
}
