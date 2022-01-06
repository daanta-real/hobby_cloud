package com.kh.hobbycloud.repository.lec;

import java.io.IOException;
import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import com.kh.hobbycloud.entity.lec.LecFileDto;


public interface LecFileDao {

	// CREATE
	void save(LecFileDto lecFileDto, MultipartFile multipartFile) throws IllegalStateException, IOException;

	// SELECT
	LecFileDto getByLecFileIdx(int lecFileIdx);
	List<LecFileDto> getListByLecIdx(int lecIdx);
	byte[] load(int lecFileIdx) throws IOException;

	// DELETE
	boolean delete(int lecIdx);
	boolean deleteAjax(int lecFileIdx);

}
