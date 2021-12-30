package com.kh.hobbycloud.service.member;

import java.io.IOException;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.kh.hobbycloud.entity.member.MemberDto;
import com.kh.hobbycloud.entity.member.MemberProfileDto;
import com.kh.hobbycloud.repository.member.MemberDao;
import com.kh.hobbycloud.repository.member.MemberProfileDao;
import com.kh.hobbycloud.vo.member.MemberJoinVO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class MemberServiceImpl implements MemberService{

	@Autowired
	private MemberDao memberDao;
	
	@Autowired
	private MemberProfileDao memberProfileDao;
	
	@Autowired
	private SqlSession sqlSession;

	@Override
	public void join(MemberJoinVO memberJoinVO) throws IllegalStateException, IOException {
		
		//1. 시퀀스 번호 불러오기
		int sequence = sqlSession.selectOne("member.seq");

		//회원정보를 뽑아서 회원테이블에 저장
		MemberDto memberDto = new MemberDto();
		memberDto.setMemberIdx(sequence);
		memberDto.setMemberId(memberJoinVO.getMemberId());
		memberDto.setMemberPw(memberJoinVO.getMemberPw());
		memberDto.setMemberNick(memberJoinVO.getMemberNick());
		memberDto.setMemberEmail(memberJoinVO.getMemberEmail());
		memberDto.setMemberPhone(memberJoinVO.getMemberPhone());
		memberDto.setMemberRegion(memberJoinVO.getMemberRegion());
		memberDto.setMemberGender(memberJoinVO.getMemberGender());
		memberDao.join(memberDto);
		
		//회원관심분야 정보 뽑아서 회원관심테이블에 저장
		// memberJoinVO 안에 List<String> lecCategoryName이 들어있다.
//		List<Integer> categoryList = memberJoinVO.getLecCategoryName();
//		categoryList.add()

		//(선택) 회원이미지 정보를 뽑아서 이미지 테이블과 실제 하드디스크에 저장
		MultipartFile multipartFile = memberJoinVO.getAttach();
		if(!multipartFile.isEmpty()) {
			log.debug("멀티파트 = {}", multipartFile);
			log.debug("memberDto  {}", memberJoinVO);
			MemberProfileDto memberProfileDto = new MemberProfileDto();
			memberProfileDto.setMemberIdx(sequence);
			memberProfileDto.setMemberProfileUploadname(multipartFile.getOriginalFilename());
			memberProfileDto.setMemberProfileType(multipartFile.getContentType());
			memberProfileDto.setMemberProfileSize(multipartFile.getSize());
			memberProfileDao.save(memberProfileDto, multipartFile);
		}
		
		
	}
	//아이디 중복 확인
	@Override
	public MemberDto checkId(String memberId) throws Exception {
		System.out.println("serviceImpl: " + memberId);
		return memberDao.checkId(memberId);
	}
	
	//닉네임 중복 확인
	@Override
	public MemberDto checkNick(String memberNick) throws Exception {
		System.out.println("serviceImpl: " + memberNick);
		return memberDao.checkNick(memberNick);
	}

}



