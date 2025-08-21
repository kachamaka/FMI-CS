-- създаваме си таблицата коята ще ползваме:

create database anni
go
use anni
go

-- 1. Дефинирайте следните релации:

-- а) Product(maker, model, type), където моделът е низ от
-- точно 4 символа, maker - един символ,
-- а type - низ до 7 символа;

create table product(
	maker char(1),
	model char(4),
	type varchar(7));

-- б) Printer(code, model, color, price),
-- където code е цяло число, color е 'y' или 'n'
-- и по подразбиране е 'n', price - цена с точност
-- до два знака след десетичната запетая;

create table printer(
	code int,
	model char(4),
	color char(1) default 'n',
	price decimal(10,2));

-- в) Classes(class, type), където class е до
-- 50 символа, а type може да бъде 'bb' или 'bc'.

create table classes(
	class varchar(50),
	type char(2));

-- 2. Добавете кортежи с примерни данни към
-- новосъздадените релации. Добавете информация за принтер,
-- за когото знаем само кода и модела.

-- Добавете кортежи с примерни данни към
-- новосъздадените релации:

-- за product:
insert into product (maker, model, type) values ('A', '1111', 'PC')
insert into product (maker, model, type) values ('B', '2121', 'Printer')
insert into product (maker, model, type) values ('C', '3432', 'PC')
insert into product (maker, model, type) values ('A', '1234', 'Laptop')
insert into product (maker, model, type) values ('C', '2121', 'Printer')

select * from product

-- за printer:
insert into printer(code,color,model,price) values ('1', 'y', '1234', '200')
insert into printer(code,model) values ('2', '1111')
insert into printer(code,color,model,price) values ('3', 'n', '8990', '600.9')
insert into printer(code,color,model,price) values ('4', 'y', '1234', '999.99')
insert into printer(code,model,price) values ('5', '1234', '100.50')

select * from printer

--за classes:
insert into classes(class, type) values ('Anni', 'bb')
insert into classes(class, type) values ('Hrisi', 'bc')
insert into classes(class, type) values ('Ivo', 'bc')
insert into classes(class, type) values ('Presko', 'bb')

select * from classes

-- Добавете информация за принтер,
-- за когото знаем само кода и модела:

update printer set color = 'y', price = '56'
where color = 'n' and price is null

select * from printer

-- 3. Добавете към Classes атрибут bore - число с плаваща запетая.

alter table classes add bore decimal(10,2)

select * from classes

-- 4. Напишете заявка, която премахва атрибута price от Printer.

alter table printer drop column price

select * from printer

-- 5. Изтрийте всички таблици, които сте създали в това упражнение.

drop table printer
drop table classes
drop table product

