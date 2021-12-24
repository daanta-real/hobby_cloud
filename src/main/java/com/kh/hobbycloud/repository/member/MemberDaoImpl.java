package com.kh.hobbycloud.repository.member;

import java.util.HashMap;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;

import com.kh.hobbycloud.entity.member.MemberDto;


//@Repository
public class MemberDaoImpl implements MemberDao{

	@Autowired
	private SqlSession sqlSession;

	//단일조회
	@Override
	public MemberDto get(int memberIdx) {
		return sqlSession.selectOne("member.get", memberIdx);
	}
	
	//비밀번호 검사까지 통과 로그인
	@Override
	public MemberDto login(MemberDto memberDto) {
		MemberDto findDto = sqlSession.selectOne("member.get", memberDto.getMemberId());

		//해당 아이디의 회원정보가 존재 && 입력 비밀번호와 조회된 비밀번호가 같다면 => 로그인 성공(객체를 반환)
		if(findDto != null && memberDto.getMemberPw().equals(findDto.getMemberPw())) {
			return findDto;
		}
		else {//아니면 null을 반환
			return null;
		}
	}
	
	//가입
	@Override
	public void join(MemberDto memberDto) {
		sqlSession.insert("member.insert", memberDto);
	}

	//비밀번호 변경
	@Override
	public boolean changePassword(String memberId, String memberPw, String changePw) {
		Map<String, Object> param = new HashMap<>();
		param.put("memberId", memberId);
		param.put("memberPw", memberPw);
		param.put("changePw", changePw);
		int count = sqlSession.update("member.changePassword", param);
		return count > 0;
	}
	
	//개인정보 변경
	@Override
	public boolean changeInformation(MemberDto memberDto) {
		int count = sqlSession.update("member.changeInformation", memberDto);
		return count > 0;
	}

	//회원 탈퇴
	@Override
	public boolean quit(String memberId, String memberPw) {
//		Map<String, Object> param = new HashMap<>();
//		param.put("memberId", memberId);
//		param.put("memberPw", memberPw);
//		int count = sqlSession.delete("member.quit", param);

		MemberDto memberDto = new MemberDto();
		memberDto.setMemberId(memberId);
		memberDto.setMemberPw(memberPw);
		int count = sqlSession.delete("member.quit", memberDto);
		return count > 0;
	}

}





