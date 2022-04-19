package net.developia.spring03.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import lombok.extern.log4j.Log4j;
import net.developia.spring03.dto.ReplyDTO;
import net.developia.spring03.service.ReplyService;

@Log4j
@Controller
public class ReplyController {
	
	private ReplyService replyService;
	
	public ReplyController(ReplyService replyService) {
		this.replyService = replyService;
	}

	// 댓글 Insert 메서드
	@PreAuthorize("isAuthenticated()")
	@RequestMapping(value = "replyInsert", method = RequestMethod.POST)
	public ResponseEntity<String> insertReply(@RequestBody ReplyDTO dto) throws Exception{
		ResponseEntity<String> entity = null;

		log.info("ReplyDTO: " + dto);

		try { 
			replyService.insertReply(dto);
			entity = new ResponseEntity<String>("regSuccess", HttpStatus.OK); 
		} catch (Exception e) { 
			e.printStackTrace(); 
			entity = new ResponseEntity<String>(e.getMessage(), HttpStatus.BAD_REQUEST); 
		} 
		return entity;
	}

	//댓글 List 메서드
	@RequestMapping(value = "/replyList/{no}", method = RequestMethod.GET) 
	public ResponseEntity<List<ReplyDTO>> list(@PathVariable("no") long no) throws Exception{
		ResponseEntity<List<ReplyDTO>> entity = null;
		try { 
			entity = new ResponseEntity<List<ReplyDTO>>(replyService.readReply(no), HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<List<ReplyDTO>>(HttpStatus.BAD_REQUEST); } return entity; 
	}


	//댓글 Update 메서드
	@RequestMapping(value = "/updateReply/{no}", method = RequestMethod.POST) 
	public ResponseEntity<String> update(@PathVariable("no") int no, @RequestBody ReplyDTO dto) throws Exception{
		ResponseEntity<String> entity = null;
		try {
			dto.setRno(no);
			replyService.updateReply(dto);
			entity = new ResponseEntity<String>("modSuccess", HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<String>(e.getMessage(), HttpStatus.BAD_REQUEST);
		} 
		return entity; 
	} 

	//댓글 Delete 메서드 
	@RequestMapping(value = "/deleteReply/{no}", method = RequestMethod.POST) 
	public ResponseEntity<String> delete(@PathVariable("no") int no) throws Exception{

		log.info("no :" + no );
		ResponseEntity<String> entity = null;

		try { 
			replyService.deleteReply(no);
			entity = new ResponseEntity<String>("delSuccess", HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<String>(e.getMessage(), HttpStatus.BAD_REQUEST); 
		} 
		return entity; 
	}
}
