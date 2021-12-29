package com.kh.hobbycloud.controller;

import java.io.IOException;
import java.net.URLEncoder;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.ByteArrayResource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.kh.hobbycloud.entity.gather.GatherFileDto;
import com.kh.hobbycloud.entity.gather.GatherSearchDto;
import com.kh.hobbycloud.repository.gather.GatherDao;
import com.kh.hobbycloud.repository.gather.GatherFileDao;
import com.kh.hobbycloud.service.gather.GatherService;
import com.kh.hobbycloud.vo.gather.GatherFileVO;
import com.kh.hobbycloud.vo.gather.GatherVO;

import lombok.extern.slf4j.Slf4j;
import oracle.jdbc.proxy.annotation.Post;

@Slf4j
@Controller
@RequestMapping("/gather")
public class GatherController {

	@Autowired
	private GatherDao gatherDao;
	@Autowired
	private GatherService gatherService;
	@Autowired
	private GatherFileDao gatherFileDao;

	@GetMapping("/list")
	public String list(Model model) {
		List<GatherVO> list = gatherDao.list();
		model.addAttribute("list", list);
		System.out.println(list);
		return "gather/list";
	}

	@PostMapping("/list")
	public String search(@ModelAttribute GatherSearchDto gatherSearchDto, Model model) {
//		Map<String , Object> map 
		log.debug("param.toString()   " + gatherSearchDto.toString());
//		List<GatherVO> list = gatherDao.listSearch(param);

//		model.addAttribute("list",list);
		return "gather/list";
	}

	@GetMapping("/insert")
	public String insert() {
		return "gather/insert";
	}

	@PostMapping("/insert")
	public String insert(@ModelAttribute GatherFileVO gatherFileVO) throws IllegalStateException, IOException {
		int gatherIdx = gatherService.save(gatherFileVO);
		System.out.println(gatherFileVO);
		return "redirect:detail?gatherIdx=" + gatherIdx;
	}

	@RequestMapping("/detail")
	public String detail(@RequestParam int gatherIdx, Model model) {
		GatherVO gatherVO = gatherDao.get(gatherIdx);
		List<GatherFileDto> list = gatherFileDao.getIdx(gatherIdx);
		model.addAttribute("GatherVO", gatherVO);
		model.addAttribute("list", list);
		return "gather/detail";
	}

	// 글삭제
	@GetMapping("/delete")
	public String delete(@RequestParam int gatherIdx) {
		gatherDao.delete(gatherIdx);
		return "redirect:list";
	}
	//글 수정
	@GetMapping("/edit")
	public String edit() {
		return "gather/edit";
	}
//	@PostMapping("/edit")
//	public String edit(@ModelAttribute GatherVO gatherVO) {
//		gatherDao.edit(gatherVO);
//		return "redirect:detail";
//	}

	@GetMapping("/file")
	@ResponseBody
	public ResponseEntity<ByteArrayResource> file(@RequestParam int gatherFileIdx) throws IOException {
		// 번호로 이미지 파일정보를 구한다
		GatherFileDto gatherFileDto = gatherFileDao.getNo(gatherFileIdx);

		byte[] data = gatherFileDao.load(gatherFileIdx);
		ByteArrayResource resource = new ByteArrayResource(data);

		String encodeName = URLEncoder.encode(gatherFileDto.getGatherFileUserName(), "UTF-8");
		encodeName = encodeName.replace("+", "%20");

		return ResponseEntity.ok().contentType(MediaType.APPLICATION_OCTET_STREAM)
				// .header("Content-Disposition", "attachment; filename=\""+이름+"\"")
				.header(HttpHeaders.CONTENT_DISPOSITION, "attachment; filename=\"" + encodeName + "\"")
				.header(HttpHeaders.CONTENT_ENCODING, "UTF-8")
				// .header("Content-Length",
				// String.valueOf(memberProfileDto.getMemberProfileSize()))
				.contentLength(gatherFileDto.getGatherFileSize()).body(resource);
	}
}