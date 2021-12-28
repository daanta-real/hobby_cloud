package com.kh.hobbycloud.repository.member;

import java.io.IOException;

import org.springframework.web.multipart.MultipartFile;

import com.kh.hobbycloud.entity.member.MemberProfileDto;

public interface MemberProfileDao {
	void save(MemberProfileDto memberProfileDto, MultipartFile multipartFile) throws IllegalStateException, IOException;
	MemberProfileDto getMemberProfileIdx(int memberProfileNo);
	MemberProfileDto getMemberIdx(int memberIdx);
	byte[] load(int memberProfileNo) throws IOException;
}
