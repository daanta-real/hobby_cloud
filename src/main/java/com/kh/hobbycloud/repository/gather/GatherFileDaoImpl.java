package com.kh.hobbycloud.repository.gather;

import java.io.File;
import java.io.IOException;
import java.util.List;

import org.apache.commons.io.FileUtils;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.web.multipart.MultipartFile;

import com.kh.hobbycloud.entity.gather.GatherFileDto;

@Repository
public class GatherFileDaoImpl implements GatherFileDao {

	// 변수 준비
	// MyBatis 객체
	@Autowired
	private SqlSession sqlSession;
	// 소모임 관련 첨부파일 저장 위치 문자열
	@Autowired
	private String STOREPATH_GATHER;
	// 소모임 관련 첨부파일 저장소 파일 객체
	// private File directory = new File(STOREPATH_GATHER);

	// 파일 정보를 DB로 저장한 뒤, 저장된 파일의 gatherFileIdx를 회신
	@Override
	public void save(GatherFileDto gatherFileDto, MultipartFile multipartFile) throws IllegalStateException, IOException {

		// 0. 시퀀스 획득
		int sequence = sqlSession.selectOne("gatherFile.getSequence");

		// 1. 실제 파일을 업로드 폴더에 저장
		File target = new File(STOREPATH_GATHER, String.valueOf(sequence));
		multipartFile.transferTo(target);

		// 2. 파일의 정보를 DB에 저장
		gatherFileDto.setGatherFileIdx(sequence);
		gatherFileDto.setGatherFileServerName(String.valueOf(sequence));
		sqlSession.insert("gatherFile.save",gatherFileDto);

		/*
		for(MultipartFile file : attach) {
		int sequence = sqlSession.selectOne("gatherFile.getSequence");
		File target = new File(directory, String.valueOf(sequence));
		file.transferTo(target);
		gatherFileDto.setGatherFileIdx(sequence);
		gatherFileDto.setGatherFileServerName(String.valueOf(sequence));
		sqlSession.insert("gatherFile.save", gatherFileDto);
			}
		}
	 	*/

	}

	// 한 개의 소모임첨부파일 DTO 얻기
	@Override
	public GatherFileDto getNo(int gatherFileIdx) {
		return sqlSession.selectOne("gatherFile.getNo", gatherFileIdx);
	}

	// 소모임 IDX로 첨부파일 전체 List 불러오기
	@Override
	public List<GatherFileDto> getIdx(int gatherIdx) {
		return sqlSession.selectList("gatherFile.getIdx", gatherIdx);
	}

	// 한 개의 파일 데이터를 회신 (파일명이 idx와 같다)
	@Override
	public byte[] load(int gatherFileIdx) throws IOException {
		File target = new File(STOREPATH_GATHER, String.valueOf(gatherFileIdx));
		byte[] data = FileUtils.readFileToByteArray(target);
		return data;
	}

	//소모임 번호로 해당게시물의 사진 다 삭제
	@Override
	public boolean delete(int gatherIdx) {
		int count = sqlSession.delete("gatherFile.delete",gatherIdx);
		return count >0;
	}

	@Override
	public boolean deleteAjax(int gatherFileIdx) {
		int count =sqlSession.delete("gatherFile.deleteAjax",gatherFileIdx);
		
		return count >0;
	}

}
