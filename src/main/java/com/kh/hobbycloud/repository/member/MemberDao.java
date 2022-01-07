package com.kh.hobbycloud.repository.member;

import com.kh.hobbycloud.entity.member.MemberDto;
import com.kh.hobbycloud.vo.member.MemberJoinVO;

public interface MemberDao {

	// 가입
	void join(MemberDto memberDto);

	// 단일조회(memberId)
	MemberDto get(String memberId);
	//단일조회(memberIdx)
	MemberDto get(Integer memberIdx);
	
	//memberJoinVO  단일 조회
	MemberJoinVO getVO(Integer memberIdx);

	// 비밀번호 검사까지 통과 로그인
	MemberDto login(MemberDto memberDto);

	// 비밀번호 변경
	boolean changePassword(Integer memberIdx, String memberPw, String changePw);

	// 개인정보 변경
	boolean changeInformation(MemberDto memberDto);
	
	// 개인정보 변경(이메일)
	int changeEmail(MemberDto memberDto);	

	// 회원 탈퇴
	boolean quit(Integer memberIdx, String memberPw);

	// 아이디 중복 검사
	MemberDto checkId(String memberId) throws Exception;

	// 닉네임 중복 검사
	MemberDto checkNick(String memberNick) throws Exception;

	//아이디찾기(이메일) 
	MemberDto idFindMail(String memberNick, String memberEmail);

	//비밀번호 찾기(이메일) 
	MemberDto pwFindMail(String memberId, String memberNick, String memberEmail);
	
	//임시 비밀번호 변경
	boolean tempPw(MemberDto memberDto, String ChangePw);

}
