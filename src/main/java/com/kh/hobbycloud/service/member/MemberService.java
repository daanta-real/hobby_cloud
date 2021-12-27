package com.kh.hobbycloud.service.member;

import java.io.IOException;

import com.kh.hobbycloud.vo.member.MemberJoinVO;

public interface MemberService {
	void join(MemberJoinVO memberJoinVO) throws IllegalStateException, IOException;
}
