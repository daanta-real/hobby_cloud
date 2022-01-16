package com.kh.hobbycloud.service.my;

import java.util.LinkedHashMap;
import java.util.List;

import com.kh.hobbycloud.vo.member.MemberCriteria;

public interface MyMemberService {

	List<LinkedHashMap<String, String>> list(MemberCriteria cri);

}
