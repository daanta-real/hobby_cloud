package com.kh.hobbycloud.repository.notice;

import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
	//private File directory = new File(STOREPATH_NOTICE);

	public void save(NoticeFileDto noticeFileDto, MultipartFile multipartFile) throws IllegalStateException, IOException {
		//0. 시퀀스 획득
		int sequence = sqlSession.selectOne("noticeFile.seq");
		
		// 1. 실제 파일을 업로드 폴더에 저장
				File target = new File(STOREPATH_NOTICE, String.valueOf(sequence));
				multipartFile.transferTo(target);

				// 2. 파일의 정보를 DB에 저장
				noticeFileDto.setNoticeFileIdx(sequence);
				noticeFileDto.setNoticeFileServerName(String.valueOf(sequence));
				sqlSession.insert("noticeFile.save",noticeFileDto);
		
		
		
		/*
		//2. 실제파일을 폴더에저장
		File target = new File(STOREPATH_NOTICE,String.valueOf(sequence));
		multipartFile.transferTo(target);
		noticeFileDto.setNoticeFileIdx(sequence);
		noticeFileDto.setNoticeFileServerName(String.valueOf(sequence));
		sqlSession.insert("noticeFile.save",noticeFileDto);
		*/
		
		
		
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
		File target = new File(STOREPATH_NOTICE, String.valueOf(noticeFileIdx));
		byte[] data = FileUtils.readFileToByteArray(target);
		return data;
		
	}

	@Override//파일삭제
	public boolean delete(int noticeIdx) {
		int count = sqlSession.delete("noticeFile.delete",noticeIdx);
		return count > 0;
	}

	@Override//실시간삭제
	public boolean deleteAjax(int noticeFileIdx) {
		int count = sqlSession.delete("noticeFile.deleteAjax",noticeFileIdx);
		return count > 0;
	}

	@Override
	public boolean deleteList(int noticeIdx, List<String> list) {
		Map<String, Object> map = new HashMap<>();
		map.put("noticeIdx", noticeIdx);
		map.put("list", list);
		int count = sqlSession.delete("noticeFile.deleteList", map);
		return count > 0;
	}

	

	

	

}
