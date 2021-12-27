package com.kh.hobbycloud.repository.lec;

import java.io.IOException;

import org.springframework.web.multipart.MultipartFile;

import com.kh.hobbycloud.entity.lec.LecFileDto;


public interface LecFileDao {
	void save(LecFileDto lecFileDto, MultipartFile multipartFile) throws IllegalStateException, IOException;
	LecFileDto get(int lecFileIdx);
	LecFileDto getbyIdx(int lecIdx);
	byte[] load(int lecFileIdx) throws IOException;
}
