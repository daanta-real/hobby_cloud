package com.kh.hobbycloud.vo.member;

import java.util.List;

import lombok.Data;

@Data
public class MemberSearchVO {
	private String memberId;
	private String memberNick;
	private String memberGradeName;
	private List<String> lecCategoryName;
}