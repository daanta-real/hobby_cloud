package com.kh.hobbycloud.repository.member;

import com.kh.hobbycloud.entity.member.MemberDto;

public interface MemberDao {

	void join(MemberDto memberDto);//가입

	MemberDto get(String memberId);//그냥 단일조회
	MemberDto login(MemberDto memberDto);//비밀번호 검사까지 통과하면 객체를 반환하도록 구현

	//비밀번호 변경
	boolean changePassword(String memberId, String memberPw, String changePw);
	//개인정보 변경
	boolean changeInformation(MemberDto memberDto);

	//회원 탈퇴
	boolean quit(String memberId, String memberPw);

}
