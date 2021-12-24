package com.kh.hobbycloud.repository.gather;

import java.util.List;
import java.util.Map;

import com.kh.hobbycloud.entity.gather.GatherDto;

public interface GatherDao {
	 List<GatherDto> listSearch(Map<String,Object> param);
	 List<GatherDto> list();
	 void insert(GatherDto gatherDto);
}
