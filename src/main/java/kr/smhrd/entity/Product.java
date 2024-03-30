package kr.smhrd.entity;

import java.util.Date;

import lombok.Data;

@Data
public class Product {
	 private int id;
	 private String  product_name;
	 private int product_price;
	 private int delivery_price;
	 private int add_delivery_price;
	 private String tags;
	 private int outbound_days;
	 private int seller_id;
	 private int category_id;
	 private String active_yn;
	 private Date created_date;
}
