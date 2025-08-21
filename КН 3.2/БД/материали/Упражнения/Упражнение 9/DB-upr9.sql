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
use anni;

create table test(
id int identity primary key,
name varchar(50)
);

insert into test(name) values('ABC');
insert into test(name) values('ABC');

select * from test;

-- ������ 1:
-- �� �� ������� ����, �� �� �� ���� �� ���
-- 2 ����� �� 1 � ���� ������ � ������� �������.

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
values(80306, '���� ��������','9005250478','anki4@abv.bg','1990-05-25', '2008-06-20'); 

select * from students;

-- �) �������� ��������� �� e-mail �����:
-- - �� ���� ��� ������ <����>@<����>.<����>;

-- �) �������� ������� �� ���������������� ������� 
-- - ��������� ����� � ���;

create table course(
id int identity primary key,
name varchar(50) not null);

-- �) ����� ������� ���� �� ������� � ����� �������
-- � ��� ����� ���� ���� �� ��� �������� ����� ��������
-- � ��� ��������� �� ����� ���� ����������� �� ��
-- ������� ������ �������� �� ����;

create table StudentsIn(
student_fn int references student(fn),
course_id int references courses(id)
on delete cascade,
primary key (student_fn, course_id));