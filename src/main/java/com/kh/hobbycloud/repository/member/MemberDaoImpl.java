package com.kh.hobbycloud.repository.member;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Repository;

import com.kh.hobbycloud.entity.member.MemberDto;
import com.kh.hobbycloud.vo.member.MemberCriteria;
import com.kh.hobbycloud.vo.member.MemberJoinVO;
import com.kh.hobbycloud.vo.member.MemberListVO;
import com.kh.hobbycloud.vo.member.MemberSearchVO;


@Repository
public class MemberDaoImpl implements MemberDao{

	// 변수선언부
	@Autowired
	private SqlSession sqlSession;

	@Autowired
	private PasswordEncoder encoder;

	// 단일조회 - ID 기준
	@Override
	public MemberDto get(String memberId) {
		return sqlSession.selectOne("member.get", memberId);
	}

	// 단일조회 - IDX 기준
	@Override
	public MemberDto getByIdx(Integer memberIdx) {
		return sqlSession.selectOne("member.getbyIdx", memberIdx);
	}

	@Override
	public MemberJoinVO getVO(Integer memberIdx) {
		return sqlSession.selectOne("member.getbyIdx", memberIdx);
	}

	// 비밀번호 검사 후 로그인까지 처리하는 메소드
	@Override
	public MemberDto login(MemberDto memberDto) {
		System.out.println(">> DAO login() 메소드 실행");
		System.out.println(">> DAO login() memberId----"+ memberDto.getMemberId());
		System.out.println(">> DAO login() memberPw----"+ memberDto.getMemberPw());

		// ID와 비밀번호를 입력하였으므로, IDX가 아니라 ID로 조회해야 함
		MemberDto foundDto = sqlSession.selectOne("member.get", memberDto.getMemberId());
		System.out.println(">> login() 메소드 foundDto.getMemberPw() ===> "+foundDto.toString());
		System.out.println(">> login() 메소드 memberDto.getMemberPw() ===> "+memberDto.getMemberPw());
		// 해당 아이디의 회원정보가 존재 && 입력 비밀번호와 조회된 비밀번호가 같다면 => 로그인 성공(객체를 반환)
		if(foundDto != null &&encoder.matches(memberDto.getMemberPw(), foundDto.getMemberPw())) {
			System.out.println(">> 입력 비밀번호 memberDto.getMemberPw() ===> "+memberDto.getMemberPw());
			System.out.println(">> 조회 비밀번호 foundDto.getMemberPw() ===> "+foundDto.getMemberPw());
			return foundDto;
		}
		else {//아니면 null을 반환
			return null;
		}
	}

	// 가입 처리
	@Override
	public void join(MemberDto memberDto) {
		String origin = memberDto.getMemberPw();
		String encrypt = encoder.encode(origin);
		memberDto.setMemberPw(encrypt);
		sqlSession.insert("member.insert", memberDto);
	}


	// 비밀번호 변경
	@Override
	public boolean changePassword(Integer memberIdx, String memberPw, String changePw) {
		MemberDto memberDto = sqlSession.selectOne("member.getbyIdx", memberIdx);
		if(encoder.matches(memberPw, memberDto.getMemberPw())) {
			Map<String, Object> param = new HashMap<>();
			param.put("memberIdx", memberIdx);
			param.put("changePw", encoder.encode(changePw)); // 변경할 비밀번호 암호화

			int count = sqlSession.update("member.changePassword", param);
			return count > 0;
		}
		else {
			return false;
		}
	}

	// 개인정보 변경 (비밀번호 제외)
	@Override
	public boolean changeInformation(MemberDto memberDto) {
		MemberDto findDto = sqlSession.selectOne("member.getbyIdx", memberDto.getMemberIdx());
		if(encoder.matches(memberDto.getMemberPw(), findDto.getMemberPw())) {
			int count = sqlSession.update("member.changeInformation", memberDto);
			return count > 0;
		}
		else {
			return false;
		}
	}
	// 개인정보 변경 (이메일)
	@Override
	public int changeEmail(String memberEmail, Integer memberIdx) {
		System.out.println("changeEmail() 실행");
		MemberDto memberDto = sqlSession.selectOne("member.getbyIdx", memberIdx);
		System.out.println("changeEmail() member.getbyIdx  :  "+ memberIdx);
		Map<String, Object> map = new HashMap<>();
		map.put("memberIdx", memberIdx);
		map.put("memberEmail", memberEmail);
		System.out.println("changeEmail() memberEmail  :  "+ memberEmail);
		return sqlSession.update("member.changeEmail", map);
	}

	

