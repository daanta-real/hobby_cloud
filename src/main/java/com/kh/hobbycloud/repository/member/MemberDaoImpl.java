package com.kh.hobbycloud.repository.member;

import java.util.HashMap;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Repository;

import com.kh.hobbycloud.entity.member.MemberDto;


@Repository
public class MemberDaoImpl implements MemberDao{

	// 변수선언부
	@Autowired
	private SqlSession sqlSession;

	@Autowired
	private PasswordEncoder encoder;

	// 단일조회 - ID 기준
	@Override
	public MemberDto get(String memberId) {
		return sqlSession.selectOne("member.get", memberId);
	}

	// 단일조회 - IDX 기준
	@Override
	public MemberDto get(Integer memberIdx) {
		return sqlSession.selectOne("member.get", memberIdx);
	}

	// 비밀번호 검사 후 로그인까지 처리하는 메소드
	@Override
	public MemberDto login(MemberDto memberDto) {

		// ID와 비밀번호를 입력하였으므로, IDX가 아니라 ID로 조회해야 함
		MemberDto findDto = sqlSession.selectOne("member.get", memberDto.getMemberId());

		// 해당 아이디의 회원정보가 존재 && 입력 비밀번호와 조회된 비밀번호가 같다면 => 로그인 성공(객체를 반환)
		if(findDto != null && encoder.matches(memberDto.getMemberPw(), findDto.getMemberPw())) {
			return findDto;
		}
		else {//아니면 null을 반환
			return null;
		}
	}

	// 가입 처리
	@Override
	public void join(MemberDto memberDto) {
		String origin = memberDto.getMemberPw();
		String encrypt = encoder.encode(origin);
		memberDto.setMemberPw(encrypt);

		sqlSession.insert("member.insert", memberDto);
	}

	// 비밀번호 변경
	@Override
	public boolean changePassword(Integer memberIdx, String memberPw, String changePw) {
		MemberDto memberDto = sqlSession.selectOne("member.get", memberIdx);
		if(encoder.matches(memberPw, memberDto.getMemberPw())) {
			Map<String, Object> param = new HashMap<>();
			param.put("memberIdx", memberIdx);
			param.put("changePw", encoder.encode(changePw)); // 변경할 비밀번호 암호화

			int count = sqlSession.update("member.changePassword", param);
			return count > 0;
		}
		else {
			return false;
		}
	}

	// 개인정보 변경 (비밀번호 제외)
	@Override
	public boolean changeInformation(MemberDto memberDto) {
		MemberDto findDto = sqlSession.selectOne("member.get", memberDto.getMemberIdx());
		if(encoder.matches(memberDto.getMemberPw(), findDto.getMemberPw())) {
			int count = sqlSession.update("member.changeInformation", memberDto);
			return count > 0;
		}
		else {
			return false;
		}
	}

	// 회원 탈퇴
	@Override
	public boolean quit(Integer memberIdx, String memberPw) {
		MemberDto findDto = sqlSession.selectOne("member.get", memberIdx);
		if(encoder.matches(memberPw, findDto.getMemberPw())) {
			int count = sqlSession.delete("member.quit", memberIdx);
			return count > 0;
		}
		else {
			return false;
		}
	}
}





