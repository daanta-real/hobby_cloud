package com.kh.hobbycloud.util;

import java.text.DecimalFormat;
import java.text.Format;
import java.util.Random;

import org.springframework.stereotype.Service;
@Service
public class RandomUtilImpl implements RandomUtil{

	private Random r = new Random();
	
	//인증번호
	@Override
	public String generateRandomNumber(int size) {

		int range =  (int) Math.pow(10, size);
		int number = r.nextInt(range);
		
		StringBuffer buffer = new StringBuffer();
		for(int i=0; i < size; i++) {
			buffer.append("0");
		}
		Format f = new DecimalFormat(buffer.toString());		
		return f.format(number);
	}
	
   //임시 비밀번호
	@Override
	public String randomChangePw() {
    	StringBuffer temp = new StringBuffer();
    	Random rnd = new Random();
    	for (int i = 0; i < 6; i++) {
    	    int rIndex = rnd.nextInt(3);
    	    switch (rIndex) {
    	    case 0:
    	        // a-z 소문자
    	    	temp.append((char) ((int) (rnd.nextInt(26)) + 97));
    	        break;
    	    case 1:
    	        // A-Z 대문자
    	    	temp.append((char) ((int) (rnd.nextInt(26)) + 65));
    	        break;
    	    case 2:
    	        // 0-9 숫자
    	    	temp.append((rnd.nextInt(10)));
    	        break;
    	    }
    	}
    	
    	System.out.println(temp);
    	String tempPw = temp.toString();
    	return tempPw;    	
    }
}