	// 회원 탈퇴
	@Override
	public boolean quit(Integer memberIdx, String memberPw) {
		MemberDto findDto = sqlSession.selectOne("member.get", memberIdx);
		if(encoder.matches(memberPw, findDto.getMemberPw())) {
			int count = sqlSession.delete("member.quit", memberIdx);
			return count > 0;
		}
		else {
			return false;
		}
	}


	//tutor에서 이용할 등급 변경 기능
	@Override
	public void changeGradeTutor(int memberIdx) {
		sqlSession.update("member.changeGradeTutor", memberIdx);
	}
	@Override
	public void changeGradeNormal(int memberIdx) {
		sqlSession.update("member.changeGradeNormal", memberIdx);
	}


	//아이디 중복 검사
	@Override
	public MemberDto checkId(String memberId) throws Exception {
		System.out.println(">> DAO checkId() 메소드 실행");
		return sqlSession.selectOne("member.get", memberId);
	}

	//닉네임 중복 검사
	@Override
	public MemberDto checkNick(String memberNick) throws Exception {
		System.out.println(">> DAO checkNick() 메소드 실행");
		return sqlSession.selectOne("member.findNick",memberNick);
	}

	// 아이디찾기(이메일)
	@Override
	public MemberDto idFindMail(String memberNick, String memberEmail) {
		Map<String, String> map = new HashMap<>();
		map.put("memberNick", memberNick);
		map.put("memberEmail", memberEmail);
		return sqlSession.selectOne("member.idFindMail", map);
	}


	// 비밀번호 찾기(이메일)
	@Override
	public MemberDto pwFindMail(String memberId, String memberNick, String memberEmail) {

		Map<String, String> map = new HashMap<>();
		map.put("memberId", memberId);
		map.put("memberNick", memberNick);
		map.put("memberEmail", memberEmail);
		return sqlSession.selectOne("member.pwFindMail", map);
	}

	//임시 비밀번호 업데이트
	@Override
	public boolean tempPw(MemberDto memberDto,String changePw) {

		Map<String ,Object> param = new HashMap<>();
		//받은 난수를 암호화 하여 업데이트 진행
		String origin = changePw;
		String encrypt = encoder.encode(origin);
		memberDto.setMemberPw(encrypt);
		param.put("memberId", memberDto.getMemberId());
		param.put("memberPw",memberDto.getMemberPw());

		//원래 비밀번호를 암호화 하여서 비밀번호 업데이트
		int result=sqlSession.update("member.tempPw",param);
		return result>0;
	}

	@Override
	public List<MemberListVO> list(MemberCriteria cri) {
		return sqlSession.selectList("member.list");
	}

	@Override
	public int listCount() {
		return sqlSession.selectOne("member.listCount");
	}

	//페이지네이션을 이용한 목록조회
	@Override
	public List<MemberListVO> listPage(int startRow, int endRow) {
		Map<String, Object> param = new HashMap<>();
		param.put("startRow", startRow);
		param.put("endRow", endRow);
		return sqlSession.selectList("member.listPage",param);
	}

	@Override
	public List<MemberListVO> listSearch(MemberSearchVO memberSearchVO) {
		return sqlSession.selectList("member.listSearch", memberSearchVO);
	}



	// *포인트 관련*
	// 특정 회원의 포인트 증감 처리
	@Override
	public boolean pointModify(MemberDto memberDto) {
		int result = sqlSession.update("member.pointModify", memberDto);
		return result > 0;
	}
	// 특정 회원의 포인트를 특정 값으로 강제변경
	@Override
	public boolean pointForceToValue(MemberDto memberDto) {
		int result = sqlSession.update("member.pointForceToValue", memberDto);
		return result > 0;
	}

}





