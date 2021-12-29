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
	private File directory = new File("D:/upload/member");
	
	@Override
	public void save(MemberProfileDto memberProfileDto, MultipartFile multipartFile)
			throws IllegalStateException, IOException {
		
		//1. 시퀀스 번호 불러오기
		int sequence = sqlSession.selectOne("memberProfile.seq");

		//2. 실제 파일 시퀀스 번호로 저장
		File target = new File(directory, String.valueOf(sequence));
		multipartFile.transferTo(target);

		//3. 파일 정보를 DB에 저장한다.
		memberProfileDto.setMemberProfileIdx(sequence);
		memberProfileDto.setMemberProfileSavename(String.valueOf(sequence));
		sqlSession.insert("memberProfile.save", memberProfileDto);
	}

	@Override
	public MemberProfileDto getMemberProfileIdx(int memberProfileIdx) {
		return sqlSession.selectOne("memberProfile.get", memberProfileIdx);
	}

	@Override
	public MemberProfileDto getByMemberIdx(int memberIdx) {
		return sqlSession.selectOne("memberProfile.getById", memberIdx);
	}
	
	@Override
	public byte[] load(String memberProfileSavename) throws IOException {
		File target = new File(directory, String.valueOf(memberProfileSavename));
		byte[] data = FileUtils.readFileToByteArray(target);
		return data;}

	@Override
	public MemberProfileDto getIdx(int memberIdx) {
		return sqlSession.selectOne("memberProfile.getIdx", memberIdx);
	}


}
