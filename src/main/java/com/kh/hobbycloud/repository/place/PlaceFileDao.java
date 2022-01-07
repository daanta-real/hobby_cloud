package com.kh.hobbycloud.repository.place;

import java.io.IOException;
import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import com.kh.hobbycloud.entity.place.PlaceFileDto;

public interface PlaceFileDao {

	void save(PlaceFileDto placeFileDto, MultipartFile multipartFile) throws IllegalStateException, IOException;

	PlaceFileDto getNo(int placeFileIdx);

	List<PlaceFileDto> getIdx(int placeIdx);

	byte[] load(int placeFileIdx) throws IOException;
	//파일삭제
	boolean delete(int placeIdx);
	//실시간삭제
	boolean deleteAjax(int placeFileIdx);

}
