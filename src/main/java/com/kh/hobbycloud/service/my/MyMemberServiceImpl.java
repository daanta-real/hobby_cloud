package com.kh.hobbycloud.service.my;

import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.hobbycloud.service.member.MemberService;
import com.kh.hobbycloud.vo.member.MemberCriteria;
import com.kh.hobbycloud.vo.member.MemberListVO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class MyMemberServiceImpl implements MyMemberService {

	@Autowired MemberService memberService;

	@Override
	public List<LinkedHashMap<String, String>> list(MemberCriteria cri) {
		List<MemberListVO> listOrg = memberService.list(cri);
		List<LinkedHashMap<String, String>> listNew = new ArrayList<>();
		log.debug("▶▶▶▶▶▶▶▶▶▶▶▶▶▶▶▶▶▶ Original list 목록: {}", listOrg);
		int count = 1;
		for(MemberListVO listOne: listOrg) {
			LinkedHashMap<String, String> map = new LinkedHashMap<>();
			map.put("순", String.valueOf(count++));
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
			map.put("관심사", listOne.getLecCategoryName());
			listNew.add(map);
			log.debug("▶▶▶▶▶▶▶▶▶▶▶▶▶▶▶▶▶▶ 완성된 Maps 목록: {}", map);
		}
		return listNew;
	}

}
