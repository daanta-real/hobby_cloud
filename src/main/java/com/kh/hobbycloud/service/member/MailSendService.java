package com.kh.hobbycloud.service.member;

import java.io.UnsupportedEncodingException;
import java.util.Random;

import javax.mail.MessagingException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSenderImpl;
import org.springframework.stereotype.Service;

import com.sun.mail.util.logging.MailHandler;

@Service("mailSendService")
public class MailSendService {
	
	@Autowired
    private JavaMailSenderImpl mailSender;
	
    //인증메일 보내기
    public String sendAuthMail(String email) {
    	int ran = new Random().nextInt(100000) + 10000;
        //6자리 난수 인증번호 생성
        String authKey = String.valueOf(ran);
        
        //인증메일 보내기
        try {
        		MailHandler sendMail = new MailHandler(mailSender);
            sendMail.setSubject("hobbycloud에서 이메일 인증번호 보내드립니다.");
            sendMail.setText(new StringBuffer().append("<p align=\"center\" style=\"text-align: center; \">")
            .append("<span style=\"font-size: 36pt; font-family: arial, sans-serif; color: rgb(0, 158, 37);\">")
            .append("<b><span style=\"color: rgb(1, 91, 40);\"><br></span></b></span></p>")
            .append("<p align=\"center\" style=\"text-align: center; \">")
            .append("<span style=\"font-size: 36pt; font-family: arial, sans-serif; color: rgb(0, 158, 37);\">")
            .append("<b><span style=\"color: rgb(1, 91, 40);\">hobbycloud</span></b></span></p><p align=\"center\" style=\"text-align: center; \">")
            .append("<span style=\"font-size: 36pt; font-family: arial, sans-serif; color: rgb(0, 158, 37);\">")
            .append("<span style=\"color: rgb(0, 0, 0); font-size: 12pt;\">﻿hobbycloud에서 인증번호 보내드립니다.</span></span></p>")
            .append("<p align=\"center\" style=\"text-align: center; \"><font face=\"arial, sans-serif\">")
            .append("<span style=\"font-size: 16px;\">아래 번호를 인증번호창에 입력해주세요&nbsp;</span></font></p>")
            .append("<p align=\"center\" style=\"text-align: center; \"><br></p><p align=\"center\" style=\"text-align: center; \">")
            .append("<font face=\"arial, sans-serif\"><span style=\"font-size: 18pt;\"><u style=\"\">" + authKey + "</u></span></font></p>")
            .append("<p align=\"center\" style=\"text-align: center; \"><br></p>")
            .toString());
            sendMail.setFrom("khmember1234@gmail.com", "hobbycloud");
            sendMail.setTo(email);
            sendMail.send();
        } catch (MessagingException e) {
            e.printStackTrace();
            
        } catch (UnsupportedEncodingException e) {
            e.printStackTrace();
        }

          return authKey;
    }
    
}
