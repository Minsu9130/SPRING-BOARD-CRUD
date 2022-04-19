package net.developia.spring03.dao;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import lombok.Setter;
import lombok.extern.log4j.Log4j;
import net.developia.spring03.dto.MemberDTO;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration({"file:src/main/webapp/WEB-INF/spring/root-context.xml"})
@Log4j
public class MemberMapperTests {
	
	@Setter(onMethod_ = @Autowired)
	private MemberDAO memberDAO;
	
	@Test
	public void testRead() {
		MemberDTO dto = memberDAO.read("admin90");
		
		log.info(dto);
		
		dto.getAuthList().forEach(authVO -> log.info(authVO));
				
	}
}
