@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = { "file:src/main/webapp/WEB-INF/spring/root-context.xml",
		"file:src/main/webapp/WEB-INF/spring/appServlet/servlet-context.xml" })
@WebAppConfiguration
public class TestGather {
	@Autowired
	private SqlSession sqlSession;
		
	
	@Test
	public void orderTest() {
		Map<String, Object> param = new HashMap<>();
		param.put("gatherName", "제");
		param.put("gatherLocRegion", "장");
		
		List<ProductDto> list = sqlSession.selectList("gather.listSearch", param);
		System.out.println(list.size());
		for(ProductDto productDto : list) {
			System.out.println(productDto);
		}
	}
}
