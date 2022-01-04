package com.kh.hobbycloud.service.petitions;

import java.io.IOException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.kh.hobbycloud.entity.notice.NoticeFileDto;
import com.kh.hobbycloud.entity.petitions.PetitionsDto;
import com.kh.hobbycloud.entity.petitions.PetitionsFileDto;
import com.kh.hobbycloud.repository.petitions.PetitionsDao;
import com.kh.hobbycloud.repository.petitions.PetitionsFileDao;
import com.kh.hobbycloud.vo.petitions.PetitionsVO;

@Service
public class PetitionsServiceImpl implements PetitionsService{
	@Autowired
	private PetitionsDao petitionsDao;

	@Autowired
	private PetitionsFileDao petitionsFileDao;

	@Override
	public void save(PetitionsVO petitionsVO) throws IllegalStateException, IOException {
		PetitionsDto petitionsDto = new PetitionsDto();

		petitionsDto.setPetitionsIdx(petitionsVO.getPetitionsIdx());

		petitionsDto.setMemberIdx(petitionsVO.getMemberIdx());
		petitionsDto.setPetitionsName(petitionsVO.getPetitionsName());
		petitionsDto.setPetitionsDetail(petitionsVO.getPetitionsDetail());
		petitionsDto.setPetitionsRegistered(petitionsVO.getPetitionsRegistered());
		petitionsDto.setPetitionsReplies(petitionsVO.getPetitionsReplies());
		petitionsDto.setPetitionsView(petitionsVO.getPetitionsViews());
		petitionsDao.insert(petitionsDto);
		petitionsDao.edit(petitionsVO);
		// 실제 파일 업로드 시도 → 성공 시 파일정보를 DB에 저장
		List<MultipartFile> attach = petitionsVO.getAttach();
		for (MultipartFile file : attach) {

			// 우선 각 파일 비어있는지 확인. 파일이 비어있으면 이 파일 처리 생략
			if (file.isEmpty())
				continue;

			// 파일 정보에 대한 DTO 생성
			PetitionsFileDto petitionsFileDto = new PetitionsFileDto();
			petitionsFileDto.setPetitionsIdx(petitionsVO.getPetitionsIdx());
			petitionsFileDto.setPetitionsFileMemberName(file.getOriginalFilename());
			petitionsFileDto.setPetitionsFileType(file.getContentType());
			petitionsFileDto.setPetitionsFileSize(file.getSize());
			// 파일 업로드 후, 파일정보를 DB에 저장
			petitionsFileDao.save(petitionsFileDto, file);
		
	}
	

}
}
