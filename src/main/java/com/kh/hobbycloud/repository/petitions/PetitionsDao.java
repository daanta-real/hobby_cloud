package com.kh.hobbycloud.repository.petitions;

import java.util.List;

import com.kh.hobbycloud.entity.notice.NoticeDto;
import com.kh.hobbycloud.entity.petitions.PetitionsDto;
import com.kh.hobbycloud.vo.notice.NoticeVO;
import com.kh.hobbycloud.vo.petitions.PetitionsVO;

public interface PetitionsDao {
	List<PetitionsVO>list();
	PetitionsVO get(int petitionsIdx);
	void insert(PetitionsDto petitionsDto);
	void delete(int petitionsIdx);
	boolean edit(PetitionsVO petitionsVO);
	int getsequences();
	List<PetitionsVO>search(String column,String keyword);
	void views(int petitionsIdx);
	void read(PetitionsDto petitionsDto);

}
