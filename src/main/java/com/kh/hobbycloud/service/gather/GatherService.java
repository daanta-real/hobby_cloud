package com.kh.hobbycloud.service.gather;

import java.io.IOException;

import com.kh.hobbycloud.vo.gather.GatherFileVO;

public interface GatherService {
int save(GatherFileVO gatherFileVO) throws IllegalStateException, IOException;

}
