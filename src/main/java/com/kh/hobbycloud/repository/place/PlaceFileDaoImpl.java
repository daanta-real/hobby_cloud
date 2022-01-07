package com.kh.hobbycloud.repository.place;

import java.io.File;
import java.io.IOException;
import java.util.List;

import org.apache.commons.io.FileUtils;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.web.multipart.MultipartFile;

import com.kh.hobbycloud.entity.place.PlaceFileDto;

@Repository
public class PlaceFileDaoImpl implements PlaceFileDao{
	
	@Autowired
	private SqlSession sqlSession;
	
	//파일 관련 첨부파일 저장 위치 문자열
	@Autowired
	private String STOREPATH_PLACE;
	
	// 파일 정보를 DB로 저장한 뒤, 저장된 파일의 placeFileIdx를 회신
	@Override
	public void save(PlaceFileDto placeFileDto, MultipartFile multipartFile) throws IllegalStateException, IOException {

		// 0. 시퀀스 획득
		int sequence = sqlSession.selectOne("placeFile.getSequence");

		// 1. 실제 파일을 업로드 폴더에 저장
		File target = new File(STOREPATH_PLACE, String.valueOf(sequence));
		multipartFile.transferTo(target);

		// 2. 파일의 정보를 DB에 저장
		placeFileDto.setPlaceFileIdx(sequence);
		placeFileDto.setPlaceFileServerName(String.valueOf(sequence));
		sqlSession.insert("placeFile.save",placeFileDto);

	}
	
	//한 개의 장소 첨부파일 DTO 얻기
	@Override
	public PlaceFileDto getNo(int placeFileIdx) {
		return sqlSession.selectOne("placeFile.getNo", placeFileIdx);
	}
	
	//소모임 IDX로 첨부파일 전체 List 불러오기
	@Override
	public List<PlaceFileDto> getIdx(int placeIdx) {
		return sqlSession.selectList("placeFile.getIdx", placeIdx);
	}
	
	// 한 개의 파일 데이터를 회신 (파일명이 idx와 같다)
	@Override
	public byte[] load(int placeFileIdx) throws IOException {
		File target = new File(STOREPATH_PLACE, String.valueOf(placeFileIdx));
		byte[] data = FileUtils.readFileToByteArray(target);
		return data;
	}
	
	//장소 번호로 해당 장소의 사진 다 삭제
	@Override
	public boolean delete(int placeIdx) {
		int count = sqlSession.delete("placeFile.delete",placeIdx);
		return count >0;
	}
	
	@Override
	public boolean deleteAjax(int placeFileIdx) {
		int count =sqlSession.delete("placeFile.deleteAjax",placeFileIdx);
		
		return count >0;
	}

}
