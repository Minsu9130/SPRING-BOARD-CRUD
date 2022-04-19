package net.developia.spring03.dto;

import java.io.Serializable;
import java.util.List;

import lombok.Data;

@Data
public class BoardDTO implements Serializable {
	private long no;
	private String title;
	private String name;
	private String content;
	private String regdate;
	private int readcount;
	private String password;
	
	private List<AttachFileDTO> attachList;
}
