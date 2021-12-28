package com.kh.hobbycloud;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;

import com.kh.hobbycloud.entity.gather.GatherDto;




@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {
		"file:src/main/webapp/WEB-INF/spring/root-context.xml", 
		"file:src/main/webapp/WEB-INF/spring/appServlet/servlet-context.xml"
})
@WebAppConfiguration

public class TestGather {


	@Autowired
	private SqlSession sqlSession;
	
	@Test
	public void test() {
	List<GatherDto> list = sqlSession.selectList("gather.list");
	
	System.out.println(list);
	}
}
