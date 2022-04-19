package net.developia.spring03.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import lombok.extern.log4j.Log4j;
import net.developia.spring03.dao.BoardDAO;
import net.developia.spring03.dto.AttachFileDTO;
import net.developia.spring03.dto.BoardDTO;

@Log4j
@Service
public class BoardServiceImpl implements BoardService {

	private BoardDAO boardDAO;

	@Value("${pageSize}")
	private int pageSize;

	public BoardServiceImpl(BoardDAO boardDAO) {
		this.boardDAO = boardDAO;
	}

	@Transactional
	@Override
	public void insertBoard(BoardDTO boardDTO) throws Exception {
		boardDAO.insertBoard(boardDTO);

		if (boardDTO.getAttachList() == null || boardDTO.getAttachList().size() <= 0) {
			return;
		}

		boardDTO.getAttachList().forEach(attach -> {
			attach.setBno(boardDTO.getNo());
			try {
				boardDAO.insertFile(attach);
			} catch (Exception e) {
				e.printStackTrace();
			}
		});
	}

	@Override
	public BoardDTO getDetail(long no) throws Exception {
		if (no == -1) {
			throw new RuntimeException("잘못된 접근입니다");
		}
		boardDAO.updateReadCount(no);
		BoardDTO boardDTO = boardDAO.getDetail(no);

		if (boardDTO == null) {
			throw new RuntimeException(no + "번 글이 존재하지 않습니다.");
		}
		return boardDTO;

	}

	@Override
	public void deleteBoard(BoardDTO boardDTO) throws Exception {
		if (boardDAO.deleteBoard(boardDTO) == 0) {
			throw new RuntimeException("해당하는 게시물이 없거나 비밀번호가 틀립니다.");
		}
	}
	
	@Transactional
	@Override
	public void updateBoard(BoardDTO boardDTO) throws Exception {
		
		boardDAO.deleteFileAll(boardDTO.getNo());
		
		boolean modifyResult = boardDAO.updateBorad(boardDTO) == 1;
		
		if(modifyResult && boardDTO.getAttachList() != null && boardDTO.getAttachList().size() > 0) {
			boardDTO.getAttachList().forEach(attach -> {
				attach.setBno(boardDTO.getNo());
				try {
					boardDAO.insertFile(attach);
				} catch (Exception e) {
					e.printStackTrace();
				}
			});			
		}

	}

	@Override
	public List<BoardDTO> getBoardListPage(long pg) throws Exception {
		long startNum = (pg - 1) * pageSize + 1; // endNum을 먼저 구해서 StartNum = endNum - pageSize + 1 도 가능한 방법
		long endNum = pg * pageSize;

		return boardDAO.getBoardListPage(startNum, endNum);

	}

	@Override
	public long getBoardCount() throws Exception {
		return boardDAO.getBoardCount();

	}

	@Override
	public List<AttachFileDTO> getAttachList(Long bno) throws Exception{
		log.info("get Attach list by bno" + bno);

		return boardDAO.findByBno(bno);
	}

}
