package com.kh.hobbycloud.service.petitions;

import java.io.IOException;

import com.kh.hobbycloud.vo.petitions.PetitionsVO;

public interface PetitionsService {
	void save(PetitionsVO petitionsVO)throws IllegalStateException, IOException;

}
