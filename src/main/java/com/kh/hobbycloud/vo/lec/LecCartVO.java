package com.kh.hobbycloud.vo.lec;

import lombok.Data;

@Data
public class LecCartVO {
	private int cartIdx;
	private int memberIdx;
	private String memberNick;
	private int lecIdx;
	private String lecName;
	private int lecPrice;
//	private int money;//해당 강좌의 전체가격 필요 x
//	private int amount;//강좌의 양 필요 x
	
}
