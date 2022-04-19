package net.developia.spring03.dao;

import net.developia.spring03.dto.MemberDTO;

public interface MemberDAO { // DAO
	
	MemberDTO read (String userid);
}
