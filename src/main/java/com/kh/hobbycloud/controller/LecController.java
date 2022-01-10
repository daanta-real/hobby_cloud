package com.kh.hobbycloud.controller;

import java.io.IOException;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.ByteArrayResource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.kh.hobbycloud.entity.lec.LecFileDto;
import com.kh.hobbycloud.entity.member.MemberDto;
import com.kh.hobbycloud.repository.lec.LecCategoryDao;
import com.kh.hobbycloud.repository.lec.LecDao;
import com.kh.hobbycloud.repository.lec.LecFileDao;
import com.kh.hobbycloud.repository.member.MemberDao;
import com.kh.hobbycloud.service.lec.LecCartService;
import com.kh.hobbycloud.service.lec.LecService;
import com.kh.hobbycloud.vo.lec.LecCartVO;
import com.kh.hobbycloud.vo.lec.LecCriteria;
import com.kh.hobbycloud.vo.lec.LecDetailVO;
import com.kh.hobbycloud.vo.lec.LecLikeVO;
import com.kh.hobbycloud.vo.lec.LecListVO;
import com.kh.hobbycloud.vo.lec.LecPageMaker;
import com.kh.hobbycloud.vo.lec.LecRegisterVO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/lec")
public class LecController {

	@Autowired
	private LecService lecService;

	@Autowired
	private LecCartService lecCartService;

	@Autowired
	private LecDao lecDao;
	
	@Autowired
	private MemberDao memberDao;

	@Autowired
	private LecFileDao lecFileDao;

	@Autowired
	private LecCategoryDao lecCategoryDao;

	//목록
	@GetMapping("/list")
	public String list(Model model,LecCriteria cri) {
		model.addAttribute("list", lecService.list(cri));

		LecPageMaker pageMaker = new LecPageMaker();
		pageMaker.setCri(cri);
		pageMaker.setTotalCount(lecService.listCount());
		model.addAttribute("pageMaker",pageMaker);

		System.out.println(lecService.list(cri));
		return "lec/list";
	}

	//목록(검색 가능)
	@RequestMapping("/list")
	public String search(@RequestParam Map<String ,Object> param , Model model) {
		model.addAttribute("param", param);
		List<LecListVO> listSearch = lecDao.listSearch(param);
		model.addAttribute("listSearch", listSearch);
		return "lec/list";
	}


	//강좌 등록
	@GetMapping("/register")
	public String insert() {
		return "lec/register";
	}

	@PostMapping("/register")
	public String register(@ModelAttribute LecRegisterVO lecRegisterVO) throws IllegalStateException, IOException {
//		session.setAttribute("tutorIdx", lecRegisterVO.getTutorIdx());
		int lecIdx = lecService.register(lecRegisterVO);
		return "redirect:detail/" + lecIdx;
	}

	@GetMapping("/register_success")
	public String register_success() {
		return "lec/register_success";
	}

	//상세
	@RequestMapping("/detail/{lecIdx}")
	public String detail(@PathVariable int lecIdx, HttpSession session, Model model) {
		LecDetailVO lecDetailVO = lecDao.get(lecIdx);

		List<LecFileDto> list = lecFileDao.getListByLecIdx(lecIdx);
		model.addAttribute("lecDetailVO", lecDetailVO);
		model.addAttribute("list", list);

		log.debug("세션 memberIdx = {},", session.getAttribute("memberIdx"));

		//좋아요 구현
		//회원일때 보이고 비회원이면 안보이고
		if(session.getAttribute("memberIdx") != null) {
			LecLikeVO lecLikeVO = new LecLikeVO();
			lecLikeVO.setLecIdx(lecIdx);
			int isLike = 0;

			lecLikeVO.setMemberIdx((Integer)session.getAttribute("memberIdx"));

			int check = lecService.likeCount(lecLikeVO);
			if(check ==0) {
				lecService.likeInsert(lecLikeVO);
			}else if(check==1) {
				isLike = lecService.likeGetInfo(lecLikeVO);
			}

			model.addAttribute("isLike", isLike);
		}

		return "lec/detail";
	}

