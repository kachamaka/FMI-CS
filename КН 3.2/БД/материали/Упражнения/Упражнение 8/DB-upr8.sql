-- създаваме си таблицата коята ще ползваме:
create database percomp
go
use percomp
go

-- 1. Дефинирайте следните релации:

-- а) Product(maker, model, type), където моделът е низ от
-- точно 4 символа, maker - един символ,
-- а type - низ до 7 символа;

create table product(
	maker char(1),
	model char(4),
	type varchar(7)
);

-- б) Printer(code, model, color, price),
-- където code е цяло число, color е 'y' или 'n'
-- и по подразбиране е 'n', price - цена с точност
-- до два знака след десетичната запетая;

create table printer(
	code int,
	color char(1) default 'n',
	model char (4),
	price decimal(10, 2)
);

-- в) Classes(class, type), където class е до
-- 50 символа, а type може да бъде 'bb' или 'bc'.

create table classes(
	class varchar(50),
	type char(2)
);

-- 2. Добавете кортежи с примерни данни към
-- новосъздадените релации. Добавете информация за принтер,
-- за когото знаем само кода и модела.

-- Добавете кортежи с примерни данни към
-- новосъздадените релации:

-- за product
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

-- за printer
insert into  printer(code, model, color, price)
values( '1', '1111', 'y', '19.19');
insert into  printer(code, model, color, price)
values( '12', '2345', null,'222');
insert into  printer(code, model, color, price)
values( '23', '2323', null, null);

select *
from printer;

-- за classes
insert into classes(class, type)
values('1111','bb');
insert into classes(class, type)
values('2222','bc');
insert into classes(class, type)
values('36ty','bb');

select *
from classes;

-- Добавете информация за принтер,
-- за когото знаем само кода и модела:

update printer set color = 'y'
where color is null and price is null;

-- 3. Добавете към Classes атрибут bore - число с плаваща запетая.

ALTER TABLE classes ADD bore decimal(10,5);

-- 4. Напишете заявка, която премахва атрибута price от Printer.

Alter table printer drop column price;

-- 5. Изтрийте всички таблици, които сте създали в това упражнение.

drop table printer;