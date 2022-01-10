package com.kh.hobbycloud.vo.point;

import lombok.Data;

@Data
public class PointSearchVO {
	private Integer pointIdx;
	private String pointName;
	private Integer pointPriceMin;
	private Integer pointPriceMax;
	private Integer pointAmountMin;
	private Integer pointAmountMax;
}
