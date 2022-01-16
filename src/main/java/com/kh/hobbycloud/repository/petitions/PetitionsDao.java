package com.kh.hobbycloud.repository.petitions;

import java.util.List;

import com.kh.hobbycloud.entity.notice.NoticeDto;
import com.kh.hobbycloud.entity.petitions.PetitionsDto;
import com.kh.hobbycloud.vo.gather.Criteria;
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
	//페이지네이션
		List<PetitionsVO> listPage(int startRow, int endRow);
		//게시글 목록 조회
		List<PetitionsVO>list(Criteria cri);
		//게시글 총 개수
		int listCount();
		
	//댓글수 갱신
	boolean replyCount(PetitionsDto petitionsDto);

}
