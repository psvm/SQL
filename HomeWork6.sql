create database if not exists numb;
use numb;
drop table if exists numbers;
drop table if exists table1;
drop table if exists table2;
create table if not exists numbers(num int);
create table if not exists table1(t1_id int not null auto_increment primary key, t1 int);
create table if not exists table2(t2_id int not null auto_increment primary key, t2 int);

insert into numbers(num)
values
(2),(4),(5),(10),(15),(1000);

insert into table1(t1)
values (0);
insert into table1(t1)
select num
from numbers
where num < (select max(num) from numbers);

insert into table2(t2)
select num
from numbers;

select t1.t1+1 as start, t2.t2-1 as end, t2.t2-t1.t1-1 as count
from table1 t1
inner join
table2 t2
on t1.t1_id = t2.t2_id
where t2 > (t1 + 1)



