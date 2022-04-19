package net.developia.spring03.service;

import java.util.List;

import net.developia.spring03.dto.ReplyDTO;

public interface ReplyService {

	List<ReplyDTO> readReply(Long bno) throws Exception;

	int insertReply(ReplyDTO dto) throws Exception;

	void deleteReply(int rno) throws Exception;

	void updateReply(ReplyDTO dto) throws Exception;
}
