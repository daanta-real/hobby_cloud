package com.kh.hobbycloud.service;

import java.io.IOException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.kh.hobbycloud.entity.UserDto;
import com.kh.hobbycloud.entity.UserProfileDto;
import com.kh.hobbycloud.repository.member.UserDao;
import com.kh.hobbycloud.repository.member.UserProfileDao;
import com.kh.hobbycloud.vo.UserJoinVO;

@Service
public class UserServiceImpl implements UserService{

	@Autowired
	private UserDao userDao;

	@Autowired
	private UserProfileDao userProfileDao;

	@Override
	public void join(UserJoinVO userJoinVO) throws IllegalStateException, IOException {
		//(필수) 회원정보를 뽑아서 회원테이블에 저장
		//= userJoinVO에서 정보를 뽑아서 userDto를 생성하고 설정
		UserDto userDto = new UserDto();
		userDto.setUserId(userJoinVO.getUserId());
		userDto.setUserPw(userJoinVO.getUserPw());
		userDto.setUserNick(userJoinVO.getUserNick());
		userDto.setUserBirth(userJoinVO.getUserBirth());
		userDto.setUserEmail(userJoinVO.getUserEmail());
		userDto.setUserPhone(userJoinVO.getUserPhone());
		userDao.join(userDto);

		//(선택) 회원이미지 정보를 뽑아서 이미지 테이블과 실제 하드디스크에 저장
		MultipartFile multipartFile = userJoinVO.getAttach();
		if(!multipartFile.isEmpty()) {//파일이 있으면
			UserProfileDto userProfileDto = new UserProfileDto();
			userProfileDto.setUserId(userJoinVO.getUserId());
			userProfileDto.setUserProfileUploadname(multipartFile.getOriginalFilename());
			userProfileDto.setUserProfileType(multipartFile.getContentType());
			userProfileDto.setUserProfileSize(multipartFile.getSize());
			userProfileDao.save(userProfileDto, multipartFile);
		}
	}

}



