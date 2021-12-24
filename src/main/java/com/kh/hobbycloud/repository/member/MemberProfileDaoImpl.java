package com.kh.hobbycloud.repository.member;

import java.io.File;
import java.io.IOException;

import org.apache.commons.io.FileUtils;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.web.multipart.MultipartFile;

import com.kh.hobbycloud.entity.member.MemberProfileDto;

@Repository
public class MemberProfileDaoImpl implements MemberProfileDao{

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
	public void save(MemberProfileDto userProfileDto, MultipartFile multipartFile) throws IllegalStateException, IOException {
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
	public MemberProfileDto get(int userProfileNo) {
		return sqlSession.selectOne("userProfile.get", userProfileNo);
	}

	@Override
	public byte[] load(int userProfileNo) throws IOException {
		File target = new File(directory, String.valueOf(userProfileNo));
		byte[] data = FileUtils.readFileToByteArray(target);
		return data;
	}

	@Override
	public MemberProfileDto get(String userId) {
		return sqlSession.selectOne("userProfile.getById", userId);
	}

}





