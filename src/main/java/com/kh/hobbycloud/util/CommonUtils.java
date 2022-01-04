package com.kh.hobbycloud.util;

import java.text.DecimalFormat;
import java.text.SimpleDateFormat;

import org.springframework.stereotype.Component;

@Component
public class CommonUtils {

	private static SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
	private static DecimalFormat commaFormat = new DecimalFormat("#,###");

	// debug 결과물 문자열을 보기 편하게 여러 줄 형태로 바꿔서 리턴해주는 메소드
	public static String newLiner(Object logStringObj) {
		return logStringObj.toString()
			.replaceAll(",", "\n")
			.replaceAll("\\(", "\n")
			.replaceAll("\\)",  "\n");
	}

	// java.util.Date 혹은 java.sql.Date 형태를,
	// yyy-MM-dd hh:mm:ss 형식의 문자열로 리턴해 준다.
	public static String toChar(java.sql.Date date) {
		return toChar((java.util.Date) date);
	}
	public static String toChar(java.util.Date date) {
		return sdf.format(date);
	}

	// 문자든 숫자든 간에 3자리마다 콤마 찍은 문자열로 바꿔줌
	public static String attachComma(Object str) {
		return commaFormat.format(str);
	}
	public static String attachComma(Integer str) {
		return commaFormat.format(str);
	}
	public static String attachComma(String str) {
		return commaFormat.format(str);
	}

}