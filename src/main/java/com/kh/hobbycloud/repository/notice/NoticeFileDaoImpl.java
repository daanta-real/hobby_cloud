package com.kh.hobbycloud.repository.notice;

import java.io.File;
import java.io.IOException;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.web.multipart.MultipartFile;

import com.kh.hobbycloud.entity.notice.NoticeFileDto;

@Repository
public class NoticeFileDaoImpl implements NoticeFileDao{
	
	@Autowired
	private SqlSession sqlSession;

	//저장용 폴더
	private File directory = new File("C:\\Users\\gptjd\\upload");

	@Override
	public void save(NoticeFileDto noticeFileDto, MultipartFile multipartFile) throws IllegalStateException, IOException {
		//1
		int sequence = sqlSession.selectOne("noticeFile.seq");
		
		//2
		File target = new File(directory,String.valueOf(sequence));
		multipartFile.transferTo(target);
		
		//3
		noticeFileDto.setNoticeFileIdx(sequence);
		noticeFileDto.setNoticeFileServerName(String.valueOf(sequence));
		sqlSession.insert("noticeFile.save",noticeFileDto);
		
	}

}
