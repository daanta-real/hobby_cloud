package com.kh.hobbycloud.repository.place;

import java.util.List;

import com.kh.hobbycloud.entity.place.PlaceDto;
import com.kh.hobbycloud.vo.place.PlaceRegisterVO;

public interface PlaceDao {

	void delete(int gatherIdx);

	int getSequence();

	void insert(PlaceDto placeDto);

	PlaceRegisterVO get(int placeIdx);

	List<PlaceRegisterVO> list();

	boolean update(PlaceDto placeDto);

}
