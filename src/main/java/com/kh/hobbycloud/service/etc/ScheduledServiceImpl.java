package com.kh.hobbycloud.service.etc;

import org.springframework.stereotype.Service;

//@Slf4j
@Service
public class ScheduledServiceImpl implements ScheduledService {

	// 초 분 시 일 월 요일 연도 순이며, 마지막의 연도는 보통 쓰지 않으므로 생략한다.
	// @Scheduled(initialDelay = 1000L, fixedDelay = 2000L) // 1초후부터 2초마다
	// @Scheduled(cron = "*/2 * * * * *")                   // 매 2초 매분 매시각 매일 매월 매요일마다(2초마다)
	// @Scheduled(cron = "10-20 * * * * *")                 // 매 분 10~20초 사이에만
	// @Scheduled(cron = "0 0 * * * *")                     // 매 정각마다
	// @Scheduled(cron = "0 0 9-18 * * 1-5")                // 업무시간 중 매 정각
	// @Scheduled(cron = "0 0 9,18 * * 1-5")                // 출,퇴근시에만 (오전9시, 오후6시)
	// @Scheduled(cron = "0 0 9,18 * * mon-fri")            // 출,퇴근시에만 (오전9시, 오후6시)
	// @Scheduled(cron = "0 0 15 25 * ?")                   // 매월 25일 오후 3시(요일무관)
	// @Scheduled(cron = "* * * ? * 4L")                    // 매월 마지막 목요일(L은 마지막이란 의미)
	// @Scheduled(cron = "* * * ? * 4#4")                   // 매월 4주차 목요일
	// @Scheduled(initialDelay = 1000L, fixedDelay = 2000L) // 1초후부터 2초마다

	/*
	@Value("${CONFIG.SERVER_ROOT}") String root;
	@Value("${CONFIG.SERVER_PORT}") String port;
	@Value("${CONFIG.CONTEXT_NAME}") String contextName;
	@Scheduled(cron = "0 0 0 1 1 *") // 매 0초 0분 0시 1일 1월 즉 신년 자정마다 실행*/
	@Override
	public void newAgeMail() {
		/*
		String rootPath = root + ":" + port + "/" + contextName + "/";
		StringBuffer sb = new StringBuffer();
		sb.append(LocalDate.now().getYear() + "년을 축하드립니다.<br/>");
		sb.append("KH 8기 HobbyCloud 홈페이지는 아직도 정상 가동중입니다.<br/>");
		sb.append("주소는 <a href='" + rootPath + "'>" + rootPath + "</a> 입니다.</br>");
		sb.append("많이많이 들러주세요.");
		log.debug(sb.toString());
		*/
	}

}
