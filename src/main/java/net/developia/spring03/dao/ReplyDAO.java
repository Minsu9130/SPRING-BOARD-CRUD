package net.developia.spring03.dao;

import java.util.List;

import net.developia.spring03.dto.ReplyDTO;

public interface ReplyDAO {
	
	List<ReplyDTO> readReply(Long bno) throws Exception;

	int insertReply(ReplyDTO dto) throws Exception;

	int deleteReply(int rno) throws Exception;

	int updateReply(ReplyDTO dto) throws Exception;
}
