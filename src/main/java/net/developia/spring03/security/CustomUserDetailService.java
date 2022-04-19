package net.developia.spring03.security;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;

import lombok.extern.log4j.Log4j;
import net.developia.spring03.dao.MemberDAO;
import net.developia.spring03.dto.CustomUser;
import net.developia.spring03.dto.MemberDTO;

@Log4j
public class CustomUserDetailService implements UserDetailsService{
	
	@Autowired
	private MemberDAO memberDAO;
	
	@Override
	public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
		
		log.warn("Load User By UserId  : " + username);
		
		MemberDTO dto = memberDAO.read(username);
		
		log.warn("queried by mamber mapper : " + dto);
		
		return dto == null ? null : new CustomUser(dto);
	}
	
	
}
