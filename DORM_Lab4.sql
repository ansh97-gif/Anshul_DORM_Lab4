


create table sample.supplier(supp_id int not null primary key,supp_name varchar(50) not null,supp_phone varchar(50));
alter table sample.supplier add  supp_city varchar(50);

create table sample.customer(cus_id int not null primary key,cus_name varchar(20) not null,
cus_phone varchar(10) not null,cus_city varchar(30) not null,cus_gender char);

create table sample.category (cat_id int not null primary key,cat_name varchar(20) not null)

-- alter table sample.category add primary key(cat_id)

create table sample.product (pro_id int not null primary key,pro_name varchar(20) not null default "Dummy",pro_desc varchar(60),
catid int,
foreign key(catid) references sample.category(cat_id))

-- alter table sample.product add primary key(pro_id)

create table sample.supplier_pricing (pricing_id int not null primary key
,pro_id int ,
supp_id int,
supp_price int default 0,
foreign key(pro_id) references sample.product(pro_id),
foreign key(supp_id) references sample.supplier(supp_id)
)



create table sample.order (ord_id int not null primary key,
ord_amount int not null,
ord_date date not null,
cus_id int,
pricing_id int,
foreign key(cus_id) references sample.customer(cus_id),
foreign key(pricing_id) references sample.supplier_pricing(pricing_id)
)

create table sample.rating (rat_id int  primary key,
ord_id int not null,
rat_stars int not null,
foreign key(ord_id) references sample.order(ord_id)
)










 insert into sample.supplier values(1,'Rajesh Retails','Delhi','1234567890'),
(2,'Appario Ltd.','Mumbai','2589631470'),
(3,'Knome products','Bangalore','9785463285'),
(4,'Bansal Retails','Kochi','8975463285'),
(5,'Mittal Ltd','Lucknow','7898456532')

insert into sample.customer values(1,'AAKASH','9999999999','DELHI','M'),
(2,'AMAN','9785463215',' NOIDA','M'),
(3,'NEHA','9999999999','MUMBAI ','F'),
(4,'MEGHA','9994562399','KOLKATA','F'),
(5,'PULKIT','7895999999','LUCKNOW','M')

insert into sample.category values(1,'BOOKS'),
(2,'GAMES'),
(3,'GROCERIES'),
(4,'ELECTRONICS'),
(5,'CLOTHES')

insert into sample.product values
(1,'GTA V','Windows 7 and above with i5 processor and 8GB RAM ',2),
(2,'TSHIRT','SIZE-L with Black, Blue and White variations',5),
(3,'ROG LAPTOP','Windows 10 with 15inch screen, i7 processor, 1TB SSD',4),
(4,'OATS','Highly Nutritious from Nestle',3),
(5,'HARRY POTTER','Best Collection of all time by J.K Rowling',1),
(6,'MILK','1L Toned MIlk',3),
(7,'Boat Earphones','1.5Meter long Dolby Atmos ',4),
(8,'Jeans','Stretchable Denim Jeans with various sizes and color',5),
(9,'Project IGI','compatible with windows 7 and above',2),
(10,'Hoodie','Black GUCCI for 13 yrs and above',5),
(11,'Rich Dad Poor Dad','Written by RObert Kiyosaki',1),
(12,'Train Your Brain','By Shireen Stephen',1)

insert into sample.supplier_pricing values
(1,1,2,1500),
(2,3,5,30000),
(3,5,1,3000),
(4,2,3,2500),
(5,4,1,1000),
(6,12,2,780),
(7,12,4,789),
(8,3,1,31000),
(9,1,5,1450),
(10,4,2,999),
(11,7,3,549),
(12,7,4,529),
(13,6,2,105),
(14,6,1,99),
(15,2,5,2999),
(16,5,2,2999)

insert into sample.order values
(101, 1500, '2021-10-06', 2, 1),
(102, 1000, '2021-10-12', 3, 5),
(103, 30000, '2021-09-16', 5, 2),
(104, 1500, '2021-10-05', 1, 1),
(105, 3000, '2021-08-16', 4, 3),
(106, 1450, '2021-08-18', 1, 9),
(107, 789, '2021-09-01', 3, 7),
(108, 780, '2021-09-07', 5, 6),
(109, 3000, '2021-09-10', 5, 3),
(110, 2500, '2021-09-10', 2, 4),
(111, 1000, '2021-09-15', 4, 5),
(112, 789, '2021-09-16', 4, 7),
(113, 31000, '2021-09-16', 1, 8),
(114, 1000, '2021-09-16', 3, 5),
(115, 3000, '2021-09-16', 5, 3),
(116, 99, '2021-09-17', 2, 14)


insert into sample.rating values
(1, 101, 4),
(2, 102, 3),
(3, 103, 1),
(4, 104, 2),
(5, 105, 4),
(6, 106, 3),
(7, 107, 4),
(8, 108, 4),
(9, 109, 3),
(10, 110, 5),
(11, 111, 3),
(12, 112, 4),
(13, 113, 2),
(14, 114, 1),
(15, 115, 1),
(16, 116, 0)

 select c.cus_gender,count(distinct o.cus_id) from sample.customer c inner join sample.order o on c.cus_id=o.cus_id where o.ord_amount>=3000 group by c.cus_gender 






 select o.ord_amount,o.ord_date,p.pro_name from sample.order o inner join 
 sample.supplier_pricing sp on o.pricing_id=sp.pricing_id 
 inner join sample.product p on sp.pro_id=p.pro_id where o.cus_id=2 

 select s.* from sample.supplier s inner join sample.supplier_pricing sp on s.supp_id=sp.supp_id group by sp.supp_id having count(sp.supp_id)>1

 select cat_prices.catid,cat_prices.cat_name,p_price.pro_name as name,cat_prices.min_price from
(select p.catid,c.cat_name,min(sp.supp_price) as min_price 
  from sample.supplier_pricing sp
 inner join sample.product p
 on sp.pro_id=p.pro_id 
 inner join sample.category c on p.catid=c.cat_id
 group by p.catid) as cat_prices inner join
 (select p.pro_name,sp.supp_price from  sample.supplier_pricing sp
 inner join sample.product p on sp.pro_id=p.pro_id) p_price on cat_prices.min_price=p_price.supp_price;

 select p.pro_id,p.pro_name from sample.product p inner join sample.supplier_pricing sp on
 p.pro_id=sp.pro_id inner join sample.order o
 on sp.pricing_id=o.pricing_id where o.ord_date>'2021-10-05'

 select cus_name,cus_gender from sample.customer where cus_name like 'a%' or cus_name like '%a';



DROP PROCEDURE IF EXISTS sample.getrating;

DELIMITER $$
$$
CREATE PROCEDURE sample.getrating()
begin
	select *,
	case 
		when avg_rating =5 then "Excellent"
		when avg_rating >4 then "Good service"
		when avg_rating >2 then "Average"
		else "poor service"
	 end as "service_feedback"
	 from
	 (select t.supp_id,s.supp_name,sum(rat_stars)/count(rat_stars) as avg_rating
	from 
	(select sample.supplier.supp_id,sample.supplier.supp_name,r.rat_stars 
	 	from sample.rating r
	 join sample.order on sample.order.ord_id = r.ord_id
	 join sample.supplier_pricing s_p on s_p.pricing_id=sample.`order`.pricing_id 
	 join sample.supplier on sample.supplier.supp_id =s_p.supp_id
	 group by 
	 	r.rat_id,sample.supplier.supp_id)
	 	as t inner join sample.supplier s on t.supp_id=s.supp_id group by t.supp_id) as supp_rating
END$$
DELIMITER ;

call sample.getrating();

 


 









