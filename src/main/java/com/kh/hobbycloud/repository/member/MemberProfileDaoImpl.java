package com.kh.hobbycloud.repository.member;

import java.io.File;
import java.io.IOException;

import org.apache.commons.io.FileUtils;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.web.multipart.MultipartFile;

import com.kh.hobbycloud.entity.member.MemberProfileDto;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Repository
public class MemberProfileDaoImpl implements MemberProfileDao{

	// 변수 준비
	// MyBatis 객체	
	@Autowired
	private SqlSession sqlSession;
	
	// 프로필 첨부파일 저장 위치 문자열
	@Autowired
	private String STOREPATH_MEMBER;
	
	@Override
	public void save(MemberProfileDto memberProfileDto, MultipartFile multipartFile)
			throws IllegalStateException, IOException {
		
		//1. 시퀀스 번호 불러오기
		int sequence = sqlSession.selectOne("memberProfile.seq");

		//2. 실제 파일 업로드 폴더에 저장
		File target = new File(STOREPATH_MEMBER, String.valueOf(sequence));
		multipartFile.transferTo(target);

		//3. 파일 정보를 DB에 저장한다.
		memberProfileDto.setMemberProfileIdx(sequence);
		memberProfileDto.setMemberProfileSavename(String.valueOf(sequence));
		sqlSession.insert("memberProfile.save", memberProfileDto);
	}
	
	// 한 개의 프로필 첨부파일 Dto 얻기
	@Override
	public MemberProfileDto getMemberProfileIdx(int memberProfileIdx) {
		return sqlSession.selectOne("memberProfile.get", memberProfileIdx);
	}
	
	// memberIdx로 memberProfileDto 불러오기
	@Override
	public MemberProfileDto getByMemberIdx(int memberIdx) {
		return sqlSession.selectOne("memberProfile.getByIdx", memberIdx);
	}

	
	// 한 개의 프로필파일 데이터를 회신
	@Override
	public byte[] load(String memberProfileSavename) throws IOException {
		File target = new File(STOREPATH_MEMBER, String.valueOf(memberProfileSavename));
		byte[] data = FileUtils.readFileToByteArray(target);
		return data;
		}
	
	// 삭제
	@Override
	public void delete(int memberIdx) {
		log.debug("=================memberProfileDto 실행");
		sqlSession.delete("memberProfile.delete",memberIdx);		
	}
	
	//변경(프로필 Idx)
	@Override
	public void edit(MemberProfileDto memberProfileDto) {
		sqlSession.update("memberProfile.edit", memberProfileDto);
	}
	
	//프로필 사진 ajax 삭제
	@Override
	public boolean deleteAjax(int memberProfileIdx) {
		int count =sqlSession.delete("memberProfile.deleteAjax",memberProfileIdx);
		
		return count >0;
	}



}
