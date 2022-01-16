package com.kh.hobbycloud.service.notice;

import java.io.IOException;
import java.util.List;

import com.kh.hobbycloud.vo.gather.Criteria;
import com.kh.hobbycloud.vo.notice.NoticeEditVO;
import com.kh.hobbycloud.vo.notice.NoticeFileVO;
import com.kh.hobbycloud.vo.notice.NoticeVO;

public interface NoticeService {
	void save(NoticeVO noticeVO)throws IllegalStateException, IOException;
	int save(NoticeFileVO noticeFileVO) throws IllegalStateException, IOException;
	/*void edit(NoticeVO noticeVO) throws IllegalStateException, IOException;*/
	void edit(NoticeEditVO noticeEditVO) throws IllegalStateException, IOException;
    
	//게시물 목록 조회
	List<NoticeVO> list(Criteria cri);
	//게시물 총 갯수
	int listCount();

}
