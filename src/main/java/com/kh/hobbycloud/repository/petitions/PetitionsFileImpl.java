package com.kh.hobbycloud.repository.petitions;

import java.io.File;
import java.io.IOException;
import java.util.List;

import org.apache.commons.io.FileUtils;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.web.multipart.MultipartFile;

import com.kh.hobbycloud.entity.petitions.PetitionsFileDto;

@Repository
public class PetitionsFileImpl implements PetitionsFileDao{
	@Autowired
	private SqlSession sqlSession;
	
	@Autowired
	private String STOREPATH_NOTICE;

	@Override
	public void save(PetitionsFileDto petitionsFileDto, MultipartFile multipartFile)
			throws IllegalStateException, IOException {
		//1. 시퀀스 획득
				int sequence = sqlSession.selectOne("petitionsFile.seq");
				
				//2. 실제파일을 폴더에저장
				File target = new File(STOREPATH_NOTICE,String.valueOf(sequence));
				multipartFile.transferTo(target);
				petitionsFileDto.setPetitionsFileIdx(sequence);
				petitionsFileDto.setPetitionsFileServerName(String.valueOf(sequence));
				sqlSession.insert("petitionsFile.save",petitionsFileDto);
		
	}

	@Override
	public PetitionsFileDto getNo(int petitionsFileIdx) {
		
		return sqlSession.selectOne("petitionsFile.getNo", petitionsFileIdx);
	}

	@Override
	public List<PetitionsFileDto> getIdx(int petitionsIdx) {
		
		return sqlSession.selectList("petitionsFile.getIdx", petitionsIdx);
	}

	@Override
	public byte[] load(int petitionsFileIdx) throws IOException {
		File target = new File(STOREPATH_NOTICE, String.valueOf(petitionsFileIdx));
		byte[] data = FileUtils.readFileToByteArray(target);
		return data;
	}
	

}
