package com.kh.hobbycloud.repository.tutor;

public interface TutorDao {
	void insert(int memberIdx);//강사 등록
	void update(int tutorIdx);//등록된 강사의 tutorDetail 수정
	void delete(int memberIdx);//강사 자격 박탈
	int getTutorIdx(int memberIdx);//강사 Idx 조회
}
