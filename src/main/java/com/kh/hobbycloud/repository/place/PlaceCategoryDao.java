package com.kh.hobbycloud.repository.place;

import java.util.List;

import com.kh.hobbycloud.entity.place.PlaceTargetDto;

public interface PlaceCategoryDao {

	public void insert(PlaceTargetDto placeTargetDto);

	public List<String> select();

	boolean update(PlaceTargetDto placeTargetDto);
	
	void delete(PlaceTargetDto placeTargetDto);

}