	// 강좌 수정 폼 페이지 불러오기
	@GetMapping("/edit/{lecIdx}")
	public String update(@PathVariable int lecIdx, Model model) {
		log.debug("ㅡㅡㅡ /lec/edit?" + lecIdx + " (강좌 파일 수정 GET) 진입");

		// 데이터 획득: VO 및 DTO
		LecDetailVO lecDetailVO = lecDao.get(lecIdx);
		log.debug("ㅡㅡㅡ lecDetailVO: {}", lecDetailVO);
		model.addAttribute("lecDetailVO", lecDetailVO);

		// 데이터 획득: 카테고리 목록
		List<String> lecCategoryList = lecCategoryDao.select();
		model.addAttribute("lecCategoryList", lecCategoryList);

		// 획득된 데이터를 Model에 지정
		List<LecFileDto> fileList = lecFileDao.getListByLecIdx(lecIdx);
		log.debug("ㅡㅡㅡ List<LecFileDto> fileList = {}", fileList);
		model.addAttribute("fileList", fileList);

		log.debug("ㅡㅡㅡ 수정 화면으로 진입합니다.");
		return "lec/edit";
	}

	// 강좌 삭제
	@GetMapping("/delete/{lecIdx}")
	public String delete(@PathVariable int lecIdx) {
		lecDao.delete(lecIdx);
		return "redirect:list";
	}

	// 파일 전송 다운로드 (파일 전송 실시)
	@GetMapping("/lecFile/{lecFileIdx}")
	@ResponseBody
	public ResponseEntity<ByteArrayResource> file(@PathVariable int lecFileIdx) throws IOException {

		// 0. 매개변수로 lecIdx가 넘어와 있다.
		System.out.println("ㅡㅡㅡㅡㅡㅡ 0. 요청된 lecIdx : " + lecFileIdx);

		// 1. lecIdx를 이용하여, 이미지 파일정보 전체를 DTO로 갖고 온다.
		LecFileDto lecFileDto = lecFileDao.getByLecFileIdx(lecFileIdx);
		System.out.println("ㅡㅡㅡㅡㅡㅡ 1. 갖고온 lecFileDto : "+lecFileDto);

		// 2. 갖고 온 DTO에서 실제 저장 파일명(save name)을 찾아낸다.
		String savename = lecFileDto.getLecFileServerName();
		System.out.println("ㅡㅡㅡㅡㅡㅡ 2. 찾아낸 파일명: " + savename);

		// 3-1. 프로필번호(memberProfileIdx)를 이용하여 내가 전송할 실제 파일 정보를 불러온다
		byte[] data = lecFileDao.load(lecFileIdx);
		ByteArrayResource resource = new ByteArrayResource(data);

		// 보낼 파일명 설정
		String encodeName = URLEncoder.encode(lecFileDto.getLecFileUserName(), "UTF-8");
		encodeName = encodeName.replace("+", "%20");

		// 실제 파일 전송
		return ResponseEntity.ok().contentType(MediaType.APPLICATION_OCTET_STREAM)
			// .header("Content-Disposition", "attachment; filename=\""+이름+"\"")
			.header(HttpHeaders.CONTENT_DISPOSITION, "attachment; filename=\"" + encodeName + "\"")
			.header(HttpHeaders.CONTENT_ENCODING, "UTF-8")
			// .header("Content-Length",
			// String.valueOf(memberProfileDto.getMemberProfileSize()))
			.contentLength(lecFileDto.getLecFileSize()).body(resource);

	}


	//찜하기
	@RequestMapping("/cart/insert")
	public String insert(@ModelAttribute LecCartVO lecCartVO, HttpSession session) {
		//@ModelAttribute로 submit된 form의 내용을 저장해서 전달받고, 다시 뷰로 넘겨서 출력하기 위해 사용
		//로그인 여부를 체크	
		if(session.getAttribute("memberIdx") == null) {//로그인 하지 않았으면
			return "redirect:/member/login";//로그인 화면으로 리다이렉트
		}
		int memberIdx = (Integer)session.getAttribute("memberIdx");
		lecCartVO.setMemberIdx(memberIdx);
		lecCartService.insert(lecCartVO);//찜 테이블에 저장
		return "redirect:/lec/cart_list";//찜 목록으로 이동
	}

