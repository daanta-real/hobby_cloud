package com.kh.hobbycloud.repository.lec;

import java.util.List;

import com.kh.hobbycloud.vo.lec.LecCategoryUpdateVO;

public interface LecCategoryDao {

	public void insert(String str);

	public List<String> select();

	public int update(LecCategoryUpdateVO vo);

	public void delete(String str);

}
