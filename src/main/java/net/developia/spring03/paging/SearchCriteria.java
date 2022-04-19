package net.developia.spring03.paging;

import lombok.Data;

@Data
public class SearchCriteria extends Criteria{
	
	private String searchType; 
	private String keyword;

}
