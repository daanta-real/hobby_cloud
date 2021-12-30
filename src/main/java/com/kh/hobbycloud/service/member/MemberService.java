package com.kh.hobbycloud.service.member;

import java.io.IOException;

import com.kh.hobbycloud.entity.member.MemberDto;
import com.kh.hobbycloud.vo.member.MemberJoinVO;

public interface MemberService {
	//회원가입
	void join(MemberJoinVO memberJoinVO) throws IllegalStateException, IOException;
	
	//아이디 중복확인
	MemberDto checkId(String memberId) throws Exception;
	
	//닉네임 중복 확인
	MemberDto checkNick(String memberNick) throws Exception;

}