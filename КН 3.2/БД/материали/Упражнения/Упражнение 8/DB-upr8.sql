-- ��������� �� ��������� ����� �� ��������:
create database percomp
go
use percomp
go

-- 1. ����������� �������� �������:

-- �) Product(maker, model, type), ������ ������� � ��� ��
-- ����� 4 �������, maker - ���� ������,
-- � type - ��� �� 7 �������;

create table product(
	maker char(1),
	model char(4),
	type varchar(7)
);

-- �) Printer(code, model, color, price),
-- ������ code � ���� �����, color � 'y' ��� 'n'
-- � �� ������������ � 'n', price - ���� � �������
-- �� ��� ����� ���� ����������� �������;

create table printer(
	code int,
	color char(1) default 'n',
	model char (4),
	price decimal(10, 2)
);

-- �) Classes(class, type), ������ class � ��
-- 50 �������, � type ���� �� ���� 'bb' ��� 'bc'.

create table classes(
	class varchar(50),
	type char(2)
);

-- 2. �������� ������� � �������� ����� ���
-- ��������������� �������. �������� ���������� �� �������,
-- �� ������ ����� ���� ���� � ������.

-- �������� ������� � �������� ����� ���
-- ��������������� �������:

-- �� product
insert into product (maker, model, type)
values('A','1111','comp');
insert into product (maker, model, type)
values('B','2222','pc');
insert into product (maker, model, type)
values('A','1111','printer');
insert into product (maker, model, type)
values('c','3333','laptop');

select *
from product;

-- �� printer
insert into  printer(code, model, color, price)
values( '1', '1111', 'y', '19.19');
insert into  printer(code, model, color, price)
values( '12', '2345', null,'222');
insert into  printer(code, model, color, price)
values( '23', '2323', null, null);

select *
from printer;

-- �� classes
insert into classes(class, type)
values('1111','bb');
insert into classes(class, type)
values('2222','bc');
insert into classes(class, type)
values('36ty','bb');

select *
from classes;

-- �������� ���������� �� �������,
-- �� ������ ����� ���� ���� � ������:

update printer set color = 'y'
where color is null and price is null;

-- 3. �������� ��� Classes ������� bore - ����� � ������� �������.

ALTER TABLE classes ADD bore decimal(10,5);

-- 4. �������� ������, ����� �������� �������� price �� Printer.

Alter table printer drop column price;

-- 5. �������� ������ �������, ����� ��� ������� � ���� ����������.

drop table printer;