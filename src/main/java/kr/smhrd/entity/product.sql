-- 대분류
create table category1(
   number int(11) unsigned NOT NULL, -- max
   l_class varchar(100) not null
);
insert into category1(number, l_class) value(1,'전자제품');
insert into category1(number, l_class) value(2,'생필품');

create table category2(
   number int(11) unsigned NOT NULL,
   sub_number int(11) unsigned NOT NULL, -- max
   m_class varchar(100) not null
);

insert into category2(number, sub_number, m_class) value(1,1,'컴퓨터');
insert into category2(number, sub_number, m_class) value(1,2,'가전제품');
insert into category2(number, sub_number, m_class) value(2,1,'주방용품');

create table category3(
   number int(11) unsigned NOT NULL,
   sub_number int(11) unsigned NOT NULL,
   ssub_number int(11) unsigned NOT NULL, -- max
   s_class varchar(100) not null
);

insert into category3(number, sub_number, ssub_number, s_class) value(1,1,1,'악세사리');
insert into category3(number, sub_number, ssub_number, s_class) value(1,1,2,'노트북');
insert into category3(number, sub_number, ssub_number, s_class) value(1,1,3,'조립식');

insert into category3(number, sub_number, ssub_number, s_class) value(1,2,1,'텔레비전');
insert into category3(number, sub_number, ssub_number, s_class) value(1,2,2,'냉장고');
insert into category3(number, sub_number, ssub_number, s_class) value(2,1,1,'조리도구');

select * from category3;

drop table t_category;

CREATE TABLE `t_category` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `category1` varchar(100) NOT NULL DEFAULT '',
  `category2` varchar(100) NOT NULL DEFAULT '',
  `category3` varchar(100) DEFAULT '',
  PRIMARY KEY (`id`)
);

INSERT INTO `t_category` (`category1`, `category2`, `category3`)
VALUES
	('전자제품','컴퓨터','악세사리'),
	('전자제품','컴퓨터','노트북'),
	('전자제품','컴퓨터','조립식'),
	('전자제품','가전제품','텔레비전'),
	('전자제품','가전제품','냉장고'),
	('생필품','주방용품','조리도구');

select * from t_category;
delete  from t_category;

drop table t_seller;

