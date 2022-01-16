package com.kh.hobbycloud.repository.place;

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

import com.kh.hobbycloud.entity.place.PlaceFileDto;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Repository
public class PlaceFileDaoImpl implements PlaceFileDao{
	
	@Autowired
	private SqlSession sqlSession;
	
	//파일 관련 첨부파일 저장 위치 문자열
	@Autowired
	private String STOREPATH_PLACE;
	
	// 파일 저장
	// 파일 정보를 DB로 저장한 뒤, 저장된 파일의 placeFileIdx를 회신
	@Override
	public void save(PlaceFileDto placeFileDto, MultipartFile multipartFile) throws IllegalStateException, IOException {
		log.debug("=================PlaceFileDao.save 실행");
		// 0. 시퀀스 획득
		int sequence = sqlSession.selectOne("placeFile.getSequence");
		log.debug("=================PlaceFileDao sequence 획득:"+sequence);
		// 1. 실제 파일을 업로드 폴더에 저장
		File target = new File(STOREPATH_PLACE, String.valueOf(sequence));
		multipartFile.transferTo(target);
		
		// 2. 파일의 정보를 DB에 저장
		placeFileDto.setPlaceFileIdx(sequence);
		placeFileDto.setPlaceFileServerName(String.valueOf(sequence));
		sqlSession.insert("placeFile.save",placeFileDto);
		log.debug("=================PlaceFileDao placeFile.save 실행:"+placeFileDto);

	}
	
	//한 개의 장소 첨부파일 DTO 얻기(placeFileIdx)
	@Override
	public PlaceFileDto getByPlaceFileIdx(int placeFileIdx) {
		log.debug("=================PlaceFileDao.getNo 실행");
		return sqlSession.selectOne("placeFile.getByPlaceFileIdx", placeFileIdx);
	}
	
	// 장소 IDX로 첨부파일 전체 List 불러오기
	@Override	
	public List<PlaceFileDto> getListByPlaceIdx(int placeIdx) {
		return sqlSession.selectList("placeFile.getByPlaceIdx", placeIdx);
	}
	
	// 파일 실제 데이터 byte[]를 리턴
	@Override
	public byte[] load(int placeFileIdx) throws IOException {
		File target = new File(STOREPATH_PLACE, String.valueOf(placeFileIdx));
		byte[] data = FileUtils.readFileToByteArray(target);
		return data;
	}
	
	//파일 삭제 (placeIdx)
	@Override
	public boolean delete(int placeIdx) {
		int count = sqlSession.delete("placeFile.delete",placeIdx);
		return count >0;
	}
	
	// 파일 삭제 (placeFileIdx)
	@Override
	public boolean deleteAjax(int placeFileIdx) {
		int count = sqlSession.delete("placeFile.deleteAjax",placeFileIdx);
		return count > 0;
	}

	// 파일 삭제 (리스트로)
	@Override
	public boolean deleteList(int placeIdx, List<String> list) {
		Map<String, Object> map = new HashMap<>();
		map.put("placeIdx", placeIdx);
		map.put("list", list);
		int count = sqlSession.delete("placeFile.deleteList", map);
		return count > 0;
	}

}
