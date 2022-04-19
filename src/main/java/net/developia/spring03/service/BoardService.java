package net.developia.spring03.service;

import java.util.List;

import net.developia.spring03.dto.AttachFileDTO;
import net.developia.spring03.dto.BoardDTO;

public interface BoardService {

	void insertBoard(BoardDTO boardDTO) throws Exception;

	BoardDTO getDetail(long no) throws Exception;

	void deleteBoard(BoardDTO boardDTO) throws Exception;

	void updateBoard(BoardDTO boardDTO) throws Exception;

	List<BoardDTO> getBoardListPage(long pg) throws Exception;

	long getBoardCount() throws Exception;

	List<AttachFileDTO> getAttachList(Long bno) throws Exception;

}
