package com.kh.hobbycloud.repository;

import com.kh.hobbycloud.entity.UserDto;

public interface UserDao {

	void join(UserDto memberDto);//가입

	UserDto get(String memberId);//그냥 단일조회
	UserDto login(UserDto memberDto);//비밀번호 검사까지 통과하면 객체를 반환하도록 구현

	//비밀번호 변경
	boolean changePassword(String memberId, String memberPw, String changePw);
	//개인정보 변경
	boolean changeInformation(UserDto memberDto);

	//회원 탈퇴
	boolean quit(String memberId, String memberPw);

}
