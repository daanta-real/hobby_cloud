package com.kh.hobbycloud.repository.member;

import com.kh.hobbycloud.entity.member.MemberDto;

public interface MemberDao {
	
	//가입
	void join(MemberDto memberDto);
	
	//단일조회
	MemberDto get(String memberId);
	
	//비밀번호 검사까지 통과 로그인
	MemberDto login(MemberDto memberDto);

	//비밀번호 변경
	boolean changePassword(String memberId, String memberPw, String changePw);
	
	//개인정보 변경
	boolean changeInformation(MemberDto memberDto);

	//회원 탈퇴
	boolean quit(String memberId, String memberPw);

}
