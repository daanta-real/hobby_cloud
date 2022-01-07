package com.kh.hobbycloud.util;

public interface RandomUtil {
	
	//랜덤 인증번호 생성 메소드
	String generateRandomNumber(int size);
	
	//랜덤 비밀번호 생성 메소드
	String randomChangePw();
}