CREATE TABLE `t_seller` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL DEFAULT '',
  `email` varchar(100) NOT NULL DEFAULT '',
  `phone` varchar(20) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`)
); 

INSERT INTO `t_seller` (`name`, `email`, `phone`)
VALUES
	('개발자의품격','seungwon.go@gmail.com','010-1111-1111');
	
drop table t_product;

CREATE TABLE `t_product` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `product_name` varchar(200) NOT NULL DEFAULT '',
  `product_price` int(11) NOT NULL DEFAULT 0,
  `delivery_price` int(11) NOT NULL DEFAULT 0,
  `add_delivery_price` int(11) NOT NULL DEFAULT 0,
  `tags` varchar(100) DEFAULT NULL,
  `outbound_days` int(2) NOT NULL DEFAULT 5,
  `seller_id` int(11) unsigned NOT NULL,
  `category_id` int(11) unsigned NOT NULL,
  `active_yn` enum('Y','N') NOT NULL DEFAULT 'Y',
  `created_date` datetime NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `seller_id` (`seller_id`),
  CONSTRAINT `t_product_ibfk_1` FOREIGN KEY (`seller_id`) REFERENCES `t_seller` (`id`)  
);

INSERT INTO `t_product` (`product_name`, `product_price`, `delivery_price`, `add_delivery_price`, `tags`, `outbound_days`, `seller_id`, `category_id`)
VALUES
	-- ('K70 RGB MK.2 BROWN 기계식 게이밍 키보드 갈축',219000,2500,5000,'키보드,기계식,게이밍',5,1,1,'Y') -- ,
	-- ('로지텍 MX VERTICAL 인체공학 무선 마우스',11900,2500,5000,'마우스',5,1,1,'Y') --,
	-- ('테스트 제품 AAA',23000,5000,2500,'테스트,노트북,악세사리',5,1,1) -- N(판매전), Y(판매게시),
	-- ('제품 테스트2',30000,5000,5000,'',5,1,6,'Y');
	('테스트 제품',50000,2500,5000,'기계식,청축',5,1,1);
	
select * from t_product;
delete from t_product;

drop table t_image;

CREATE TABLE `t_image` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `product_id` int(11) unsigned NOT NULL,
  `type` int(1) NOT NULL DEFAULT 1 COMMENT '1-썸네일, 2-제품이미지, 3-제품설명이미지',
  `path` varchar(150) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  KEY `product_id` (`product_id`),
  CONSTRAINT `t_image_ibfk_1` FOREIGN KEY (`product_id`) REFERENCES `t_product` (`id`)
); 

INSERT INTO `t_image` (`product_id`, `type`, `path`)
VALUES
--	(1,1,'keyboard1.jpg') -- ,
--	(1,2,'keyboard1.jpg'),
--	(1,2,'keyboard2.jpg'),
	(1,3,'detail.jpg') -- ,
--	(2,1,'mouse1.jpg') -- ,
--	(16,2,2,'mouse1.jpg'),
--	(17,2,3,'detail.jpg'),
--	(1,2,'keyboard3.jpg') -- ,
--	(20,8,1,'mousepad1.jpg'),
--	(22,8,2,'mousepad1.jpg'),
--	(23,8,2,'mousepad2.jpg'),
--	(24,8,2,'mousepad3.jpg'),
--	(25,8,3,'detail.jpg');

select * from t_image;

delete from t_image;
-- where id=7
	
CREATE TABLE `t_member` (
  `email` varchar(50) NOT NULL DEFAULT '',
  `type` int(1) NOT NULL DEFAULT 1 COMMENT '1-buyer, 2-seller',
  `nickname` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`email`)
);

INSERT INTO `t_member` (`email`, `type`, `nickname`)
VALUES
	('seungwon.go@gmail.com',1,'고승원');
	
-- 리스트 가져오기(type=1 : 쎔네일이미지 1개)	
select t1.*, t2.path, t3.category1,t3.category2,t3.category3 
from t_product t1, t_image t2, t_category t3 
where t1.id=t2.product_id and t2.type=1 and t1.category_id=t3.id  

-- 상세정보 가져오기(type=3, 상세설명이지미)
select t1.*, t2.path, t3.category1,t3.category2,t3.category3 
from t_product t1, t_image t2, t_category t3 
where t1.id=t2.product_id and t2.type=3 and t1.category_id=t3.id and t1.id=1;


-- 상세정보 가져오기(type=2, 대표이지미)
select * from t_image where product_id=1 and type=2;


select t1.*, t2.path, t3.category1,t3.category2,t3.category3 
from t_product t1, t_image t2, t_category t3 
where t1.id=t2.product_id and t2.type=3 and t1.category_id=t3.id and t1.id=2 

-- 새롭게 만든 테이블

drop table category1;
CREATE TABLE category1 (
   number INT(11) UNSIGNED NOT NULL PRIMARY KEY,
   l_class VARCHAR(100) NOT NULL
);

drop table category2;
CREATE TABLE category2 (
   number INT(11) UNSIGNED NOT NULL,
   sub_number INT(11) UNSIGNED NOT NULL,
   m_class VARCHAR(100) NOT NULL,
   PRIMARY KEY (number, sub_number),
   FOREIGN KEY (number) REFERENCES category1 (number)
);

drop table category3;
CREATE TABLE category3 (
   number INT(11) UNSIGNED NOT NULL,
   sub_number INT(11) UNSIGNED NOT NULL,
   ssub_number INT(11) UNSIGNED NOT NULL,
   s_class VARCHAR(100) NOT NULL,
   PRIMARY KEY (number, sub_number, ssub_number),
   FOREIGN KEY (number, sub_number) REFERENCES category2 (number, sub_number)
);

INSERT INTO category1 (number, l_class) VALUES (1, '전자제품');
INSERT INTO category1 (number, l_class) VALUES (2, '생필품');

INSERT INTO category2 (number, sub_number, m_class) VALUES (1, 1, '컴퓨터');
INSERT INTO category2 (number, sub_number, m_class) VALUES (1, 2, '가전제품');
INSERT INTO category2 (number, sub_number, m_class) VALUES (2, 1, '주방용품');

INSERT INTO category3 (number, sub_number, ssub_number, s_class) VALUES (1, 1, 1, '악세사리');
INSERT INTO category3 (number, sub_number, ssub_number, s_class) VALUES (1, 1, 2, '노트북');
INSERT INTO category3 (number, sub_number, ssub_number, s_class) VALUES (1, 1, 3, '조립식');

INSERT INTO category3 (number, sub_number, ssub_number, s_class) VALUES (1, 2, 1, '텔레비전');
INSERT INTO category3 (number, sub_number, ssub_number, s_class) VALUES (1, 2, 2, '냉장고');
INSERT INTO category3 (number, sub_number, ssub_number, s_class) VALUES (2, 1, 1, '조리도구');

drop table t_product;
CREATE TABLE `t_product` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `product_name` varchar(200) NOT NULL DEFAULT '',
  `product_price` int(11) NOT NULL DEFAULT 0,
  `delivery_price` int(11) NOT NULL DEFAULT 0,
  `add_delivery_price` int(11) NOT NULL DEFAULT 0,
  `tags` varchar(100) DEFAULT NULL,
  `outbound_days` int(2) NOT NULL DEFAULT 5,
  `seller_id` int(11) unsigned NOT NULL,
  `major_category_id` int(11) unsigned NOT NULL,
  `middle_category_id` int(11) unsigned NOT NULL,
  `small_category_id` int(11) unsigned NOT NULL,
  `active_yn` enum('Y','N') NOT NULL DEFAULT 'Y',
  `created_date` datetime NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  CONSTRAINT `t_product_ibfk_1` FOREIGN KEY (`seller_id`) REFERENCES `t_seller` (`id`),
  CONSTRAINT `t_product_ibfk_2` FOREIGN KEY (`major_category_id`) REFERENCES `category1` (`number`),
  CONSTRAINT `t_product_ibfk_3` FOREIGN KEY (`major_category_id`, `middle_category_id`) REFERENCES `category2` (`number`, `sub_number`),
  CONSTRAINT `t_product_ibfk_4` FOREIGN KEY (`major_category_id`, `middle_category_id`, `small_category_id`) REFERENCES `category3` (`number`, `sub_number`, `ssub_number`)
);

drop table t_image;
CREATE TABLE `t_image` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `product_id` int(11) unsigned NOT NULL,
  `type` int(1) NOT NULL DEFAULT 1 COMMENT '1-썸네일, 2-제품이미지, 3-제품설명이미지',
  `path` varchar(150) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  CONSTRAINT `t_image_ibfk_1` FOREIGN KEY (`product_id`) REFERENCES `t_product` (`id`)
);

CREATE TABLE `t_seller` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL DEFAULT '',
  `email` varchar(100) NOT NULL DEFAULT '',
  `phone` varchar(20) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`)
); 
INSERT INTO `t_seller` (`name`, `email`, `phone`)
VALUES('개발자의품격','seungwon.go@gmail.com','010-1111-1111');

CREATE TABLE `t_member` (
  `email` varchar(50) NOT NULL DEFAULT '',
  `type` int(1) NOT NULL DEFAULT 1 COMMENT '1-buyer, 2-seller',
  `nickname` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`email`)
);
INSERT INTO `t_member` (`email`, `type`, `nickname`)
VALUES('seungwon.go@gmail.com',1,'고승원');