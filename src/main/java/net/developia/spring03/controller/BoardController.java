package net.developia.spring03.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import lombok.extern.log4j.Log4j;
import net.developia.spring03.dto.AttachFileDTO;
import net.developia.spring03.dto.BoardDTO;
import net.developia.spring03.service.BoardService;

@Log4j
@Controller
public class BoardController {

	//@Autowired
	private BoardService boardService;

	@Value("${pageSize}")
	private int pageSize;

	@Value("${blockSize}")
	private long blockSize;

	// 생성자가 있으면 @Autowired로 주입해주지 않아도 됨
	public BoardController(BoardService boardService) {
		this.boardService = boardService;
	}

	@GetMapping("insert")
	@PreAuthorize("isAuthenticated()")
	public String insertBoard() {
		return "board.insert";
	}
	
	// 게시글 insert 메서드
	@PostMapping("insert")
	@PreAuthorize("isAuthenticated()")
	public String insertBoard(@ModelAttribute BoardDTO boardDTO, RedirectAttributes rttr,
			Model model) {
		log.info(boardDTO.toString());
		try {
			// 게시글을 insert 할때 파일이 유무를 if문으로 판단
			if(boardDTO.getAttachList() != null) {

				boardDTO.getAttachList().forEach(attach -> log.info(attach));
			}
			boardService.insertBoard(boardDTO);
			rttr.addFlashAttribute("result", boardDTO.getNo());
			return "redirect:list";
		} catch (Exception e) {
			model.addAttribute("msg", "입력 에러");
			model.addAttribute("url", "javascript:history.back();");
			return "result";
		}
	}
	
	// 게시판 목록에서 특정 게시글 상세보기 메서드
	@GetMapping("detail/{no}/{pg}")
	public String detail(@PathVariable("no") long no, @PathVariable("pg") long pg, @RequestParam long vn,
			Model model) {
		try {
			BoardDTO boardDTO = boardService.getDetail(no);
			model.addAttribute("boardDTO", boardDTO);
			model.addAttribute("pg", pg);
			model.addAttribute("vn", vn);
			return "board.detail";
		} catch(RuntimeException e) {
			model.addAttribute("msg", e.getMessage());
			model.addAttribute("url", "list");
			return "result";
		} catch (Exception e) {
			model.addAttribute("msg", "상세보기 에러");
			model.addAttribute("url", "list");
			return "result";
		}
	}
	
	// 게시글 delete 메서드
	@GetMapping("delete/{no}")
	public String delete(@PathVariable long no, @RequestParam long vn, Model model) {
		model.addAttribute("vn", vn);
		return "board.delete";
	}
	

	@PostMapping("delete/{no}")
	public ModelAndView delete(@RequestParam long vn, @ModelAttribute BoardDTO boardDTO) {
		ModelAndView mav = new ModelAndView("result");
		try {
			boardService.deleteBoard(boardDTO);
			mav.addObject("msg", vn + "번 게시물이 삭제되었습니다.");
			mav.addObject("url", "../list");
		} catch (Exception e) {
			mav.addObject("msg", e.getMessage());
			mav.addObject("url", "javascript:history.back();");
		}
		return mav;
	}
	
	// 게시글 update 메서드
	@GetMapping("update/{no}/{pg}")
	public String update(@PathVariable long no, @PathVariable long pg, @RequestParam long vn, Model model) throws Exception {
		try {
			BoardDTO boardDTO = boardService.getDetail(no);
			model.addAttribute("boardDTO", boardDTO);
			model.addAttribute("vn", vn);
			return "board.update";
		} catch (Exception e) {
			model.addAttribute("msg", "해당하는 게시물이 없거나 시스템 에러입니다.");
			model.addAttribute("url", "../list");
			return "result";
		}

	}

	@PostMapping("update/{no}/{pg}")
	public String updateBoard(@PathVariable long pg, @RequestParam long vn, @ModelAttribute BoardDTO boardDTO,
			Model model) {

		log.info(boardDTO.toString());
		try {
			boardService.updateBoard(boardDTO);
			model.addAttribute("msg", vn + "번 게시물이 수정되었습니다.");
			model.addAttribute("url", "../../detail/" + boardDTO.getNo() + "/" + pg + "/?vn=" + vn);
			return "result";
		} catch (Exception e) {
			model.addAttribute("msg", e.getMessage());
			model.addAttribute("url", "javascript:history.back();");
			return "result";
		}
	}
	
	// 게시글 list 메서드, 페이징기능도 포함
	@GetMapping("list")
	public String list(@RequestParam(defaultValue = "1") long pg, Model model) throws Exception{	
		try {	
			long recordCount = boardService.getBoardCount();
			long pageCount = recordCount / pageSize;
			if (recordCount % pageSize != 0) pageCount++;

			long startPage = (pg - 1) / blockSize * blockSize + 1;
			// (pg -1) 를 해주는 이유는 endPage로 나타나는 값이 한자릿수 올라가기 때문에 일의 빼줘서 맞춰줘야 함
			long endPage = (pg - 1) / blockSize * blockSize + blockSize;
			if (endPage > pageCount) endPage = pageCount;

			List<BoardDTO> list = boardService.getBoardListPage(pg);
			log.info("보드보드 : " + list);
			model.addAttribute("list", list);
			model.addAttribute("pageCount", pageCount);
			model.addAttribute("pg", pg);
			model.addAttribute("startPage", startPage);
			model.addAttribute("endPage", endPage);
			model.addAttribute("recordCount", recordCount);
			model.addAttribute("pageSize", pageSize);
			return "board.list";
		} catch (Exception e) {
			model.addAttribute("msg", "list 출력 에러");
			model.addAttribute("url", "index");
			return "result";
		}
	}

	// 게시글에서 File List 확인 메서드
	@GetMapping(value= "getAttachList", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public ResponseEntity<List<AttachFileDTO>> getAttachList (Long bno) throws Exception {
		log.info("getAttachList" + bno);

		return new ResponseEntity<>(boardService.getAttachList(bno), HttpStatus.OK);
	}
	
}
