package com.kh.hobbycloud.repository.petitions;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.hobbycloud.entity.petitions.PetitionsDto;
import com.kh.hobbycloud.vo.gather.Criteria;
import com.kh.hobbycloud.vo.petitions.PetitionsVO;

@Repository
public class PetitionsDaoImpl implements PetitionsDao {

	@Autowired
	private SqlSession sqlSession;

	@Override
	public List<PetitionsVO> list() {

		return sqlSession.selectList("petitions.list");
	}

	@Override
	public PetitionsVO get(int petitionsIdx) {

		return sqlSession.selectOne("petitions.get", petitionsIdx);
	}

	@Override
	public void insert(PetitionsDto petitionsDto) {
		sqlSession.insert("petitions.insert", petitionsDto);

	}

	@Override
	public void delete(int petitionsIdx) {
		sqlSession.delete("petitions.delete", petitionsIdx);

	}

	@Override
	public boolean edit(PetitionsVO petitionsVO) {
		int count = sqlSession.update("petitions.edit", petitionsVO);
		return count > 0;
	}

	@Override
	public int getsequences() {

		return sqlSession.selectOne("petitions.seq");
	}

	@Override
	public List<PetitionsVO> search(String column, String keyword) {
		// 주의 :
		// = 마이바티스 구문을 부를 때는 데이터를 1개만 전달할 수 있다.
		// = 보내야 할 값이 여러개라면 객체나 Map을 사용한다.
		Map<String, Object> param = new HashMap<>();
		param.put("column", column);
		param.put("keyword", keyword);
		return sqlSession.selectList("petitions.search", param);

	}

	@Override
	public void views(int petitionsIdx) {
		sqlSession.update("petitions.views",petitionsIdx);

	}

	@Override
	public void read(PetitionsDto petitionsDto) {
		sqlSession.update("petitions.read",petitionsDto);

	}

	@Override
	public List<PetitionsVO> listPage(int startRow, int endRow) {
		Map<String, Object> param = new HashMap<>();
		param.put("startRow", startRow);
		param.put("endRow", endRow);
		return sqlSession.selectList("petitions.listPage",param);
	}

	@Override
	public List<PetitionsVO> list(Criteria cri) {
		return sqlSession.selectList("petitions.listPage",cri);
	}

	@Override
	public int listCount() {
		return sqlSession.selectOne("petitions.listCount");
	}

	@Override
	public boolean replyCount(PetitionsDto petitionsDto) {
		int count = sqlSession.update("petitions.replyCount", petitionsDto);
		return count > 0;
	}

	


}
