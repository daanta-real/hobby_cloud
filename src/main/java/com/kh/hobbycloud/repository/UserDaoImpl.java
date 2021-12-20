package com.kh.hobbycloud.repository;

import java.util.HashMap;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;

import com.kh.hobbycloud.entity.UserDto;

//@Repository
public class UserDaoImpl implements UserDao{

	@Autowired
	private SqlSession sqlSession;

	@Override
	public UserDto get(String UserId) {
		return sqlSession.selectOne("User.get", UserId);
	}

	@Override
	public UserDto login(UserDto UserDto) {
		UserDto findDto = sqlSession.selectOne("User.get", UserDto.getUserId());

		//해당 아이디의 회원정보가 존재 && 입력 비밀번호와 조회된 비밀번호가 같다면 => 로그인 성공(객체를 반환)
		if(findDto != null && UserDto.getUserPw().equals(findDto.getUserPw())) {
			return findDto;
		}
		else {//아니면 null을 반환
			return null;
		}
	}

	@Override
	public void join(UserDto UserDto) {
		sqlSession.insert("User.insert", UserDto);
	}

	@Override
	public boolean changePassword(String UserId, String UserPw, String changePw) {
		Map<String, Object> param = new HashMap<>();
		param.put("UserId", UserId);
		param.put("UserPw", UserPw);
		param.put("changePw", changePw);
		int count = sqlSession.update("User.changePassword", param);
		return count > 0;
	}

	@Override
	public boolean changeInformation(UserDto UserDto) {
		int count = sqlSession.update("User.changeInformation", UserDto);
		return count > 0;
	}

	@Override
	public boolean quit(String UserId, String UserPw) {
//		Map<String, Object> param = new HashMap<>();
//		param.put("UserId", UserId);
//		param.put("UserPw", UserPw);
//		int count = sqlSession.delete("User.quit", param);

		UserDto UserDto = new UserDto();
		UserDto.setUserId(UserId);
		UserDto.setUserPw(UserPw);
		int count = sqlSession.delete("User.quit", UserDto);
		return count > 0;
	}

}





