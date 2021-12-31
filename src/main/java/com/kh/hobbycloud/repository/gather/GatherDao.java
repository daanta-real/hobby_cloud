 package com.kh.hobbycloud.repository.gather;


import java.util.List;
import java.util.Map;

import com.kh.hobbycloud.entity.gather.GatherDto;
import com.kh.hobbycloud.vo.gather.GatherSearchVO;
import com.kh.hobbycloud.vo.gather.GatherVO;



public interface GatherDao {
	 List<GatherVO> listSearch(List<GatherSearchVO> categorys);
	 List<GatherVO> list();
	 void insert(GatherDto gatherDto);
	 GatherVO get(int gatherIdx);
	 int  getSequence();
	 void delete(int gatherIdx);
//	 List<GatherVO> getUpdate(int gatherIdx);
	 boolean update(GatherDto gatherDto);
}
