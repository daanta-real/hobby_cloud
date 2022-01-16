package com.kh.hobbycloud.service.my;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.hobbycloud.entity.member.MemberCategoryDto;
import com.kh.hobbycloud.entity.member.MemberDto;
import com.kh.hobbycloud.entity.member.MemberProfileDto;
import com.kh.hobbycloud.repository.member.MemberCategoryDao;
import com.kh.hobbycloud.repository.member.MemberDao;
import com.kh.hobbycloud.repository.member.MemberProfileDao;
import com.kh.hobbycloud.service.member.MemberService;
import com.kh.hobbycloud.vo.member.MemberCriteria;
import com.kh.hobbycloud.vo.member.MemberListVO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class MyMemberServiceImpl implements MyMemberService {

	@Autowired MemberService memberService;
	@Autowired MemberDao memberDao;
	@Autowired MemberProfileDao memberProfileDao;
	@Autowired MemberCategoryDao memberCategoryDao;

	@Override
	public List<LinkedHashMap<String, String>> list(MemberCriteria cri) {
		List<MemberListVO> listOrg = memberService.list(cri);
		List<LinkedHashMap<String, String>> listNew = new ArrayList<>();
		log.debug("▶▶▶▶▶▶▶▶▶▶▶▶▶▶▶▶▶▶ Original list 목록: {}개, {}", listOrg.size(), listOrg);
		int count = 1;
		for(MemberListVO listOne: listOrg) {
			LinkedHashMap<String, String> map = new LinkedHashMap<>();
			map.put("순", String.valueOf(count++));
			map.put("targetIdx", String.valueOf(listOne.getMemberIdx()));
			map.put("회원번호", String.valueOf(listOne.getMemberIdx()));
			map.put("등급", listOne.getMemberGradeName());
			map.put("ID", listOne.getMemberId());
			map.put("닉네임", listOne.getMemberNick());
			map.put("이메일", listOne.getMemberEmail());
			map.put("전화번호", listOne.getMemberPhone());
			map.put("등록일", String.valueOf(listOne.getMemberRegistered()));
			map.put("보유포인트", String.valueOf(listOne.getMemberPoint()));
			map.put("지역", listOne.getMemberRegion());
			map.put("성별", listOne.getMemberGender());
			listNew.add(map);
			log.debug("▶▶▶▶▶▶▶▶▶▶▶▶▶▶▶▶▶▶ 완성된 Maps 목록: {}", map);
		}
		return listNew;
	}

	@Override
	public Map<String, Object> detail(int memberIdx) {
		log.debug("▶▶▶▶▶▶▶▶▶▶▶▶▶▶▶▶▶▶ MyMemberService.detail 진입: {}");
		//데이터 Model에 저장
		MemberDto memberDto = memberDao.getByIdx(memberIdx);
		MemberProfileDto memberProfileDto = memberProfileDao.getByMemberIdx(memberIdx);
		MemberCategoryDto memberCategoryDto = memberCategoryDao.get(memberIdx);
		Map<String, Object> map = new HashMap<>();
		map.put("memberDto", memberDto);
		map.put("memberProfileDto", memberProfileDto);
		map.put("memberCategoryDto", memberCategoryDto);
		return map;
	}


	@Override
	public boolean delete(int memberIdx) {
		log.debug("▶▶▶▶▶▶▶▶▶▶▶▶▶▶▶▶▶▶ MyMemberService.delete 진입: {}");
		memberCategoryDao.delete(memberIdx);
		memberProfileDao.delete(memberIdx);
		return memberDao.forcedDelete(memberIdx);
	}

}
