package com.kh.hobbycloud.repository.gather;

import java.io.File;
import java.io.IOException;

import org.apache.commons.io.FileUtils;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.web.multipart.MultipartFile;

import com.kh.hobbycloud.entity.gather.GatherFileDto;

@Repository
public class GatherFileDaoImpl  implements GatherFileDao{

	@Autowired
	private SqlSession sqlSession;
	
	//임의로 멤버로 생성해놓음
	private File directory = new File("D:/upload/member");
	
	
	@Override
	public void save(GatherFileDto gatherFileDto,MultipartFile multipartFile) throws IllegalStateException, IOException {
		int sequence = sqlSession.selectOne("gatherFile.getSequence");
		
		File target = new File(directory,String.valueOf(sequence));
		multipartFile.transferTo(target);
		
		gatherFileDto.setGatherFileIdx(sequence);
		gatherFileDto.setGatherFileServerName(String.valueOf(sequence));
		sqlSession.insert("gatherFile.save",gatherFileDto);
	}


	@Override
	public GatherFileDto getNo(int gatherFileIdx) {
		
		return sqlSession.selectOne("gatherFile.getNo", gatherFileIdx);
	}


	@Override
	public GatherFileDto getIdx(int gatherIdx) {
		return sqlSession.selectOne("gatherFile.getIdx", gatherIdx);
	}


	@Override
	public byte[] load(int gatherFileIdx) throws IOException {
		File target = new File(directory,String.valueOf(gatherFileIdx));
		byte[] data = FileUtils.readFileToByteArray(target);
		return data;
	}
}
