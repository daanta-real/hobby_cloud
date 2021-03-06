package com.kh.hobbycloud.repository.gather;

import java.io.IOException;
import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import com.kh.hobbycloud.entity.gather.GatherFileDto;

public interface GatherFileDao {
	void save(GatherFileDto gatherFileDto,MultipartFile multipartFile) throws IllegalStateException, IOException;
	GatherFileDto getNo(int gatherFileIdx);
	List<GatherFileDto> getIdx(int gatherIdx);
	byte[] load(int gatherFileIdx) throws IOException;
	//파일삭제
	boolean delete(int gatherIdx);
	//실시간삭제
	boolean deleteAjax(int gatherFileIdx);
	//파일 삭제(리스트로)
	boolean deleteList(int gatherIdx, List<String> list); 
	
}
