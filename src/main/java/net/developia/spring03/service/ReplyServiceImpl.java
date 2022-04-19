package net.developia.spring03.service;

import java.util.List;

import org.springframework.stereotype.Service;

import lombok.extern.log4j.Log4j;
import net.developia.spring03.dao.ReplyDAO;
import net.developia.spring03.dto.ReplyDTO;

@Log4j
@Service
public class ReplyServiceImpl implements ReplyService {
	
	private ReplyDAO replyDAO;
		
	public ReplyServiceImpl(ReplyDAO replyDAO) {
		this.replyDAO = replyDAO;
	}

	@Override 
	public List<ReplyDTO> readReply(Long bno) throws Exception{
		log.info("replyListbno : " + bno);
		return replyDAO.readReply(bno); 
	}

	@Override 
	public int insertReply(ReplyDTO dto) throws Exception{ 
		return replyDAO.insertReply(dto); 
	}

	@Override public void deleteReply(int rno) throws Exception{
		replyDAO.deleteReply(rno); 
	}

	@Override public void updateReply(ReplyDTO dto) throws Exception{ 
		replyDAO.updateReply(dto);
	}

}
