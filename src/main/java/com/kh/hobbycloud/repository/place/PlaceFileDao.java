package com.kh.hobbycloud.repository.place;

import java.io.IOException;
import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import com.kh.hobbycloud.entity.place.PlaceFileDto;

public interface PlaceFileDao {
	
	// CREATE
	void save(PlaceFileDto placeFileDto, MultipartFile multipartFile) throws IllegalStateException, IOException;
	
	// SELECT
	PlaceFileDto getByPlaceFileIdx(int placeFileIdx);
	List<PlaceFileDto> getListByPlaceIdx(int placeIdx);
	byte[] load(int placeFileIdx) throws IOException;
	
	// DELETE
	boolean delete(int placeIdx);
	boolean deleteAjax(int placeFileIdx);
	boolean deleteList(int placeIdx, List<String> placeFileDelTargetList);

}
