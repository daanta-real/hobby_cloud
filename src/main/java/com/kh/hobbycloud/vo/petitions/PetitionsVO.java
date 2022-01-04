package com.kh.hobbycloud.vo.petitions;

import java.sql.Date;
import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import lombok.Data;
@Data
public class PetitionsVO {
	 private int petitionsIdx;
		private String petitionsName;
		private String petitionsDetail;
		private int memberIdx;
		private String memberNick;
		private Date petitionsRegistered;
		private int petitionsViews;
		private int petitionsReplies;
		private List<MultipartFile> attach;

}
