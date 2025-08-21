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
use anni;

create table test(
id int identity primary key,
name varchar(50)
);

insert into test(name) values('ABC');
insert into test(name) values('ABC');

select * from test;

-- задача 1:
-- Да се направи така, че да не може да има
-- 2 филма на 1 и също студио с еднаква дължина.

create table movie(
title varchar(50),
year datetime,
length char(4),
studioName varchar(50));

select * from movie;

alter table movie add constraint u_sl unique(studioName, length);

insert into movie (title, year, length, studioName)
values ('Aaaa', 2000, -1, 'Disney');
insert into movie (title, year, length, studioName)
values ('Aaaa', 2000, -1, 'Disney');
insert into movie (title, year, length, studioName)
values ('Aaaa', 12000, -1, 'Disney');
insert into movie (title, year, length, studioName)
values ('bbbb', 2000, -10, 'WD');
insert into movie (title, year, length, studioName)
values ('bbbb', 2000, -1, 'anni');
insert into movie (title, year, length, studioName)
values ('bbbb', 2000, -20, 'Disney');
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

create table students(
fn int primary key check(fn >=0 and fn<=99999) not null,
name varchar(100)not null,
egn char(10) unique not null,
email varchar(100) unique not null,
birthdata datetime not null,
data datetime not null,
check (datediff (year, birthdata, data)>17));

drop table students;

insert into students (fn, name, egn, email, birthdata, data)
values(80306, 'Анна Ангелова','9005250478','anki4@abv.bg','1990-05-25', '2008-06-20'); 

select * from students;

-- б) дабавете валидация за e-mail адрес:
-- - да бъде във формат <нещо>@<нещо>.<нещо>;

-- в) създайте таблица за университетските курсове 
-- - уникалевн номер и име;

create table course(
id int identity primary key,
name varchar(50) not null);

-- г) всеки студент може да участва в много курсове
-- и във всеки курс може да има записани много студенти
-- и при изтриване на даден курс автоматично да се
-- отпишат всички студенти от него;

create table StudentsIn(
student_fn int references student(fn),
course_id int references courses(id)
on delete cascade,
primary key (student_fn, course_id));