	//찜 목록
	@RequestMapping("/cart_list")
	public ModelAndView list(HttpSession session, ModelAndView mav) {
		Map<String, Object> map = new HashMap<>();
		//찜에 담을 값이 많아서 HashMap 사용
		boolean isLogin = session.getAttribute("memberIdx") != null;
		if(isLogin) {//로그인 했으면
			int memberIdx = (Integer)session.getAttribute("memberIdx");
			//얘가 위에 있으면 int memberIdx가 null이라 nullPointerException에러가 뜨니까 꼭 주의!!!!!!!!!!!!!!!!
			List<LecCartVO> list = lecCartService.listCart(memberIdx);//찜 목록
			int totalPrice = lecCartService.totalPrice(memberIdx);//금액 합계

			//map에 찜에 넣을 값 저장
			map.put("totalPrice", totalPrice);//전체 금액
			map.put("list", list);//찜 목록
			map.put("count", list.size());//찜 개수

			//ModelAndView mav에 이동할 페이지의 이름과 데이터를 저장
			mav.setViewName("lec/cart_list");//이동할 페이지 이름
			mav.addObject("map", map); //데이터 저장

			return mav;//화면 이동

		}else {//로그인 안한 상태
			return new ModelAndView("member/login", "", null);
			//로그인 페이지로 이동
		}
	}

	//찜 전체 삭제
	@RequestMapping("/cart/deleteAll")
    public String deleteAll(HttpSession session) {
        boolean isLogin = session.getAttribute("memberIdx") != null;
        if(isLogin) {
        	int memberIdx=(Integer)session.getAttribute("memberIdx");
            lecCartService.deleteAll(memberIdx);
        }
        return "redirect:/lec/cart_list";
    }

	//찜 개별 삭제
	@RequestMapping("/cart/delete/{cartIdx}")
    public String deleteCart(@PathVariable int cartIdx) {
        lecCartService.delete(cartIdx);
        return "redirect:/lec/cart_list";
    }

	//결제(신청) Get페이지
	@GetMapping("/check/{lecIdx}")
	public String check(@PathVariable int lecIdx, HttpSession session, Model model) {
		LecDetailVO lecDetailVO = lecDao.get(lecIdx);
		boolean isLogin = session.getAttribute("memberId") != null;
		if(isLogin) {
			String memberId = (String)session.getAttribute("memberId");
			MemberDto memberDto = memberDao.get(memberId);
			model.addAttribute("memberDto", memberDto);
		}
		else {
			return "redirect:/member/login";
		}
		model.addAttribute("lecDetailVO", lecDetailVO);
		
		return "lec/check";
	}
	
	//강좌 신청 페이지 - 포인트 차감
	//강사님 예전에 구현했던 포인트기능 적용?
//	@PostMapping("/check")
//	public String check(@RequestParam String memberPw,HttpSession session) {
//		//비밀번호 받아서 맞으면 포인트 깎이면서, 내강좌에 추가
//		String memberId = (String)session.getAttribute("memberId");
//		MemberDto memberDto = memberDao.get(memberId);
//		if(memberPw == memberDto.getMemberPw()) {
//		//입력받은 비밀번호와 세션에 저장된 비밀번호가 같다면
//		//내 포인트 감소, 내 강좌 추가, 그리고 강좌 신청 인원 차면 막기
//		//내강좌에 강좌가 등록된 db idx
//		}
//	
//	}
	
	//내 강좌
	@GetMapping("/my_lec")
	public String my_lec(HttpSession session, Model model) {
		String memberId = (String)session.getAttribute("memberId");
//		MyLecDto myLecDto = myLecDao.getMyLec(memberId);
		return "lec/my_lec";
	}
}
