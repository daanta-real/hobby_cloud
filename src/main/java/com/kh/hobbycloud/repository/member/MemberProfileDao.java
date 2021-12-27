package com.kh.hobbycloud.repository.member;

import java.io.IOException;

import org.springframework.web.multipart.MultipartFile;

import com.kh.hobbycloud.entity.member.MemberProfileDto;

public interface MemberProfileDao {
	void save(MemberProfileDto UserProfileDto, MultipartFile multipartFile) throws IllegalStateException, IOException;
	MemberProfileDto get(int UserProfileNo);
	MemberProfileDto get(String UserId);
	byte[] load(int UserProfileNo) throws IOException;
}
