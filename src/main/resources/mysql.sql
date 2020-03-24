create schema crm collate utf8;

create table area
(
	id int not null comment 'ID'
		primary key,
	area_name varchar(50) not null comment '栏目名',
	parentid int null comment '父栏目',
	shortname varchar(50) null,
	lng varchar(20) null,
	lat varchar(20) null,
	level int not null comment '1.省 2.市 3.区 4.镇',
	position varchar(255) not null,
	sort int unsigned default 50 null comment '排序'
)
comment '省市区表' charset=utf8;

create table customer
(
	id int auto_increment,
	customer_name varchar(45) charset latin1 not null,
	create_time timestamp default CURRENT_TIMESTAMP not null,
	phone varchar(50) charset latin1 null,
	gender tinyint default 0 not null comment '性别',
	address_id int default 1 null comment '地址',
	address_detail varchar(45) charset latin1 null comment '详细地址',
	position_id int default 0 not null comment '职务',
	level_id int not null comment '评级id',
	customer_id varchar(45) charset latin1 null comment '客户ID',
	company varchar(45) charset latin1 null comment '所属公司',
	user_id int not null,
	note varchar(500) charset latin1 null,
	constraint id_UNIQUE
		unique (id)
)
comment '客户' collate=utf8_bin;

alter table customer
	add primary key (id);

create table customer_level
(
	id int auto_increment
		primary key,
	level_sign varchar(45) not null
)
comment '客户级别' charset=utf8;

create table customer_position
(
	id int auto_increment
		primary key,
	position_name varchar(45) not null,
	sort int not null
)
comment '职务列表' charset=utf8;

create table permission
(
	id int auto_increment
		primary key,
	role_id int null comment '角色ID',
	module_id int null comment '模块ID',
	acl_value varchar(255) null comment '权限值',
	create_date datetime null,
	update_date datetime null
)
charset=utf8;

create table product
(
	id int auto_increment,
	user_id int not null comment '用户id',
	brand varchar(45) not null comment '品牌',
	product_serial varchar(45) null comment '货号',
	product_name varchar(45) not null comment '名称',
	model varchar(45) null comment '型号',
	product_unit varchar(45) not null comment '单位',
	create_date timestamp default CURRENT_TIMESTAMP not null,
	update_date timestamp default CURRENT_TIMESTAMP null,
	category_id int default 0 not null,
	constraint id_UNIQUE
		unique (id)
)
charset=utf8;

alter table product
	add primary key (id);

create table product_category
(
	id int auto_increment,
	category_name varchar(45) not null,
	parent_id int not null,
	level int not null,
	constraint id_UNIQUE
		unique (id)
)
comment '产品类别' charset=utf8;

alter table product_category
	add primary key (id);

create table product_specification
(
	id int auto_increment,
	product_id int not null,
	specification_name varchar(45) not null,
	price int not null,
	amount int default 0 not null,
	constraint id_UNIQUE
		unique (id)
)
charset=utf8;

alter table product_specification
	add primary key (id);

create table role
(
	id int auto_increment
		primary key,
	role_name varchar(255) null,
	role_remark varchar(255) null comment '备注',
	create_date datetime null,
	update_date datetime null,
	is_valid int null
)
charset=utf8;

create table user
(
	id int unsigned zerofill auto_increment,
	uname varchar(45) not null,
	passwd varchar(45) not null,
	salt varchar(45) not null,
	header varchar(45) default 'header/default.jpg' not null,
	preferColor varchar(45) default 'primary' not null,
	constraint id_UNIQUE
		unique (id),
	constraint uname_UNIQUE
		unique (uname)
)
charset=utf8;

alter table user
	add primary key (id);

