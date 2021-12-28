package com.kh.hobbycloud.service;

import java.io.IOException;

import com.kh.hobbycloud.vo.NoticeFileVO;

public interface NoticeService {
	void insert(NoticeFileVO noticeFileVO) throws IllegalStateException, IOException;

}
