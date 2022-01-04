package com.kh.hobbycloud.entity.member;

import java.util.List;

import lombok.Data;

@Data
public class MemberCategoryDto {
	
	private int memberIdx;
	private List<String> lecCategoryName;

}
