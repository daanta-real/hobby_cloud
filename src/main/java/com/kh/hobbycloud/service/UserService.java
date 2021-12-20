package com.kh.hobbycloud.service;

import java.io.IOException;

import com.kh.hobbycloud.vo.UserJoinVO;

public interface UserService {
	void join(UserJoinVO memberJoinVO) throws IllegalStateException, IOException;
}
