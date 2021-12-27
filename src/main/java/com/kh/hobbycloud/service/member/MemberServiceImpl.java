package com.kh.hobbycloud.service.member;

import java.io.IOException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.hobbycloud.entity.member.MemberDto;
import com.kh.hobbycloud.repository.member.MemberDao;
import com.kh.hobbycloud.vo.member.MemberJoinVO;

@Service
public class MemberServiceImpl implements MemberService{

	@Autowired
	private MemberDao memberDao;

	@Override
	public void join(MemberJoinVO memberJoinVO) throws IllegalStateException, IOException {
		//(필수) 회원정보를 뽑아서 회원테이블에 저장
		//= memberJoinVO에서 정보를 뽑아서 memberDto를 생성하고 설정
		MemberDto memberDto = new MemberDto();
		memberDto.setMemberIdx(memberJoinVO.getMemberIdx());
		memberDto.setMemberGradeName(memberJoinVO.getMemberGradeName());
		memberDto.setMemberId(memberJoinVO.getMemberId());
		memberDto.setMemberPw(memberJoinVO.getMemberPw());
		memberDto.setMemberNick(memberJoinVO.getMemberNick());
		memberDto.setMemberEmail(memberJoinVO.getMemberEmail());
		memberDto.setMemberPhone(memberJoinVO.getMemberPhone());
		memberDao.join(memberDto);
		
		//회원관심분야 정보 뽑아서 회원 테이블에 저장
		// memberJoinVO 안에 List<String> lecCategoryName이 들어있다.
		List<Integer> categoryList = memberJoinVO.getLecCategoryName();
//		categoryList.add()

		//(선택) 회원이미지 정보를 뽑아서 이미지 테이블과 실제 하드디스크에 저장
//		MultipartFile multipartFile = memberJoinVO.getAttach();
//		if(!multipartFile.isEmpty()) {//파일이 있으면
//			MemberProfileDto memberProfileDto = new MemberProfileDto();
//			memberProfileDto.setMemberProfileUploadname(multipartFile.getOriginalFilename());
//			memberProfileDto.setMemberProfileType(multipartFile.getContentType());
//			memberProfileDto.setMemberProfileSize(multipartFile.getSize());
//			memberProfileDao.save(memberProfileDto, multipartFile);
//		}
	}

}



