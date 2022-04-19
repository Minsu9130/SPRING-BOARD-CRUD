package net.developia.spring03.dto;

import java.io.Serializable;
import java.util.Date;

import lombok.Data;

@Data
public class ReplyDTO implements Serializable{
	
	private int bno;
	private int rno;
	private String content;
	private String writer;
	private Date regdate;

}
