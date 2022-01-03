package com.kh.hobbycloud.vo.pay;

import java.util.List;

import lombok.Data;

@Data
public class PaidSearchVO {
	private String memberIdx;
	private String paidRegistered_start;
	private String paidRegistered_end;
	private String paidPrice_min;
	private String paidPrice_max;
	private List<Character> paidStatusList;
}
