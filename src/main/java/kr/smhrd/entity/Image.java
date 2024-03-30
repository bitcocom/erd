package kr.smhrd.entity;

import lombok.Data;

@Data
public class Image {
	private int id;
	private int product_id;
	private int type;
	private String path;
}
