package net.developia.spring03;

import java.sql.Connection;
import java.sql.DriverManager;

import org.junit.Test;

import lombok.extern.log4j.Log4j;

@Log4j
public class JdbcTest {
	
	static {
		try {
			Class.forName("net.sf.log4jdbc.DriverSpy");
		} catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	@Test
	public void testConnection() {
		try {
			Connection conn = DriverManager.getConnection("jdbc:log4jdbc:oracle:thin:@localhost:1521/xepdb1", "ace", "me");
			log.info(conn);
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
	}
	
}
