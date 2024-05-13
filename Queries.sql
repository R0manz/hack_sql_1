create table countries(
  id_country serial primary key,
  name varchar(50) not null  
);


insert into countries (name) values ('argentina'),('colombia'),('chile');
select * from countries;

create table users(
 id_users serial primary key,
 id_country integer not null,
 email varchar(100) not null,
 name varchar (50) not null,
 foreign key (id_country) references countries (id_country)   
);
insert into users (id_country, email, name) 
  values (2, 'foo@foo.com', 'fooziman'), (3, 'bar@bar.com', 'barziman'); 
select * from users;


delete from users where email = 'bar@bar.com';


update users set email = 'foo@foo.foo', name = 'fooz' where id_users = 1;
select * from users;


select * from users inner join  countries on users.id_country = countries.id_country;

select u.id_users as id, u.email, u.name as fullname, c.name 
from users u inner join  countries c on u.id_country = c.id_country;



create table priorities(
	id_priority serial primary key,
	type_name varchar(50)
);

create table contact_request(
	id_email serial primary	key,
	id_country integer not null,
	id_priority integer not null,
	name varchar(50) not null,
	detail varchar(50),
	physical_address varchar(50),
	foreign key (id_country) references countries(id_country),
	foreign key (id_priority) references priorities(id_priority)
);


insert into countries (name) values ('brasil'),('venezuela');
insert into priorities (type_name) values ('low'),('medium'),('high');
insert into contact_request(id_country,id_priority,name, detail,physical_address) values (1,1,'chief', 'Contact_chief','ccs');




create table roles(
	id_role serial primary key,
	name varchar(100)
);
insert into roles (name) values ('outsourcing'),('regular_client'), ('VIP');


create table taxes(
	id_tax serial primary key,
	percentage int
);
insert into taxes (percentage) values (10), (15), (11);
update taxes set percentage = 5 where id_tax = 1;
update taxes set percentage = 10 where id_tax = 2;
update taxes set percentage = 8 where id_tax = 3;


create table offers(
	id_offer serial primary key,
	status varchar(50)
);
insert into offers (status) values ('AVAILABLE'), ('COMING SOON'), ('AVAILABLE');

create table discounts(
	id_discount serial primary key,
	status varchar(50),
	percentage int
);
insert into discounts (status, percentage) VALUES ('AVAILABLE', 20), ('NOT AVAILABLE', 0), ('AVAILABLE', 50);


create table payments(
	id_payment serial primary key,
	type varchar(50)
);
insert into payments (type) values ('Cash'), ('Bank Transfers'), ('Pago movilxd');


create table customers(
	id_customer serial primary key,
	email varchar(100),
	id_country int,
	id_role int,
	name varchar(50) not null,
	age int,
	password varchar(50) not null,
	physical_address varchar(50),
	foreign key (id_country) references countries (id_country),
	foreign key (id_role) references roles (id_role)
);
insert into customers (email, id_country, id_role, name, age, password, physical_address) 
values ('foo@foo.com', 1, 2, 'foo', 20,'pass1234', 'buenos aires'),
('bar.bar.com',2, 3, 'bar',24,'pass321', 'medellin'),
('qox.qox.com', 3,1,'OSG',30,'pass543','rio de janeiro');


create table invoice_status(
	id_invoice_status serial primary key,
	status varchar(50)
);
insert into invoice_status (status) values ('APPROVED'),('PENDING'),('REJECTED');


create table products(
	id_product serial primary key,
	id_discount int,
	id_offer int,
	id_tax int,
	name varchar(50) not null,
	details varchar(50),
	minimum_stock int not null,
	maximun_stock int not null,
	current_stock int not null,
	price float,
	price_with_tax float not null,
	foreign key (id_discount) references discounts (id_discount),
	foreign key (id_offer) references offers (id_offer),
	foreign key (id_tax) references taxes (id_tax)
);
insert into products (id_discount, id_offer, id_tax, name, details, minimum_stock, maximun_stock,current_stock, price, price_with_tax) values (1,1,1, 'LAPTOP', 'NEW', 1,10,5,300,320), (2,2,2,'DESKTOP','REFURBISHED',1,20,12,250,280), (3,3,3,'ROUTER','NEW',1,10,3,150,170);
update products set price = 400 where id_product = 1;
update products set price = 800 where id_product = 2;
update products set price = 500 where id_product = 3;
update products set price_with_tax = 430 where id_product = 1;
update products set price_with_tax = 850 where id_product = 2;
update products set price_with_tax = 510 where id_product = 3;

create table product_customers(
	id_product int,
	id_customer int,
	foreign key (id_product) references products (id_product),
	foreign key (id_customer) references customers (id_customer),
	primary key (id_customer, id_product)
);
insert into product_customers (id_product, id_customer) values (1,1), (2,2), (3,3);


create table invoices(
	id_invoice serial primary key,
	id_customer int,
	id_payment int,
	id_invoice_status int,
	date timestamp,
	total_to_pay float not null
);
insert into invoices (id_customer, id_payment, id_invoice_status, total_to_pay) values (1,1,1,300);

create table orders(
	id_order serial primary key,
	id_invoice int,
	id_product int,
	detail varchar(50),
	amount float not null,
	price float not null
);
insert into orders (id_invoice,id_product,detail,amount,price) values (1,1,'DELIVERED',5,1000),(2,2,'PROCESSING',2,600),(3,3,'CANCELLED',2,0);
