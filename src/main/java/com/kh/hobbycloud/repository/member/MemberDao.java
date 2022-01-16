package com.kh.hobbycloud.repository.member;

import java.util.List;

import com.kh.hobbycloud.entity.member.MemberDto;
import com.kh.hobbycloud.vo.member.MemberCriteria;
import com.kh.hobbycloud.vo.member.MemberJoinVO;
import com.kh.hobbycloud.vo.member.MemberListVO;
import com.kh.hobbycloud.vo.member.MemberSearchVO;

public interface MemberDao {

	// 가입
	void join(MemberDto memberDto);

	// 단일조회(memberId)
	MemberDto get(String memberId);
	
	//단일조회(memberIdx)
	MemberDto getByIdx(Integer memberIdx);

	//memberJoinVO  단일 조회
	MemberJoinVO getVO(Integer memberIdx);

	// 비밀번호 검사까지 통과 로그인
	MemberDto login(MemberDto memberDto);

	// 비밀번호 변경
	boolean changePassword(Integer memberIdx, String memberPw, String changePw);

	// 개인정보 변경
	boolean changeInformation(MemberDto memberDto);

	// 개인정보 변경(이메일)
	int changeEmail(String memberEmail, Integer memberIdx);

	// 회원 탈퇴
	boolean quit(Integer memberIdx, String memberPw);


	//일반회원 등급을 강사로
	void changeGradeTutor(int memberIdx);
	//강사를 일반회원으로
	void changeGradeNormal(int memberIdx);
	//임대인 등급 변경 기능
	void changeGradeLandlord(int memberIdx);

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

	//회원 목록 조회
	List<MemberListVO> list(MemberCriteria cri);
	//회원 총개수
	int listCount();
	//회원 검색
	List<MemberListVO> listSearch(MemberSearchVO memberSearchVO);
	//회원 페이지 목록
	List<MemberListVO> listPage(int startRow, int endRow);

	// *포인트 관련*
	// 특정 회원의 포인트 증감 처리
	boolean pointModify(MemberDto memberDto);
	// 특정 회원의 포인트를 특정 값으로 강제변경
	boolean pointForceToValue(MemberDto memberDto);

	List<MemberListVO> list();

	List<MemberListVO> search(String column, String keyword);




}
