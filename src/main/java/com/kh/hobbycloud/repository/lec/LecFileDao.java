package com.kh.hobbycloud.repository.lec;

import java.io.IOException;
import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import com.kh.hobbycloud.entity.lec.LecFileDto;


public interface LecFileDao {
	void save(LecFileDto lecFileDto, MultipartFile multipartFile) throws IllegalStateException, IOException;
	LecFileDto get(int lecFileIdx);
	LecFileDto getByIdx(int lecIdx);
	byte[] load(int lecFileIdx) throws IOException;
	List<LecFileDto> getByLecIdx_list(int lecIdx);
}
