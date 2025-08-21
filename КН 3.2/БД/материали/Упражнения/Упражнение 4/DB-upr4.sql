-- капани на NATURAL JOIN
-- нека имаме тези 2 таблици:
-- Movies(ModieID, Name, StudioID)
-- Studios(StudioID, Name, Address)

-- select *
-- from Movies
-- nalural join Studios;

-- <=> 

--select MoviesID, Movies.Name, Movies.StudioID, Address
-- from Movies
-- join Studios on Movies.StudioID = Studios.StudiosID
-- and Movies.Name = Studios.Name <---- проблем

-- Задача 1: Всички актьори, които не са във филми
-- (т.е. нямаме инфо в кои филми са играли)
use movies;
select *
from moviestar
left join starsin on name = starname
where starname is null;

select * from moviestar
where name not in (select starname from starsin);

-- задача 2: Производител, модел и тип на продукт за всички
-- продукти, които не се продават, т.е. има кортеж в 
-- релацията Product но няма кортеж в съответната 
-- релацияPC/Laptop/Printer

--вариант 1
use pc;
select maker, p.model, type
from product p
left join(select model from pc
		union
		select model from laptop
		union 
		select model from printer) t
	on p.model = t.model
where t.model is null;

--трябва да внимаваме кой модел искаме, т.е. от коя от двете релации

--вариант 2 заявка

select maker, p.model, p.type
from product p
left join pc on pc.model = p.model
left join laptop on laptop.model = p.model
left join printer on printer.model = p.model
where pc.model is null and laptop.model is null 
		and printer.model is null;

--задача 3: За всяка държава да се извежда имената на 
-- корабите, които никога не са участвали в битка

use ships;
select country, name
from classes c
join ships s on c.class = s.class
left join outcomes o on s.name = o.ship
where o.ship is null;

-- получава се нещо такова
--    c    s    o
-- +--------------+
-- |              |
-- |              |
-- |              |
-- |         +----+
-- |         |
-- |         | NULL
-- |         |
-- +---------+

-- задача 4: (модификация на предната задача)
-- За всеки служител да се изкарат името му и името 
-- на прекия му началник. Новото е: да се изкарат и 
-- тези служители, които нямат началник
use northwind;
-- в предишното решение добавяме "left" пред "join"

------------------------------------------------------------
------------------------------------------------------------

--задачи по близки за контролното:

-- задача 1: Имената и годините на поскане на вода на всички
-- кораби, чието име съвпада с името на класа им.

use ships;
select name, launched
from ships
where name = class;

-- задача 2: (Northwind) Всички служители чийто адрес съдържа
-- едновременно като подниз "Ave" и "th" (не непременно в този ред).
-- Резултата да бъде сортиран по дата на назначаване
-- (първо най-новите) , а служителите от една дата да
-- бъдат сортирани по азбучен ред.

use northwind;
select *
from employees
where address like '%Ave%' and address like '%th%'
order by hiredate desc, firstname asc, lastname asc; 

-- задача 3: Градовете, за които има поръчки, обслужени от 
-- работници, родени м/у 1.1.1970 и 1.1.1980.

select distinct ShipCity
from Employees e
join Orders o on e.EmployeeID = o.EmployeeID
where birthDate between '1970-01-01' and '1980-01-01'

-- задача 4: Всички държави, които имат потънали в битка кораби

use ships;
select distinct country
from classes c
join ships s on c.class = s.class
join outcomes o on s.name = o.ship
where o.result = 'sunk';

--задача 5: Всички държави, които нямат нито един потънал кораб
-- (това вкчва държави с кораби, които не са участвали в битки и т.н.)

select distinct country
from classes
where country not in
	( select distinct country
	from classes c
	join ships s on c.class = s.class
	join outcomes o on s.name = o.ship
	where o.result = 'sunk');

-- грешно решение: решението на 4-а с o.result != 'sunk'

--задача 6: Именаста ан всички служители, които не са 
--обслужили нито една поръчка след 1.5.1998 . Ако някой
--служител не е обслужил нито една поръчка изобщо,
-- също да бъде изведен

use northwind;
select FirstName, LastName
from Employees
where EmployeeID not in
	(select EmployeeID 
		from Orders
		where OrderDate > '1998-05-01'); 

--2ри начин
select FirstName, LastName
from Employees e
where not exists
	(select *
	from Orders
	where OrderDate > '1998-05-01'
		and Orders.EmployeeID = e.EmployeeID);

-- 3ти начин
select FirstName, LastName, OrderID, OrderDate
from Employees e
left join Orders o
	on o.EmployeeID = e.EmployeeID
		and OrderDate > '1998-05-01' -- задължително в on клаузата!
where OrderId is null;
	
--задача 7: Държавите, които имат класове с различен калибър
--(напр. САЩ имат с 14 калибър класове с 16
-- калибър, докато Великобритания има само класове с 15)

use ships;
select distinct c1.country
from classes c1
join classes c2 on c1.country = c2.country
where c1.bore<>c2.bore;

-- задача 8: Комп-те, които са по-евтини от всеки лаптоп 
-- и принте на същия производител

use pc;
select pc.*
from pc 
join product p on pc.model = p.model
where price < all (select price
				from laptop
				join product p1 on laptop.model = p1.model
				where p.maker = p1.maker)
	and price < all (select price
					from printer
					join product p1 on printer.model = p1.model
					where p.maker = p1.maker); 

-- задача 9: За всяки кортеж в Order Детаилс ( в Northwind)
-- да се изведе сумарната печалба - единична цена +
--количество, изваждайки остатъка

use northwind;
select OrderID, ProductId,
		UnitPrice * Quantity * (1 - Discount)
from "Order Details";

-- задача 10: Страните, които произвеждат кораби с най-голям брой оръдия
--(numguns)

use ships;
select distinct country
from classes
where numguns >= all (select numguns from classes);

-- оператор CASE

use movies;
select Name, case Gender
			when 'M' then 'Male'
			when 'F' then 'Female'
		end as Gender
from moviestar;

-- Някои хора за продуценти, други са актьори, трети са и двете. 
-- За всеки човек да се изведе рожденна дата и networth (ако има)

select me.name, ms.birthdate, me.networth
from Movieexec me
full join  Moviestar ms on me.name = ms.name;

--2ри начин

select case
		when me.name is null then ms.name
		else me.name
	end as Name,
	ms.birthdate, me.networth
	from Movieexec me
full join MovieStar ms on me.name = ms.name;