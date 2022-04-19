package net.developia.spring03;

import java.text.DateFormat;
import java.util.Date;
import java.util.Locale;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import lombok.extern.log4j.Log4j;

/**
 * Handles requests for the application home page.
 */


// @Log4j -> 오류나서 어태까지 slf4j를 사용했었음 
@Log4j
// 오류 해결 : pom.xml에 <scope>runtime</scope>를 주석처리
@Controller
public class HomeController {
	
	/**
	 * Simply selects the home view to render by returning its name.
	 */
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(Locale locale, Model model) {
		//log.info("Welcome home! The client locale is {}.=", locale);
		log.info("Welcome home! The client locale is = " + locale);
		
		return "redirect:list";
	}
	
}
