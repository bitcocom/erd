package kr.smhrd.entity;

import lombok.Data;

@Data
public class Member { // User->Member
	private String email;
	private int type;
	private String nickname;
}
