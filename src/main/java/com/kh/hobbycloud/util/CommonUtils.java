package com.kh.hobbycloud.util;

import java.util.UUID;

public class CommonUtils {
	public static String getRandomString() {
        return UUID.randomUUID().toString().replaceAll("-","");
    }//랜덤한 서버 네임 생성
}
