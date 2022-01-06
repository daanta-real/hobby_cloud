package com.kh.hobbycloud.service.member;

import java.io.FileNotFoundException;
import java.io.IOException;

import javax.mail.MessagingException;

public interface EmailService {

	//인증번호 전송 메소드
	String sendCertification(String email) throws MessagingException, FileNotFoundException, IOException;

	String sendTempPwMail(String email) throws MessagingException, FileNotFoundException, IOException;
	
}
