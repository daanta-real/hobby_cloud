package com.kh.hobbycloud.repository.gather;

import java.io.IOException;

import org.springframework.web.multipart.MultipartFile;

import com.kh.hobbycloud.entity.gather.GatherFileDto;

public interface GatherFileDao {
	void save(GatherFileDto gatherFileDto, MultipartFile multipartFile) throws IllegalStateException, IOException;
	GatherFileDto getNo(int gatherFileIdx);
	GatherFileDto getIdx(int gatherIdx);
	byte[] load(int gatherFileIdx) throws IOException;
}
