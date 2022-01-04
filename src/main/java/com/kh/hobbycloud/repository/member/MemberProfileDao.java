package com.kh.hobbycloud.repository.member;

import java.io.IOException;

import org.springframework.web.multipart.MultipartFile;

import com.kh.hobbycloud.entity.member.MemberProfileDto;

public interface MemberProfileDao {
	//저장
	void save(MemberProfileDto memberProfileDto, MultipartFile multipartFile) throws IllegalStateException, IOException;
	//memberProfileId 조회
	MemberProfileDto getMemberProfileIdx(int memberProfileIdx);
	//memberIdx 조회
	MemberProfileDto getByMemberIdx(int memberIdx);
	//memberProfileSavename의 이름의 프로필파일 데이터를 회신
	byte[] load(String memberProfileSavename) throws IOException;
	//삭제
	void delete(int memberIdx);
}
