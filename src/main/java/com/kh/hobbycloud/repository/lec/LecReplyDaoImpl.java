package com.kh.hobbycloud.repository.lec;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.hobbycloud.entity.lec.LecDto;
import com.kh.hobbycloud.entity.lec.LecReplyDto;
import com.kh.hobbycloud.vo.lec.LecReplyVO;

@Repository
public class LecReplyDaoImpl implements LecReplyDao{
	
	@Autowired
	private SqlSession sqlSession;
	
	//댓글 리스트
	@Override
	public List<LecReplyVO> replyList(int lecIdx) {
		return sqlSession.selectList("lecReply.replyList", lecIdx);
	}
	
	//댓글 작성
	@Override
	public LecDto lecWriteReply(LecReplyVO lecReplyVO) {
		//lec 테이블에 해당 강좌의 reply 수를 +1 하기위한 lecReplyVO 세팅
		LecDto lecDto = new LecDto();
		lecDto.setLecIdx(lecReplyVO.getLecIdx());
		
		//강좌 댓글의 수 +1
		sqlSession.update("lec.replyUp", lecReplyVO);
		
		//현재 lecReply 테이블의 가장 큰 lecReplyIdx값을 가져온다.
		int lecReplyGroupno = sqlSession.selectOne("lecReply.getReplyMaxNo");
		
		//lecReplyGroupno 세팅
		lecReplyVO.setLecReplyGroupno(lecReplyGroupno + 1);
		
		//lecReply 테이블에 추가
		int result = sqlSession.insert("lecReply.replyWrite", lecReplyVO);
		
		int check = sqlSession.selectOne("lecReply.getReplyMaxNo");
		//lecReplyGroupno를 현재 가장 큰 lecReplyIdx, 즉 방금 넣은 데이터의 lecReplyIdx값으로 세팅
		lecReplyVO.setLecReplyGroupno(check);
		
		//lecReplyIdx 와 lecReplyGroupno가 다르면 lecReplyGroupno를 lecReplyIdx로 업데이트
		int check_update = sqlSession.update("lecReply.replyCheck", lecReplyVO);
		
		if(result == 1) {//lecReply 테이블에 새로운 댓글 추가가 성공하면
			//갱신된 댓글 갯수를 가져오기
			lecDto = sqlSession.selectOne("lec.replyCount", lecDto);
		}
		
		return lecDto;
	}
	
	//대댓글 작성
	@Override
	public LecDto lecWriteReReply(LecReplyVO lecReplyVO) {
		//lec 테이블에 해당 강좌의 reply 수를 +1 하기위한 lecReplyVO 세팅
		LecDto lecDto = new LecDto();
		lecDto.setLecIdx(lecReplyVO.getLecIdx());
		
		//강좌 댓글의 수 +1
		sqlSession.update("lec.replyUp", lecReplyVO);
		
		//lecReply 테이블에 추가
		int result = sqlSession.insert("lecReply.rereplyWrite", lecReplyVO);
		
		if(result == 1) {//lecReply 테이블에 새로운 댓글 추가가 성공하면
			//갱신된 댓글 갯수를 가져오기
			lecDto = sqlSession.selectOne("lec.replyCount", lecDto);
		}
		
		return lecDto;
	}
	
	//모댓글 삭제
	@Override
	public LecDto lecDeleteReply(LecReplyVO lecReplyVO) {
		//lec 테이블에 해당 강좌의 reply 수를 -1 하기위한 lecReplyVO 세팅
		LecDto lecDto = new LecDto();
		lecDto.setLecIdx(lecReplyVO.getLecIdx());
		
		// lecReplyGroupno가 reply의 lecReplyIdx와 일치하는 댓글이 몇갠지 카운트한다. 모댓글에 딸린 답글이 몇갠지 카운트하기 위함
		int count_rereply = sqlSession.selectOne("lecReply.rereplyCount", lecReplyVO);
		
		int result = 0;
		
		//해당 강좌의 reply를 -1 한다
		sqlSession.update("lec.replyDown", lecReplyVO);
		
		if(count_rereply==0) {//답글이 없을때 - 바로 삭제
			//lecReply 테이블에서 삭제
			result = sqlSession.delete("lecReply.replyDelete", lecReplyVO);
		}else {
			//lecReply 테이블에서 삭제하지 않고 lecReplyDetail에 공백을 넣기
			result = sqlSession.update("lecReply.replyNotDelete", lecReplyVO);
		}
		
		if(result == 1) {//lecReply 테이블에서 댓글 삭제가 성공하면
			//갱신된 댓글 수 가져옴
			lecDto = sqlSession.selectOne("lec.replyCount", lecDto);	
		}
		return lecDto;
	}
	
	//대댓글 삭제
	@Override
	public LecDto lecDeleteReReply(LecReplyVO lecReplyVO) {
		//lec 테이블에 해당 강좌의 reply 수를 -1 하기위한 lecReplyVO 세팅
		LecDto lecDto = new LecDto();
		lecDto.setLecIdx(lecReplyVO.getLecIdx());
		
		//해당 강좌의 reply를 -1 한다
		sqlSession.update("lec.replyDown", lecReplyVO);
		
		//lecReply 테이블에서 삭제
		int result = sqlSession.delete("lecReply.replyDelete", lecReplyVO);
		
		// lecReplyGroupno가 일치하는 대댓글이 몇갠지 카운트한다. 모댓글에 lecReplyDetail이 ""이면 모댓글을 삭제하기 위함
		int count_rereply = sqlSession.selectOne("lecReply.rereplyCountFromRereply", lecReplyVO);
		
		System.out.println("count_rereply = " + count_rereply);
		
		if(count_rereply==0) {
			sqlSession.delete("lecReply.replyDeleteAfterRereplyDelete", lecReplyVO);
		}
		
		if(result == 1) {//lecReply 테이블에서 댓글 삭제가 성공하면
			//갱신된 댓글 수 가져옴
			lecDto = sqlSession.selectOne("lec.replyCount", lecDto);	
		}
		return lecDto;
	}
	
	
}
