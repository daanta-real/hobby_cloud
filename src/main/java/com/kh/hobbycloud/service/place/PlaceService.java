package com.kh.hobbycloud.service.place;

import java.io.IOException;

import com.kh.hobbycloud.vo.place.PlaceEditVO;
import com.kh.hobbycloud.vo.place.PlaceFileVO;

public interface PlaceService {

	int save(PlaceFileVO placeFileVO) throws IllegalStateException, IOException;
	void update(PlaceEditVO placeEditVO) throws IllegalStateException, IOException;

}
