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

	//일반회원 등급을 강사로
	void changeGradeTutor(int memberIdx);
	//강사를 일반회원으로
	void changeGradeNormal(int memberIdx);
	
}
