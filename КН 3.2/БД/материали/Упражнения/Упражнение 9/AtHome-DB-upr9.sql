-- PRIMERY KEY
-- - може да има един или повече атрибути
-- - не се допускат повторения
-- - не се допускат NULL стойности
-- - в една релация не може да има повече от един PK

-- UNIQUE
-- - може от един или повече атрибути
-- - не се допускат повторения
-- - допускат се NULL стойности, но зависи кое СУБД ползваме
-- - в една релация може да има много UNIQUE ограничения

-- FOREIGN KEY
-- - реферира PK в друга или същата таблица
-- - броят и типът на съставящите го атрибути трябва да съвпада с тези на PK
-- - допускат се повторения
-- - допускат се NULL стойности
-- - в една релация може да има много PK

-- NOT NULL

use anni

create table test(
id int identity primary key,
name varchar(50));

insert into test (name) values ('anni');
insert into test (name) values ('anni');

select * from test;

-- задача 1:
-- Да се направи така, че да не може да има
-- 2 филма на 1 и също студио с еднаква дължина.

create table movie(
title varchar(50),
year datetime,
length int,
studioName varchar(50));

alter table movie add constraint u_sl unique (studioName, length);

insert into movie (title, year, length, studioName) values ('A', 1982, 12, 'B');
insert into movie (title, year, length, studioName) values ('Aa', 1882, 4, 'B');
insert into movie (title, year, length, studioName) values ('Aaaa', 1992, 11, 'B');
insert into movie (title, year, length, studioName) values ('Aaaa', 1982, 12, 'B');

-- горното трябва да гръмне

-- задача 2:
-- Изтрийте горното ограничение

alter table movie drop constraint u_sl;

-- задача 3:

-- а)За всеки студент се съхранява следната информация:
-- фак. номер - от 0 до 99999 трябва да е PK
-- име - до 100 символа
-- ЕГН - точно 10 знака, уникално
-- e-mail - до 100 символа, уникално
-- дата на даждане 
-- дата на приемане в университета - трябва да бъде поне 18 години след рпжденната дата
-- Всички атрибути да бъдат NOT NULL 

create table student(
fn int not null,
name varchar(100) not null,
egn char(10) not null,
email varchar(100) not null,
birthdate datetime not null,
unDate datetime not null,
check( 0< fn and fn < 99999 and (datediff (year, birthdate,unDate)> 17)),
primary key (fn));

insert into student (fn, name, egn, email, birthdate, unDate)
values(80306, 'Анна Ангелова','9005250478','anki4@abv.bg','1990-05-25', '2008-06-20'); 
insert into student (fn, name, egn, email, birthdate, unDate)
values(80386, 'А А','0000000000','anki4@abv.bg','1990-05-25', '2008-06-20'); 

select * from student

-- б) дабавете валидация за e-mail адрес:
-- - да бъде във формат <нещо>@<нещо>.<нещо>;

alter table student add constraint ck check (email like '%@%.%');

alter table student drop constraint ck

-- в) създайте таблица за университетските курсове 
-- - уникалевн номер и име;

create table courses(
id int identity,
name varchar(50) not null,
primary key (id));


-- г) всеки студент може да участва в много курсове
-- и във всеки курс може да има записани много студенти
-- и при изтриване на даден курс автоматично да се
-- отпишат всички студенти от него;

create table ID(
st_fn int references student(fn),
c_id int references courses(id) on delete cascade,
primary key (st_fn, c_id));
