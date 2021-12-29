package com.kh.hobbycloud.repository.notice;

import java.io.File;
import java.io.IOException;
import java.util.List;

import org.apache.commons.io.FileUtils;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.web.multipart.MultipartFile;

import com.kh.hobbycloud.entity.notice.NoticeFileDto;

@Repository
public class NoticeFileDaoImpl implements NoticeFileDao{
	
	@Autowired
	private SqlSession sqlSession;
	
	@Autowired
	private String STOREPATH_NOTICE;

	//저장용 폴더
	private File directory = new File(STOREPATH_NOTICE);

	public void save(NoticeFileDto noticeFileDto, MultipartFile multipartFile) throws IllegalStateException, IOException {
		//1. 시퀀스 획득
		int sequence = sqlSession.selectOne("noticeFile.seq");
		
		//2. 실제파일을 폴더에저장
		File target = new File(directory,String.valueOf(sequence));
		multipartFile.transferTo(target);
		noticeFileDto.setNoticeFileIdx(sequence);
		noticeFileDto.setNoticeFileServerName(String.valueOf(sequence));
		sqlSession.insert("noticeFile.save",noticeFileDto);
		
		
		
	}

	@Override
	public NoticeFileDto getNo(int noticeFileIdx) {
		
		return sqlSession.selectOne("noticeFile.getNo", noticeFileIdx);
	}

	@Override
	public List<NoticeFileDto> getIdx(int noticeIdx) {
		
		return sqlSession.selectList("noticeFile.getIdx", noticeIdx);
	}

	@Override
	public byte[] load(int noticeFileIdx) throws IOException {
		File target = new File(directory, String.valueOf(noticeFileIdx));
		byte[] data = FileUtils.readFileToByteArray(target);
		return data;
		
	}

	

	

}
