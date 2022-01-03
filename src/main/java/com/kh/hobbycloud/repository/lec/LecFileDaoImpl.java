package com.kh.hobbycloud.repository.lec;

import java.io.File;
import java.io.IOException;
import java.util.List;

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
	
	@Autowired
	private String STOREPATH_LEC;
	
	//저장용 폴더
//	private File directory = new File(STOREPATH_LEC);
	
	@Override
	public void save(LecFileDto lecFileDto, MultipartFile multipartFile) throws IllegalStateException, IOException {
		//1
		int sequence = sqlSession.selectOne("lecFile.seq");

		//2
		File target = new File(STOREPATH_LEC, String.valueOf(sequence));
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
	public List<LecFileDto> getByIdx(int lecIdx) {
		return sqlSession.selectList("lecFile.getByLecIdx", lecIdx);
	}

	@Override
	public byte[] load(int lecFileIdx) throws IOException {
		File target = new File(STOREPATH_LEC, String.valueOf(lecFileIdx));
		byte[] data = FileUtils.readFileToByteArray(target);
		return data;
	}
	
	@Override
	public boolean delete(int lecIdx) {
		int count = sqlSession.delete("lecFile.delete",lecIdx);
		return count > 0;
	}
	
	@Override
	public boolean deleteAjax(int lecFileIdx) {
		int count =sqlSession.delete("lecFile.deleteAjax",lecFileIdx);
		return count > 0;
	}

}
