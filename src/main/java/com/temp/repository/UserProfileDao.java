package com.temp.repository;

import java.io.IOException;

import org.springframework.web.multipart.MultipartFile;

import com.temp.entity.UserProfileDto;

public interface UserProfileDao {
	void save(UserProfileDto UserProfileDto, MultipartFile multipartFile) throws IllegalStateException, IOException;
	UserProfileDto get(int UserProfileNo);
	UserProfileDto get(String UserId);
	byte[] load(int UserProfileNo) throws IOException;
}
