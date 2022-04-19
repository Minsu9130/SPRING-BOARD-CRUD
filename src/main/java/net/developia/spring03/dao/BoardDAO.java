package net.developia.spring03.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import net.developia.spring03.dto.AttachFileDTO;
import net.developia.spring03.dto.BoardDTO;

// BoardDAO 구현체는 root-context.xml에서 MapperFactoryBean가 생성해주므로 만들 필요 없음 
public interface BoardDAO {

	void insertBoard(BoardDTO boardDTO) throws Exception;

	BoardDTO getDetail(long no) throws Exception;

	void updateReadCount(long no) throws Exception;

	int deleteBoard(BoardDTO boardDTO) throws Exception;

	int updateBorad(BoardDTO boardDTO) throws Exception;

	//parameter Map? 으로도 만들어서 보낼수 있지만 번거로움
	List<BoardDTO> getBoardListPage(@Param("startNum") long startNum, @Param("endNum") long endNum)  throws Exception;

	long getBoardCount() throws Exception;

	void insertFile(AttachFileDTO attach) throws Exception;

	void insertSelectKey(BoardDTO boardDTO) throws Exception;

	List<AttachFileDTO> findByBno(Long bno) throws Exception;

	void deleteFileAll(long no) throws Exception;

}
