package com.kh.hobbycloud.repository.lec;

import java.io.IOException;
import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import com.kh.hobbycloud.entity.lec.LecFileDto;


public interface LecFileDao {
	void save(LecFileDto lecFileDto, MultipartFile multipartFile) throws IllegalStateException, IOException;
	LecFileDto get(int lecFileIdx);
	List<LecFileDto> getByIdx(int lecIdx);
	byte[] load(int lecFileIdx) throws IOException;
	List<LecFileDto> getByLecIdx_list(int lecIdx);
	//파일삭제
	boolean delete(int lecIdx);
	//실시간삭제
	boolean deleteAjax(int lecFileIdx);
}
