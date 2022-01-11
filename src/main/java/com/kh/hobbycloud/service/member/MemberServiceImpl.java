package com.kh.hobbycloud.service.member;

import java.io.File;
import java.io.IOException;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.kh.hobbycloud.entity.member.MemberDto;
import com.kh.hobbycloud.entity.member.MemberProfileDto;
import com.kh.hobbycloud.repository.member.MemberCategoryDao;
import com.kh.hobbycloud.repository.member.MemberDao;
import com.kh.hobbycloud.repository.member.MemberProfileDao;
import com.kh.hobbycloud.vo.member.MemberCriteria;
import com.kh.hobbycloud.vo.member.MemberJoinVO;
import com.kh.hobbycloud.vo.member.MemberListVO;

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
	
	@Autowired
	private MemberCategoryDao memberCategoryDao;
	
	// 프로필 첨부파일 저장 위치 문자열
	@Autowired
	private String STOREPATH_MEMBER;
	
	//회원 가입
	@Override
	public void join(MemberJoinVO memberJoinVO) throws IllegalStateException, IOException {
		
		//1. 시퀀스 번호 불러오기
		int sequence = sqlSession.selectOne("member.seq");
		log.debug("sequence:"+sequence);

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
		
//		//회원관심분야 정보 뽑아서 회원관심테이블에 저장
//		// memberJoinVO 안에 List<String> lecCategoryName이 들어있다.
//		List<String> lecCategoryName = memberJoinVO.getLecCategoryName();
//		System.out.println("그냥 밖에"+ lecCategoryName.toString());
//		//관심분야 선택했는지 확인. 선택 안했으면 저장 생략
//		if (lecCategoryName.size() > 0) {
//			//회원관심분야에 대한 DTO 생성
//			MemberCategoryDto memberCategoryDto = new MemberCategoryDto();
//
//			memberCategoryDto.setMemberIdx(sequence);
//			log.debug("DTO DATA B4 = {}", memberCategoryDto);
//			log.debug("catName = {}", lecCategoryName);
//			log.debug("GETTER 확인 = {}", memberCategoryDto.getLecCategoryName());
//			memberCategoryDto.setLecCategoryName(lecCategoryName);
//			//관심분야 DB에 저장
//			log.debug("DTO DATA AFTR = {}", memberCategoryDto);
//			memberCategoryDao.save(memberCategoryDto);			
//		}

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
	
	//회원 수정
	@Override
	public void edit(MemberJoinVO memberJoinVO, MultipartFile attach) throws IllegalStateException, IOException {
		log.debug("======================== MemberService.edit(memberJoinVO)가 실행되었습니다.");		
		//검사값 false를 변수에 담고
		boolean check = false;
		//파일이 있는지 없는 체크
		MultipartFile multipartFile = attach;
		//만약 파일이 비어있지 않다면
		if(!multipartFile.isEmpty()) {
			log.debug("파일 정보를 담고 있는 MultipartFile attach 값이 존재합니다. attach 정보 = {}", attach);
			check = true;
		}
		//파일이 있다면 기존 파일을 삭제하고 새로운 파일을 추가
		if(check) {
			log.debug("파일 정보를 담고 있는 MultipartFile attach가 존재합니다. 파일을 삭제하겠습니다.");
			//해당 번호에 파일 업로드 되어 있는지 확인한다			
			MemberProfileDto memberProfileDto = memberProfileDao.getByMemberIdx(memberJoinVO.getMemberIdx());
			log.debug("================memberJoinVO"+memberJoinVO.toString());
			if(memberProfileDto != null) {
				//파일이 있다면 삭제
					log.debug("파일 정보를 담고 있는 memberProfileDto 존재합니다."+memberProfileDto.toString());
					File target = new File(STOREPATH_MEMBER, String.valueOf(memberProfileDto.getMemberProfileSavename()));
					target.delete();
					//테이블에서도 파일 삭제
					memberProfileDao.delete(memberJoinVO.getMemberIdx());
				} 
			}
				//새로운 파일이 들어온 것으로 수정해준다.
		
				if(!multipartFile.isEmpty()) {
						log.debug("멀티파트 = {}", multipartFile);
						log.debug("memberDto  {}", memberJoinVO);
						MemberProfileDto memberProfileDto = new MemberProfileDto();
						memberProfileDto.setMemberIdx(memberJoinVO.getMemberIdx());
						memberProfileDto.setMemberProfileUploadname(multipartFile.getOriginalFilename());
						memberProfileDto.setMemberProfileType(multipartFile.getContentType());
						memberProfileDto.setMemberProfileSize(multipartFile.getSize());
						memberProfileDao.save(memberProfileDto, multipartFile);
					
			//		//회원관심분야 정보 뽑아서 회원관심테이블에 저장
			//		// memberJoinVO 안에 List<String> lecCategoryName이 들어있다.
			//		List<String> lecCategoryName = memberJoinVO.getLecCategoryName();
			//		System.out.println("그냥 밖에"+ lecCategoryName.toString());
			//		//관심분야 선택했는지 확인. 선택 안했으면 저장 생략
			//		if (lecCategoryName.size() > 0) {
			//			//회원관심분야에 대한 DTO 생성
			//			MemberCategoryDto memberCategoryDto = new MemberCategoryDto();
			//
			//			memberCategoryDto.setMemberIdx(sequence);
			//			log.debug("DTO DATA B4 = {}", memberCategoryDto);
			//			log.debug("catName = {}", lecCategoryName);
			//			log.debug("GETTER 확인 = {}", memberCategoryDto.getLecCategoryName());
			//			memberCategoryDto.setLecCategoryName(lecCategoryName);
			//			//관심분야 DB에 저장
			//			log.debug("DTO DATA AFTR = {}", memberCategoryDto);
			//			memberCategoryDao.update(memberCategoryDto);			
			//		}
						//memberDto
						MemberDto memberDto = new MemberDto();
						
						memberDto.setMemberIdx(memberJoinVO.getMemberIdx());
						memberDto.setMemberId(memberJoinVO.getMemberId());
						memberDto.setMemberPw(memberJoinVO.getMemberPw());
						memberDto.setMemberNick(memberJoinVO.getMemberNick());
						memberDto.setMemberEmail(memberJoinVO.getMemberEmail());
						memberDto.setMemberPhone(memberJoinVO.getMemberPhone());
						memberDto.setMemberRegion(memberJoinVO.getMemberRegion());
						memberDto.setMemberGender(memberJoinVO.getMemberGender());
						log.debug("======================== MemberService.edit() 실시. DTO = {}", memberJoinVO);
						//memberDto를 테이블 업데이트
						boolean isSucceed = memberDao.changeInformation(memberDto);
						
						log.debug("======================== MemberService.edit() 실시 완료. 결과 = {}", isSucceed);
			
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
	
	//아이디 찾기(이메일)
	@Override
	public MemberDto idFindMail(String memberNick, String memberEmail) {
		return memberDao.idFindMail(memberNick, memberEmail);
	}
	
	// 비밀번호 찾기(이메일)
	@Override
	public MemberDto pwFindMail(String memberId, String memberNick, String memberEmail) {
		return memberDao.pwFindMail(memberId, memberNick, memberEmail);
	}
	

	@Override
	public List<MemberListVO> list(MemberCriteria cri) {
		return memberDao.list(cri);
	}

	@Override
	public int listCount() {
		return memberDao.listCount();
	}
	
	
}



