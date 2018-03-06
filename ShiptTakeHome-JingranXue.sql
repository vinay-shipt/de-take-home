# Shipt Data Engineer Take-Home Challenge
# Jingran Xue
# rannie.xue@gmail.com
# 650-450-3479

#Schema
create table conn (row int, person1 varchar(30), person2 varchar(30));

insert into conn (row, person1, person2) values (1, 'Barack Obama','Michelle Obama');
insert into conn (row, person1, person2) values (2, 'Barack Obama','George Bush');
insert into conn (row, person1, person2) values (3, 'Barack Obama','Laura Bush');
insert into conn (row, person1, person2) values (4, 'Michelle Obama','George Bush');
insert into conn (row, person1, person2) values (5, 'Michelle Obama','Laura Bush');
insert into conn (row, person1, person2) values (6, 'George Bush','Laura Bush');
insert into conn (row, person1, person2) values (7, 'Barack Obama','Malia Obama');
insert into conn (row, person1, person2) values (8, 'Barack Obama','Sasha Obama');
insert into conn (row, person1, person2) values (9, 'Michelle Obama','Malia Obama');
insert into conn (row, person1, person2) values (10, 'Michelle Obama','Sasha Obama');
insert into conn (row, person1, person2) values (11, 'George Bush','Jenna Bush');
insert into conn (row, person1, person2) values (12, 'George Bush','Barbara Bush');
insert into conn (row, person1, person2) values (13, 'Laura Bush','Jenna Bush');
insert into conn (row, person1, person2) values (14, 'Laura Bush','Barbara Bush');
insert into conn (row, person1, person2) values (15, 'Malia Obama','Jenna Bush');
insert into conn (row, person1, person2) values (16, 'Sasha Obama','Jenna Bush');
insert into conn (row, person1, person2) values (17, 'Malia Obama','Barbara Bush');
insert into conn (row, person1, person2) values (18, 'Sasha Obama','Barbara Bush');
#insert into conn (row, person1, person2) values (19, 'Malia Obama','Sasha Obama');
#insert into conn (row, person1, person2) values (20, 'Jenna Bush','Barbara Bush');


#Q1
select newtb.person, count(*) num
from (
select person1 person
from conn
union all
select person2 person
from conn
) as newtb
group by newtb.person
order by num desc;


#Q2
select all_conn.person, count(*) num_connection, group_concat(person2) as connections
from (
select person1 person, person2 
from conn
union all
select person2 person, person1 person2
from conn
) as all_conn
group by all_conn.person
order by num_connection desc;



#Q3
select all_conn1.person1, all_conn2.person1 p1, count(*), group_concat(all_conn1.person2)  
from
	(select person1, person2
	from conn
	union
	select person2 person1, person1 person2
	from conn
	order by person1) as all_conn1,
    (select person1, person2
	from conn
	union
	select person2 person1, person1 person2
	from conn
	order by person1) as all_conn2
where all_conn1.person1 > all_conn2.person1 
	and all_conn1.person2 = all_conn2.person2
group by all_conn1.person1, all_conn2.person1
order by count(*) desc, all_conn1.person1, all_conn2.person1

