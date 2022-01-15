package com.kh.hobbycloud.repository.petitions;

import java.util.List;

import com.kh.hobbycloud.entity.petitions.PetitionsReplyDto;
import com.kh.hobbycloud.vo.petitions.PetitionsReplyVO;



public interface PetitionsReplyDao {
	//댓글 등록
		void insert(PetitionsReplyDto petitionsReplyDto);
		//댓글 조회
		List<PetitionsReplyVO> list(int petitionsIdx);
		//댓글 조회
		List<PetitionsReplyVO> listBy(int startRow,int endRow,int petitionsIdx);
		//댓글 삭제
		boolean delete (int petitionsReplyIdx);
		//댓글 수정
		void edit(PetitionsReplyDto petitionsReplyDto);

}
