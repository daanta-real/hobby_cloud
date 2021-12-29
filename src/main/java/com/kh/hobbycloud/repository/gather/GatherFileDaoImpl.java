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
	private File directory = new File("C:/work_sts/hobbycloud_stored_files");

	// 파일 정보를 DB로 저장한 뒤, 저장된 파일의 gatherFileIdx를 회신
	@Override
	public void save(GatherFileDto gatherFileDto, MultipartFile multipartFile) throws IllegalStateException, IOException {

		// 0. 시퀀스 획득
		int sequence = sqlSession.selectOne("gatherFile.getSequence");

		// 1. 실제 파일을 업로드 폴더에 저장
		File target = new File(directory, String.valueOf(sequence));
		multipartFile.transferTo(target);

		// 2. 파일의 정보를 DB에 저장
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
