SELECT * FROM TAB;
select * from orders;
DROP TABLE categories;

create table Customers(
customer_id varchar2(15) primary key, 
customers_name varchar2(15) not null,
address varchar2(15) null,
city varchar2(15) null,
postal_code varchar2(15) null
);
create table employees(
employees_id varchar2(15) primary key,
last_name varchar2(15) not null,
first_name varchar2(15) not null,
birth_date varchar2(15) not null,
photo varchar2(15) default '파일명',
notes varchar2(15) default '메모'
);
create table Shippers(
Shipper_ID varchar2(15)  primary key,
Shipper_Name varchar2(15) not null,
phone varchar2(15) not null
);

create sequence order_id
start with 1
increment by 1;

create table orders(
order_id number primary key,
customer_id varchar2(15),
constraint orders_fk_customers foreign key(customer_id)
    references customers(customer_id),
    
employees_id varchar2(15),
constraint orders_fk_employees foreign key(employees_id)
    references employees(employees_id),
    
orderdate date default sysdate,

shipper_id varchar2(15),
constraint orders_fk_shippers foreign key(shipper_id)
    references shippers(shipper_id)
);

create table suppliers(
supplier_id varchar2(15) primary key,
supplier_name varchar2(15) not null,
address varchar2(15) not null,
city varchar2(15) not null,
postalcode varchar2(15) not null,
phone varchar2(15) not null
);

create sequence category_id
start with 1000
increment by 1;

create table categories(
category_id number primary key,
category_name varchar2(15) not null,
description varchar2(15)
);

create sequence products_id
start with 2000
increment by 1;
select * from tab;

create table products(
products_id number primary key,
ptoduct_name varchar2(15) not null,
supplier_id varchar2(15),
constraint products_fk_suppliers foreign key(supplier_id)
    references suppliers(supplier_id),
category_id number,
constraint products_fk_categories foreign key(category_id)
    references categories(category_id),
unit varchar2(15) not null,
price number default 0
);

create sequence orderdetail_id
start with 3000
increment by 1;

create table orderdetails(
orderdetail_id number primary key,
order_id number,
constraint orderdetails_fk_orders foreign key(order_id)
    references orders(order_id),
products_id number,
constraint orderdetails_fk_products foreign key(products_id)
    references products(products_id),
quantity number default 0
);



select * from tab;
