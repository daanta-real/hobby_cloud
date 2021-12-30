package com.kh.hobbycloud.vo.pay.subvo;

import lombok.Data;

// 카드 결제 시 들어오는 카드 관련 정보

@Data
public class SelectedCardInfo {

	private String card_bin;              // 카드 BIN
	private int install_month;            // 할부 개월 수
	private String card_corp_name;        // 카드사 이름
	private String interest_free_install; // 무이자할부 여부(Y/N)

}
