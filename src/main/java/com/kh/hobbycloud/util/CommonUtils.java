package com.kh.hobbycloud.util;


import java.util.UUID;

//랜덤한 서버 네임 생성
import org.springframework.stereotype.Component;

@Component
public class CommonUtils {

	// debug 결과물 문자열을 보기 편하게 여러 줄 형태로 바꿔서 리턴해주는 메소드
	public static String newLiner(Object logStringObj) {
		return logStringObj.toString()
			.replaceAll(",", "\n")
			.replaceAll("\\(", "\n")
			.replaceAll("\\)",  "\n");
	}

}

