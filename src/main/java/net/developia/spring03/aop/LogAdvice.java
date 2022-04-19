package net.developia.spring03.aop;

import org.aspectj.lang.annotation.AfterThrowing;
import org.aspectj.lang.annotation.Aspect;
import org.springframework.stereotype.Component;

import lombok.extern.log4j.Log4j;

@Aspect
@Log4j
@Component
public class LogAdvice {
	
	@AfterThrowing(pointcut = "execution(* net.developia.spring03.service.BoardService*.*(..))",
			throwing = "exception")
	public void logException(Exception exception) throws Exception {
		log.info("logException 수행 중");
		log.info(exception.toString());
		throw exception;
	}
	
	@AfterThrowing(pointcut = "execution(* net.developia.spring03.service.UserService*.*(..))",
			throwing = "exception")
	public void logException1(Exception exception) throws Exception {
		log.info("logException 수행 중");
		log.info(exception.toString());
		throw exception;
	}
}
