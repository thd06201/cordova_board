package com.kubg.persistence;

import com.kubg.domain.MemberVO;

public interface MemberDAO {
	
	//로그인
	public MemberVO signin(MemberVO vo) throws Exception;

}
