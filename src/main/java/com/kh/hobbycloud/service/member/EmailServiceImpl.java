package com.kh.hobbycloud.service.member;

import java.io.FileNotFoundException;
import java.io.IOException;
import java.util.Scanner;

import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.ClassPathResource;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Service;

import com.kh.hobbycloud.util.RandomUtil;

@Service
public class EmailServiceImpl implements EmailService{
	
	@Autowired
	private JavaMailSender sender;
	
	@Autowired
	private RandomUtil util;
	
	//인증메일 보내기
	@Override
	public String sendCertification(String email) throws MessagingException, FileNotFoundException, IOException {
		
				//랜덤번호 생성		
				String authKey = util.generateRandomNumber(6);
				
				//메세지 객체 생성
				MimeMessage message = sender.createMimeMessage();
						
				//설정 도우미 생성
				MimeMessageHelper helper = new MimeMessageHelper(message, true, "UTF-8");
				helper.setTo(email);
				helper.setSubject("hobby cloud에서 인증번호를 발송했습니다");
				
				//파일을 읽어서 내용을 설정
				ClassPathResource resource = new ClassPathResource("email/template.html");
				
				StringBuffer buffer = new StringBuffer();
				try(Scanner sc = new Scanner(resource.getFile());){
					while(sc.hasNextLine()) {
						buffer.append(sc.nextLine());
						buffer.append('\n');
					}
				}
				
				// 랜덤 인증번호 html 템플릿에 전달
				String html = buffer.toString();
				html = html.replace("{{authKey}}", authKey);
				helper.setText(html, true);
				System.out.println("인증번호 전송");	
				
				//전송(message)
				sender.send(message);
				System.out.println("이메일 전송 완료");	
				
				return authKey;
	}
	
	//비밀번호 재설정
	@Override
	public String sendTempPwMail(String email) throws MessagingException, FileNotFoundException, IOException {
		
				//랜덤비밀번호 생성		
				String changePw = util.randomChangePw();
				System.out.println("changePw : " + changePw);
				
				//메세지 객체 생성
				MimeMessage message = sender.createMimeMessage();
						
				//설정 도우미 생성
				MimeMessageHelper helper = new MimeMessageHelper(message, true, "UTF-8");
				helper.setTo(email);
				helper.setSubject("hobby cloud에서 임시 비밀번호를 발송했습니다");
				
				//파일을 읽어서 내용을 설정
				ClassPathResource resource = new ClassPathResource("email/template.html");
				
				StringBuffer buffer = new StringBuffer();
				try(Scanner sc = new Scanner(resource.getFile());){
					while(sc.hasNextLine()) {
						buffer.append(sc.nextLine());
						buffer.append('\n');
					}
				}
				
				// 랜덤 인증번호 html 템플릿에 전달
				String html = buffer.toString();
				html = html.replace("{{changePw}}", changePw);
				helper.setText(html, true);
				System.out.println("인증번호 전송");	
				
				//전송(message)
				sender.send(message);
				System.out.println("이메일 전송 완료");	
				
				return changePw;
	}
}
