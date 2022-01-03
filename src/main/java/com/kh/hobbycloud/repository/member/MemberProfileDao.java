package com.kh.hobbycloud.repository.member;

import java.io.IOException;

import org.springframework.web.multipart.MultipartFile;

import com.kh.hobbycloud.entity.member.MemberProfileDto;

public interface MemberProfileDao {
	void save(MemberProfileDto memberProfileDto, MultipartFile multipartFile) throws IllegalStateException, IOException;
	MemberProfileDto getMemberProfileIdx(int memberProfileIdx);
	MemberProfileDto getByMemberIdx(int memberIdx);
	byte[] load(String memberProfileSavename) throws IOException;
	MemberProfileDto getIdx(int memberIdx);
	void delete(int memberIdx);
}
