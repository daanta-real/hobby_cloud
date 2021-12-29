package com.kh.hobbycloud.service.lec;

import java.io.IOException;

import com.kh.hobbycloud.vo.lec.LecRegisterVO;

public interface LecService {

	int register(LecRegisterVO lecRegisterVO) throws IllegalStateException, IOException;

}
