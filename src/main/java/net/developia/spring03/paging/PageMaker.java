package net.developia.spring03.paging;

import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;

import org.springframework.web.util.UriComponents;
import org.springframework.web.util.UriComponentsBuilder;

import lombok.Data;

@Data
public class PageMaker { 
	private int totalCount; 
	private int startPage; 
	private int endPage; 
	private boolean prev;
	private boolean next;
	private int displayPageNum = 10; // 하단 페이지 번호의 갯수 
	private Criteria criteria; 

	public void setCriteria(Criteria criteria) { 
		this.criteria = criteria; 
	} 

	public void setTotalCount(int totalCount) { 
		this.totalCount = totalCount; calcData(); 
	} // 게시글의 전체 갯수가 결정되면 calcData 메소드를 호출하여 계산 실행 

	private void calcData() { 
		endPage = (int) (Math.ceil(criteria.getPage() / (double) displayPageNum) * displayPageNum); 
		startPage = (endPage - displayPageNum) + 1; 
		int tempEndPage = (int) (Math.ceil(totalCount / (double) criteria.getPerPageNum())); 

		if (endPage > tempEndPage) { 
			endPage = tempEndPage; 
		} 

		prev = startPage == 1 ? false : true; 
		next = endPage * criteria.getPerPageNum() >= totalCount ? false : true; 

	} 
	
	public String makeSearch(int page) { 
		UriComponents uriComponents = UriComponentsBuilder.newInstance() 
				.queryParam("page", page) 
				.queryParam("pagePageNum", criteria.getPerPageNum()) 
				.queryParam("searchType", ((SearchCriteria) criteria).getSearchType()) 
				.queryParam("keyword", encoding(((SearchCriteria) criteria).getKeyword())) .build();
		return uriComponents.toUriString(); 
	} 
	
	private String encoding(String keyword) { 
		if (keyword == null || keyword.trim().length() == 0) { 
			return ""; 
		} 		
		try { 
			return URLEncoder.encode(keyword, "UTF-8"); 
		} 
		catch (UnsupportedEncodingException e) { 
			return ""; 
		}
	}
}


