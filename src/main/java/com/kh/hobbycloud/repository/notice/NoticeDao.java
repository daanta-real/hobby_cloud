package com.kh.hobbycloud.repository.notice;

import java.util.List;

import com.kh.hobbycloud.entity.notice.NoticeDto;
import com.kh.hobbycloud.vo.gather.Criteria;
import com.kh.hobbycloud.vo.notice.NoticeVO;

public interface NoticeDao {
	List<NoticeVO>list();
	NoticeVO get(int noticeIdx);
	void insert(NoticeDto noticeDto);
	void delete(int noticeIdx);
	boolean edit(NoticeVO noticeVO);
	int getsequences();
	List<NoticeVO>search(String column,String keyword);
	//조회수증가
	void views(int noticeIdx);
	void read(NoticeDto noticeDto);
	//페이지네이션
	List<NoticeVO> listPage(int startRow, int endRow);
	//게시글 목록 조회
	List<NoticeVO>list(Criteria cri);
	//게시글 총 개수
	int listCount();
	
	

}
