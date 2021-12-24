package com.kh.hobbycloud.repository.member;

import java.util.HashMap;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Repository;

import com.kh.hobbycloud.entity.member.MemberDto;



@Repository
public class MemberDaoWithEncrypt implements MemberDao{

	@Autowired
	private SqlSession sqlSession;

	@Autowired
	private PasswordEncoder encoder;

	@Override
	public MemberDto get(String UserId) {
		return sqlSession.selectOne("User.get", UserId);
	}

	@Override
	public MemberDto login(MemberDto UserDto) {
		MemberDto findDto = sqlSession.selectOne("User.get", UserDto.getUserId());

		//해당 아이디의 회원정보가 존재 && 입력 비밀번호와 조회된 비밀번호가 같다면 => 로그인 성공(객체를 반환)
		if(findDto != null && encoder.matches(UserDto.getUserPw(), findDto.getUserPw())) {
			return findDto;
		}
		else {//아니면 null을 반환
			return null;
		}
	}

	@Override
	public void join(MemberDto UserDto) {
		//UserDto 안에 들어있는 원본 비밀번호를 BCrypt로 암호화 하여 다시 설정
		String origin = UserDto.getUserPw();
		String encrypt = encoder.encode(origin);
		UserDto.setUserPw(encrypt);
		//변경된 정보를 가진 UserDto를 기존처럼 등록
		sqlSession.insert("User.insert", UserDto);
	}

	@Override
	public boolean changePassword(String UserId, String UserPw, String changePw) {
		//변경해야 할 내용
		//1. 비밀번호 검사는 무조건 encoder.matches()로 한다.
		//2. 변경할 비밀번호는 암호화를 한다.
		MemberDto UserDto = sqlSession.selectOne("User.get", UserId);
		if(encoder.matches(UserPw, UserDto.getUserPw())) {
			Map<String, Object> param = new HashMap<>();
			param.put("UserId", UserId);
			param.put("changePw", encoder.encode(changePw));//변경할 비밀번호 암호화

			int count = sqlSession.update("User.changePassword", param);
			return count > 0;
		}
		else {
			return false;
		}
	}

	@Override
	public boolean changeInformation(MemberDto UserDto) {
		//비밀번호 검사를 DAO에서 PasswordEncoder를 이용하여 수행하도록 변경
		MemberDto findDto = sqlSession.selectOne("User.get", UserDto.getUserId());
		if(encoder.matches(UserDto.getUserPw(), findDto.getUserPw())) {
			//일치하므로 변경 처리 지시
			int count = sqlSession.update("User.changeInformation", UserDto);
			return count > 0;
		}
		else {
			return false;
		}
	}

	@Override
	public boolean quit(String UserId, String UserPw) {
		MemberDto findDto = sqlSession.selectOne("User.get", UserId);
		if(encoder.matches(UserPw, findDto.getUserPw())) {
			int count = sqlSession.delete("User.quit", UserId);
			return count > 0;
		}
		else {
			return false;
		}
	}

}





