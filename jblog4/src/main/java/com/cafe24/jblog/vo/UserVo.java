package com.cafe24.jblog.vo;

import org.hibernate.validator.constraints.NotEmpty;

public class UserVo {
	@NotEmpty
	private String id;
	@NotEmpty
	private String name;
	@NotEmpty
	private String password;
	private String regDate;
	private String agreeProv = "n";
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getRegDate() {
		return regDate;
	}
	public void setRegDate(String regDate) {
		this.regDate = regDate;
	}
	public String getAgreeProv() {
		return agreeProv;
	}
	public void setAgreeProv(String agreeProv) {
		this.agreeProv = agreeProv;
	}

	
}
