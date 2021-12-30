package com.kh.hobbycloud.repository.member;

import com.kh.hobbycloud.entity.member.MemberDto;

public interface MemberDao {

	//가입
	void join(MemberDto memberDto);

	//단일조회
	MemberDto get(String memberId);
	MemberDto get(Integer memberIdx);

	//비밀번호 검사까지 통과 로그인
	MemberDto login(MemberDto memberDto);

	//비밀번호 변경
	boolean changePassword(Integer memberIdx, String memberPw, String changePw);

	//개인정보 변경
	boolean changeInformation(MemberDto memberDto);

	//회원 탈퇴
	boolean quit(Integer memberIdx, String memberPw);
	
	//	아이디 중복 검사 
	MemberDto checkId(String memberId) throws Exception;
	
	//닉네임 중복 검사
	MemberDto checkNick(String memberNick) throws Exception;
}
