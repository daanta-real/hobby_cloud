package com.kh.hobbycloud.repository.lec;

import java.io.File;
import java.io.IOException;

import org.apache.commons.io.FileUtils;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.web.multipart.MultipartFile;

import com.kh.hobbycloud.entity.lec.LecFileDto;

@Repository
public class LecFileDaoImpl implements LecFileDao {

	@Autowired
	private SqlSession sqlSession;
	
	//저장용 폴더
	private File directory = new File("D:/upload/lec");
	
	@Override
	public void save(LecFileDto lecFileDto, MultipartFile multipartFile) throws IllegalStateException, IOException {
		//1
		int sequence = sqlSession.selectOne("lecFile.seq");

		//2
		File target = new File(directory, String.valueOf(sequence));
		multipartFile.transferTo(target);

		//3
		lecFileDto.setLecFileIdx(sequence);
		lecFileDto.setLecFileServerName(String.valueOf(sequence));
		sqlSession.insert("lecFile.save", lecFileDto);
		
	}

	@Override
	public LecFileDto get(int lecFileIdx) {
		return sqlSession.selectOne("lecFile.get", lecFileIdx);
	}
	
	@Override
	public LecFileDto getbyIdx(int lecIdx) {
		return sqlSession.selectOne("lecFile.getByLec", lecIdx);
	}

	@Override
	public byte[] load(int lecFileIdx) throws IOException {
		File target = new File(directory, String.valueOf(lecFileIdx));
		byte[] data = FileUtils.readFileToByteArray(target);
		return data;
	}

}