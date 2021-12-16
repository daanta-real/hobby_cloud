package com.temp.service;

import java.io.IOException;

import com.temp.vo.UserJoinVO;

public interface UserService {
	void join(UserJoinVO memberJoinVO) throws IllegalStateException, IOException;
}
