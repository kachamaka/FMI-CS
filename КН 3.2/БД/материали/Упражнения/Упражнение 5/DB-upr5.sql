
----- Групиране и агрегация  01.04.2011 -----

use movies;
SELECT AVG (netWorth)
FROM MovieExec;

SELECT COUNT(*)
FROM StarsIn;

SELECT COUNT(DISTINCT starName)
FROM StarsIn;

-- пр.: за всяко студио изкарва сумата от дължините на всички филми
SELECT studioName, SUM(length)
FROM Movie
GROUP BY studioName;

-- пр.: да се изведе за всяка година колко филмови звезди са родени:

select year(birthdate), count(*)
from moviestar
group by year(birthdate);

-- пр.: филмите с най-голяма дължина:
-- преди го правехме с ... > all (select lenth ...)

select *
from movie
where length = (select max (length) from movie);

-- синтактична грешка: where lentgth = max( select length ... )

-- задачи 

use pc;
-- 1.1 Напишете заявка, която извежда средната честота на компютрите

select avg(speed)
from pc;

-- 1.2 Напишете заявка, която извежда средния размер на екраните на лаптопите за
-- всеки производител

select maker, avg(screen)
from laptop l
join product p on l.model = p.model
group by maker;

-- 1.3 Напишете заявка, която извежда средната честота на лаптопите с цена над 1000

select avg(speed)
from  laptop
where price > 1000;

-- 1.4 Напишете заявка, която извежда средната цена на компютрите произведени от
--производител ‘A’

-- 1.5 Напишете заявка, която извежда средната цена на компютрите и лаптопите за
--производител ‘B’

select avg(price)
from (select price
	from pc 
	join product p on pc.model = p.model
	where maker = 'B'

	union all

	select price 
	from laptop
	join product p on laptop.model = p.model
	where maker = 'B' ) t;

-- 1.6 Напишете заявка, която извежда средната цена на компютрите според
--различните им честоти

select speed, avg (price)
from pc
group by speed;

-- 1.7 Напишете заявка, която извежда производителите, които са произвели поне по 3
--различни модела компютъра

select maker
from product
where type = 'PC'
group by maker
having count(*) >= 3;

-- 1.8 Напишете заявка, която извежда производителите на компютрите с най-висока
--цена

select distinct maker
from product p
join pc on p.model = pc.model
where price = (select max(price) from pc);

-- 1.9 Напишете заявка, която извежда средната цена на компютрите за всяка честота
--по-голяма от 800

select speed, avg(price)
from pc
where speed >800
group by speed;

-- 1.10 Напишете заявка, която извежда средния размер на диска на тези компютри
--произведени от производители, които произвеждат и принтери

select avg(hd)
from pc
join product p on pc.model = p.model
where maker in (select maker
				from product
				where type = 'Printer');

-- 1.11 Напишете заявка, която за всеки размер на лаптоп намира разликата в цената на
--най-скъпия и най-евтиния лаптоп със същия размер

select screen, max(price) - min (price) 
from laptop
group by screen;


use ships;
-- 2.1 Напишете заявка, която извежда броя на класовете кораби

select count(*)
from classes;

-- 2.2 Напишете заявка, която извежда средния брой на оръжия за всички кораби,
--пуснати на вода

select avg(numguns)
from classes c
join ships s on c.class = s.class;

-- 2.3 Напишете заявка, която извежда за всеки клас първата и последната година, в
--която кораб от съответния клас е пуснат на вода

select class, min (launched) as FirstYear,
	max(launched) as LastYear
from ships
group by class;

-- 2.4 Напишете заявка, която извежда броя на корабите потънали в битка според класа
--( само за класове които имат само 1 потънал кораб)

select class , count (*)
from ships s
join outcomes o on s.name = o.ship
where result = 'sunk'
group by class;


-- 2.5 Напишете заявка, която извежда броя на корабите потънали в битка според
--класа, за тези класове с повече от 4 пуснати на вода кораба

select class , count (*)
from ships s
join outcomes o on s.name = o.ship
where result = 'sunk'
		and class in 
		(select class
		from ships
		group by class
		having count(*) > 4)
group by class;

-- 2.6 Напишете заявка, която извежда средното тегло на корабите, за всяка страна.

select country, avg(displacement)
from classes c
join ships s on c.class = s.class
group by country;


-- задачи 2

use movies;
-- За всеки актьор/актриса изведете броя на различните студиа, 
-- с които са записвали филми.

select starname, count (distinct studioname)
from starsin
join movie on movietitle = title and movieyear = year
group by starname;


-- ако искаме да вкл. и актьорите, които не са играли в нито 1 филм

select starname, count (distinct studioname)
from movie
join starsin on movietitle = title and movieyear = year
right join moviestar on name = starname
group by starname;

-- За всеки актьор/актриса изведете броя на различните студиа,
-- с които са записвали филми, включително и за тези, 
-- за които нямаме информация в какви филми са играли.

-- Изведете имената на актьорите, участвали в поне 3 филма след 1990 г.

select starname
from starsin
where movieyear >1990
group by starname
having count (*) >=3;

use pc;
-- Да се изведат различните модели компютри, подредени 
-- по цена на най-скъпия конкретен компютър от даден модел.

select model
from pc
group by model
order by max(price);

use ships;
-- Изведете броя на потъналите американски кораби за всяка 
-- проведена битка с поне един потънал американски кораб.

select battle, count(*)
from classes c
join ships s on s.class = c.class
join outcomes o on s.name = o.ship
where c.country = 'USA' and result = 'sunk'
group by battle;

-- Битките, в които са участвали поне 3 кораба на една и съща страна.

select distinct o.battle
from classes c
join ships s on s.class = c.class
join outcomes o on s.name = o.ship
group by o.battle, c.country
having count(*)>=3;

-- Имената на класовете, за които няма кораб, 
-- пуснат на вода след 1921 г., но имат пуснат поне един кораб.

select class
from ships
group by class
having max(launched)<=1921;

-- (*) За всеки кораб намерете броя на битките, 
-- в които е бил увреден. Ако корабът не е участвал
-- в битки или пък никога не е бил увреждан, в резултата да се вписва 0.

------1 начин:

select s.name, count(battle)
from ships s
left join outcomes o on s.name = o.ship and result = 'damaged'
group by s.name;

------ 2 начин:(идеята е същата като на 1 начин)

select name, count(battle)
from ships s
left join (select *
		from outcomes
		where result = 'damaged' ) o
	on s.name = o.ship
group by name;

------ 3 начин:

select name, (select count(battle)
	from outcomes o
	where result = 'damaged'
	and s.name = o.ship)
from ships s;

-- (*) Намерете за всеки клас с поне 3 кораба броя 
-- на корабите от този клас, които са победили в битка

select class, count (distinct ship)
from ships 
left outer join outcomes
on name = ship and result = 'ok'
group by class
having count (distinct name) >= 3;