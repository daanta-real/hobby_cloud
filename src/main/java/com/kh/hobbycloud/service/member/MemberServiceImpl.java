package com.kh.hobbycloud.service.member;

import java.io.IOException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.kh.hobbycloud.entity.member.MemberDto;
import com.kh.hobbycloud.entity.member.MemberProfileDto;
import com.kh.hobbycloud.repository.member.MemberDao;
import com.kh.hobbycloud.repository.member.MemberProfileDao;
import com.kh.hobbycloud.vo.member.MemberJoinVO;

@Service
public class MemberServiceImpl implements MemberService{

	@Autowired
	private MemberDao memberDao;
	
	@Autowired
	private MemberProfileDao memberProfileDao;

	@Override
	public void join(MemberJoinVO memberJoinVO) throws IllegalStateException, IOException {
		//(필수) 회원정보를 뽑아서 회원테이블에 저장
		//= memberJoinVO에서 정보를 뽑아서 memberDto를 생성하고 설정
		MemberDto memberDto = new MemberDto();
		memberDto.setMemberIdx(memberJoinVO.getMemberIdx());
		memberDto.setMemberId(memberJoinVO.getMemberId());
		memberDto.setMemberPw(memberJoinVO.getMemberPw());
		memberDto.setMemberNick(memberJoinVO.getMemberNick());
		memberDto.setMemberEmail(memberJoinVO.getMemberEmail());
		memberDto.setMemberPhone(memberJoinVO.getMemberPhone());
		memberDto.setMemberRegion(memberJoinVO.getMemberRegion());
		memberDao.join(memberDto);
		
		//회원관심분야 정보 뽑아서 회원 테이블에 저장
		// memberJoinVO 안에 List<String> lecCategoryName이 들어있다.
//		List<Integer> categoryList = memberJoinVO.getLecCategoryName();
//		categoryList.add()

		//(선택) 회원이미지 정보를 뽑아서 이미지 테이블과 실제 하드디스크에 저장
		MultipartFile multipartFile = memberJoinVO.getAttach();
		if(!multipartFile.isEmpty()) {
			MemberProfileDto memberProfileDto = new MemberProfileDto();
			memberProfileDto.setMemberProfileUploadname(multipartFile.getOriginalFilename());
			memberProfileDto.setMemberProfileType(multipartFile.getContentType());
			memberProfileDto.setMemberProfileSize(multipartFile.getSize());
			memberProfileDao.save(memberProfileDto, multipartFile);
		}
	}

}



