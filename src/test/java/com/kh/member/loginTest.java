package com.kh.member;

import static org.junit.Assert.assertTrue;

import org.apache.ibatis.session.SqlSession;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;

import com.kh.hobbycloud.entity.member.MemberDto;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {
		"file:src/main/webapp/WEB-INF/spring/root-context.xml", 
		"file:src/main/webapp/WEB-INF/spring/appServlet/servlet-context.xml"
})
@WebAppConfiguration
public class loginTest {
	
	@Autowired
	private SqlSession sqlSession;
	
	@Test
	public void loginTest() {
		String memberIdx = "1", memberPw = "testmember";
		
		MemberDto memberDto = sqlSession.selectOne("member.get", memberIdx);
		boolean isLogin = memberDto != null && memberPw.equals(memberDto.getMemberPw());
		assertTrue(isLogin);		
	}
	
}
