-- ��������� �� ��������� ����� �� ��������:

create database anni
go
use anni
go

-- 1. ����������� �������� �������:

-- �) Product(maker, model, type), ������ ������� � ��� ��
-- ����� 4 �������, maker - ���� ������,
-- � type - ��� �� 7 �������;

create table product(
	maker char(1),
	model char(4),
	type varchar(7));

-- �) Printer(code, model, color, price),
-- ������ code � ���� �����, color � 'y' ��� 'n'
-- � �� ������������ � 'n', price - ���� � �������
-- �� ��� ����� ���� ����������� �������;

create table printer(
	code int,
	model char(4),
	color char(1) default 'n',
	price decimal(10,2));

-- �) Classes(class, type), ������ class � ��
-- 50 �������, � type ���� �� ���� 'bb' ��� 'bc'.

create table classes(
	class varchar(50),
	type char(2));

-- 2. �������� ������� � �������� ����� ���
-- ��������������� �������. �������� ���������� �� �������,
-- �� ������ ����� ���� ���� � ������.

-- �������� ������� � �������� ����� ���
-- ��������������� �������:

-- �� product:
insert into product (maker, model, type) values ('A', '1111', 'PC')
insert into product (maker, model, type) values ('B', '2121', 'Printer')
insert into product (maker, model, type) values ('C', '3432', 'PC')
insert into product (maker, model, type) values ('A', '1234', 'Laptop')
insert into product (maker, model, type) values ('C', '2121', 'Printer')

select * from product

-- �� printer:
insert into printer(code,color,model,price) values ('1', 'y', '1234', '200')
insert into printer(code,model) values ('2', '1111')
insert into printer(code,color,model,price) values ('3', 'n', '8990', '600.9')
insert into printer(code,color,model,price) values ('4', 'y', '1234', '999.99')
insert into printer(code,model,price) values ('5', '1234', '100.50')

select * from printer

--�� classes:
insert into classes(class, type) values ('Anni', 'bb')
insert into classes(class, type) values ('Hrisi', 'bc')
insert into classes(class, type) values ('Ivo', 'bc')
insert into classes(class, type) values ('Presko', 'bb')

select * from classes

-- �������� ���������� �� �������,
-- �� ������ ����� ���� ���� � ������:

update printer set color = 'y', price = '56'
where color = 'n' and price is null

select * from printer

-- 3. �������� ��� Classes ������� bore - ����� � ������� �������.

alter table classes add bore decimal(10,2)

select * from classes

-- 4. �������� ������, ����� �������� �������� price �� Printer.

alter table printer drop column price

select * from printer

-- 5. �������� ������ �������, ����� ��� ������� � ���� ����������.

drop table printer
drop table classes
drop table product

