package com.kh.hobbycloud.service.member;

import java.io.IOException;
import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import com.kh.hobbycloud.entity.member.MemberDto;
import com.kh.hobbycloud.vo.member.MemberJoinVO;

public interface MemberService {
	//회원가입
	void join(MemberJoinVO memberJoinVO) throws IllegalStateException, IOException;
	
	//아이디 중복확인
	MemberDto checkId(String memberId) throws Exception;
	
	//닉네임 중복 확인
	MemberDto checkNick(String memberNick) throws Exception;
	
	//아이디 찾기(이메일)
	MemberDto idFindMail(String memberNick, String memberEmail);
	
	// 비밀번호 찾기(이메일)
	MemberDto pwFindMail(String memberId, String memberNick, String memberEmail);
	
	//회원 정보 수정
	void edit(MemberJoinVO memberJoinVO, MultipartFile attach) throws IllegalStateException, IOException;
	
	//회원 목록
	List<MemberJoinVO> list(MemberJoinVO memberJoinVO);

}