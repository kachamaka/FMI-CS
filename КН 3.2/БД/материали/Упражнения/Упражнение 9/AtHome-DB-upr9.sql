-- PRIMERY KEY
-- - ���� �� ��� ���� ��� ������ ��������
-- - �� �� �������� ����������
-- - �� �� �������� NULL ���������
-- - � ���� ������� �� ���� �� ��� ������ �� ���� PK

-- UNIQUE
-- - ���� �� ���� ��� ������ ��������
-- - �� �� �������� ����������
-- - �������� �� NULL ���������, �� ������ ��� ���� ��������
-- - � ���� ������� ���� �� ��� ����� UNIQUE �����������

-- FOREIGN KEY
-- - �������� PK � ����� ��� ������ �������
-- - ����� � ����� �� ����������� �� �������� ������ �� ������� � ���� �� PK
-- - �������� �� ����������
-- - �������� �� NULL ���������
-- - � ���� ������� ���� �� ��� ����� PK

-- NOT NULL

use anni

create table test(
id int identity primary key,
name varchar(50));

insert into test (name) values ('anni');
insert into test (name) values ('anni');

select * from test;

-- ������ 1:
-- �� �� ������� ����, �� �� �� ���� �� ���
-- 2 ����� �� 1 � ���� ������ � ������� �������.

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

-- ������� ������ �� ������

-- ������ 2:
-- �������� ������� �����������

alter table movie drop constraint u_sl;

-- ������ 3:

-- �)�� ����� ������� �� ��������� �������� ����������:
-- ���. ����� - �� 0 �� 99999 ������ �� � PK
-- ��� - �� 100 �������
-- ��� - ����� 10 �����, ��������
-- e-mail - �� 100 �������, ��������
-- ���� �� ������� 
-- ���� �� �������� � ������������ - ������ �� ���� ���� 18 ������ ���� ���������� ����
-- ������ �������� �� ����� NOT NULL 

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
values(80306, '���� ��������','9005250478','anki4@abv.bg','1990-05-25', '2008-06-20'); 
insert into student (fn, name, egn, email, birthdate, unDate)
values(80386, '� �','0000000000','anki4@abv.bg','1990-05-25', '2008-06-20'); 

select * from student

-- �) �������� ��������� �� e-mail �����:
-- - �� ���� ��� ������ <����>@<����>.<����>;

alter table student add constraint ck check (email like '%@%.%');

alter table student drop constraint ck

-- �) �������� ������� �� ���������������� ������� 
-- - ��������� ����� � ���;

create table courses(
id int identity,
name varchar(50) not null,
primary key (id));


-- �) ����� ������� ���� �� ������� � ����� �������
-- � ��� ����� ���� ���� �� ��� �������� ����� ��������
-- � ��� ��������� �� ����� ���� ����������� �� ��
-- ������� ������ �������� �� ����;

create table ID(
st_fn int references student(fn),
c_id int references courses(id) on delete cascade,
primary key (st_fn, c_id));
