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

	// 파일 저장
	@Override
	public void save(LecFileDto lecFileDto, MultipartFile multipartFile) throws IllegalStateException, IOException {

		// 1. file의 새 시퀀스 획득
		int sequence = sqlSession.selectOne("lecFile.seq");

		// 2. 실제 파일을 서버로 다운로드
		File target = new File(STOREPATH_LEC, String.valueOf(sequence));
		multipartFile.transferTo(target);

		// 3. 다운로드가 끝난 뒤, lecFileDto를 file 정보 DB에 저장
		lecFileDto.setLecFileIdx(sequence);
		lecFileDto.setLecFileServerName(String.valueOf(sequence));
		sqlSession.insert("lecFile.save", lecFileDto);
	}

	// 파일 저장 정보 DTO 한개 획득: lecFileIdx로
	@Override
	public LecFileDto getByLecFileIdx(int lecFileIdx) {
		return sqlSession.selectOne("lecFile.getByLecFileIdx", lecFileIdx);
	}

	// 파일 저장 정보 DTO List 획득: lecIdx로
	@Override
	public List<LecFileDto> getListByLecIdx(int lecIdx) {
		return sqlSession.selectList("lecFile.getByLecIdx", lecIdx);
	}

	// 파일 실제 데이터 byte[]를 리턴
	@Override
	public byte[] load(int lecFileIdx) throws IOException {
		File target = new File(STOREPATH_LEC, String.valueOf(lecFileIdx));
		byte[] data = FileUtils.readFileToByteArray(target);
		return data;
	}

	// 파일 삭제 (강좌 idx로)
	@Override
	public boolean delete(int lecIdx) {
		int count = sqlSession.delete("lecFile.delete",lecIdx);
		return count > 0;
	}

	// 파일 삭제 (강좌파일 idx로)
	@Override
	public boolean deleteAjax(int lecFileIdx) {
		int count =sqlSession.delete("lecFile.deleteAjax",lecFileIdx);
		return count > 0;
	}

}
