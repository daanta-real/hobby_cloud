package com.kh.hobbycloud.service.member;

import java.io.UnsupportedEncodingException;

import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;

import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;

public class MailHandler {
	
	//메일 전송
	private JavaMailSender sender;

	//복잡한 메세지
	private MimeMessage message;

	//설정 도우미
	private MimeMessageHelper messageHelper;
	
	//메일 보내기 클래스
	public MailHandler(JavaMailSender sender) throws MessagingException {
		
		//전송 객체 생성
		this.sender = sender;
		//메세지 객체 생성
		this.message = this.sender.createMimeMessage();
		//설정 도우미 설정
		this.messageHelper = new MimeMessageHelper(message, true, "UTF-8");
	}
	
	//발신인
	public void setFrom(String mail, String name) throws UnsupportedEncodingException, MessagingException {
		messageHelper.setFrom(mail, name);
	}
	//수신인
	public void setTo(String mail) throws MessagingException {
		messageHelper.setTo(mail);
	}

	//제목
	public void setSubject(String subject) throws MessagingException {
		messageHelper.setSubject(subject);
	}
	
	//내용
	public void setText(String text) throws MessagingException {
		messageHelper.setText(text, true);
	}
	
	//전송
	public void send() {
		sender.send(message);
		
	}
	
}
