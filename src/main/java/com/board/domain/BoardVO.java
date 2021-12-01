package com.board.domain;

import java.sql.Date;

public class BoardVO {
	
	private int bno;
	private String title;
	private String content;
	private String userId;
	private Date regDate;
	private String gdsImg;
	
	
	
	public String getgdsImg() {
		return gdsImg;
	}
	public void setgdsImg(String gdsImg) {
		this.gdsImg = gdsImg;
	}
	public int getBno() {
		return bno;
	}
	public void setBno(int bno) {
		this.bno = bno;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public Date getRegDate() {
		return regDate;
	}
	public void setRegDate(Date regDate) {
		this.regDate = regDate;
	}
	
	
	
	
}