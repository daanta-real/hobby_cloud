package com.kh.hobbycloud.repository.petitions;

import java.io.IOException;
import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import com.kh.hobbycloud.entity.notice.NoticeFileDto;
import com.kh.hobbycloud.entity.petitions.PetitionsFileDto;

public interface PetitionsFileDao {
	void save(PetitionsFileDto petitionsFileDto, MultipartFile multipartFile) throws IllegalStateException, IOException;
	PetitionsFileDto getNo(int petitionsFileIdx);
	List<PetitionsFileDto> getIdx(int petitionsIdx);
	byte[] load(int petitionsFileIdx) throws IOException;

}
