package com.temp.repository;

import java.io.File;
import java.io.IOException;

import org.apache.commons.io.FileUtils;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.web.multipart.MultipartFile;

import com.temp.entity.UserProfileDto;

@Repository
public class UserProfileDaoImpl implements UserProfileDao{

	@Autowired
	private SqlSession sqlSession;

	//저장용 폴더
	private File directory = new File("D:/upload/user");

	/**
	 * 등록 절차
	 * 1. 시퀀스 번호를 구해온다.
	 * 2. 실제 파일을 시퀀스 번호로 저장한다.
	 * 3. 파일 정보를 DB에 저장한다.
	 */
	@Override
	public void save(UserProfileDto userProfileDto, MultipartFile multipartFile) throws IllegalStateException, IOException {
		//1
		int sequence = sqlSession.selectOne("userProfile.seq");

		//2
		File target = new File(directory, String.valueOf(sequence));
		multipartFile.transferTo(target);

		//3
		userProfileDto.setUserProfileNo(sequence);
		userProfileDto.setUserProfileSavename(String.valueOf(sequence));
		sqlSession.insert("userProfile.save", userProfileDto);
	}

	@Override
	public UserProfileDto get(int userProfileNo) {
		return sqlSession.selectOne("userProfile.get", userProfileNo);
	}

	@Override
	public byte[] load(int userProfileNo) throws IOException {
		File target = new File(directory, String.valueOf(userProfileNo));
		byte[] data = FileUtils.readFileToByteArray(target);
		return data;
	}

	@Override
	public UserProfileDto get(String userId) {
		return sqlSession.selectOne("userProfile.getById", userId);
	}

}





