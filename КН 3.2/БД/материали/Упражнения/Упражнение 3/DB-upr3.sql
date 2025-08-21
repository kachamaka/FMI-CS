--uprajnenie 3 - Podzaqvki
use movies;

--1.1.
--1 reshenie
select name
from MovieStar
where name in (select name
				from MovieExec
				where networth > 10000000)
				and gender = 'F';
--2 reshenie
select ms.name
from MovieStar ms
join MovieExec me on ms.name = me.name
where gender = 'F' and networth > 10000000;

--1.2.
--1 reshenie
select name
from MovieStar
where name not in
	(select name
	from MovieExec);

--2 reshenie
select name
from MovieStar
except
select name
from MovieExec;

--1.3.
select title
from Movie
where length > (select length
			from Movie
			where title = 'Star Wars');

use pc;
--2.1.
select distinct maker
from product
where model in
	(select model
	from pc
	where speed >= 500);

--2.2.
--ot Zadachi-2: Напишете заявка, която извежда принтерите с най-висока цена.

select *
from printer
where price >=all (select price from printer);

--ot Zadachi-2: Напишете заявка, която извежда принтера с най-висока цена.
select top 1 *
from printer
order by price desc;

--2.3.
select *
from laptop
where speed < all
	(select speed
	from pc);

--2.4.
select top 1 model
from (select model, price
	from pc
	union 
	select model, price
	from laptop
	union 
	select model, price
	from printer) AllProducts
order by price desc;

--2.5.
--Напишете заявка, която извежда производителите на цветните принтери с най-ниска цена.
select distinct maker
from product
where model in
	(select model
	from printer
	where color='y'
	and price <= all 
		(select price
		from printer
		where color='y'));

--2.6.
--1 reshenie
select distinct maker 
from product 
where model in
	(select model
	from pc as P
	where ram <= all (select ram from pc)
		and speed >= all
			(select speed 
			from pc
			where ram = P.ram));

--2 reshenie
select distinct maker 
from product 
where model in
	(select model
	from pc
	where ram <= all (select ram from pc)
		and speed >= all
			(select speed 
			from pc
			where ram <= all(select ram from pc)));

--Zadachi-2: 2. (Northwind) Изведете имената на всички продукти, 
--които са по-евтини от най-скъпия продукт, който клиент с име 'Ann Devon' някога си е поръчвал.

use Northwind;
select ProductName
from Products
where UnitPrice < 
	(select top 1 UnitPrice 
	from "Order Details" od
	join Orders o on od.OrderID = o.OrderID
	join Customers  c on c.CustomerID = o.CustomerID
	where ContactName = 'Ann Devon'
	order by UnitPrice desc);

--Zadachi-2: 3. Да се изведат имената на всички актьори, 
--които са играли във филм след навършване на 40-годишна възраст. 
--Решете задачата по два начина - с JOIN и с подзаявка.
--1 reshenie
use movies;
select name from moviestar
where exists
	(select 1
	from starsin
	where movieyear > year(moviestar.birthdate) + 40
	and name = starname);

--2 reshenie
select distinct name
from moviestar
join starsin on name=starname
where movieyear > year(birthdate) +40;

