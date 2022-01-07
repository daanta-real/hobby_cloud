package com.kh.hobbycloud.service.notice;

import java.io.IOException;
import java.util.List;

import com.kh.hobbycloud.vo.gather.Criteria;
import com.kh.hobbycloud.vo.gather.GatherVO;
import com.kh.hobbycloud.vo.notice.NoticeVO;

public interface NoticeService {
	void save(NoticeVO noticeVO)throws IllegalStateException, IOException;
    

}
