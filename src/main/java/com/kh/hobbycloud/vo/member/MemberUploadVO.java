package com.kh.hobbycloud.vo.member;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

@Data
public class MemberUploadVO {
	private String memberId;
	private String memberPw;
	private List<MultipartFile> attach;
}
