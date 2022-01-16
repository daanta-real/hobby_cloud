package com.kh.hobbycloud.service.my;

import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import com.kh.hobbycloud.vo.member.MemberCriteria;

public interface MyMemberService {

	List<LinkedHashMap<String, String>> list(MemberCriteria cri);

	Map<String, Object> detail(int memberIdx);

	boolean delete(int memberIdx);

}
