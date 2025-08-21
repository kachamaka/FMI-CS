-- Задачите от упражнение 5 (в къщи)

-- 1.1 Напишете заявка, която извежда средната честота на компютрите

use pc;
select AVG(speed)
from pc;

-- 1.2 Напишете заявка, която извежда средния размер на
-- екраните на лаптопите за всеки производител

use pc;
select maker, AVG(laptop.screen)
from product
join laptop on product.model = laptop.model
group by maker;

-- 1.3 Напишете заявка, която извежда средната честота на лаптопите с цена над 1000

use pc;
select AVG(speed)
from laptop
where price > 1000;

-- 1.4 Напишете заявка, която извежда средната цена на компютрите
-- произведени от производител ‘A’

use pc;
select AVG(price)
from pc
join product on pc.model = product.model
where product.maker = 'A';

--1.5 Напишете заявка, която извежда средната цена на компютрите
-- и лаптопите за производител ‘B’

use pc;
select AVG(price)
from product p
join (select price, model
		from pc
		union all
		select price, model
		from laptop) t on p.model = t.model
where p.maker ='B';

--1.6 Напишете заявка, която извежда средната цена на компютрите
-- според различните им честоти

use pc;
select speed,AVG(price)
from pc
group by speed;

-- 1.7 Напишете заявка, която извежда производителите, които са
-- произвели поне по 3 различни модела компютъра

select maker
from product
where type = 'PC'
group by maker
having count(*) >= 3;


--1.8 Напишете заявка, която извежда производителите на
-- компютрите с най-висока цена

use pc;
select maker
from product
join pc on pc.model = product.model
where price = (select MAX(price) from pc);

-- 1.9 Напишете заявка, която извежда средната цена на
-- компютрите за всяка честота по-голяма от 800

use pc;
select AVG(price)
from pc
group by speed
having speed >800;

-- 1.10 Напишете заявка, която извежда средния размер на диска на тези компютри
-- произведени от производители, които произвеждат и принтери 

use pc;
select product.maker, AVG(hd)
from pc
join product on product.model = pc.model
group by maker
having maker in (select maker
					from product
					where type = 'Printer');

--1.11 Напишете заявка, която за всеки размер на лаптоп намира разликата
-- в цената на най-скъпия и най-евтиния лаптоп със същия размер

use pc;
select screen, MAX(price)-MIN (price)
from laptop
group by screen;

-- 2.1 Напишете заявка, която извежда броя на класовете кораби

use ships;
select COUNT(*)
from CLASSES;

-- 2.2 Напишете заявка, която извежда средния брой на оръжия
-- за всички кораби, пуснати на вода

use ships;
select AVG(numguns)
from CLASSES
join ships on CLASSES.CLASS = ships.CLASS;

-- 2.3 Напишете заявка, която извежда за всеки клас първата и последната година, в
-- която кораб от съответния клас е пуснат на вода

use ships;
select CLASS,min(LAUNCHED)as FirstYear,MAX (LAUNCHED) as LastYear
from ships
group by class;

-- 2.4 Напишете заявка, която извежда броя на корабите потънали в битка според класа

use ships;
select CLASS, COUNT(*)
from ships
join OUTCOMES on NAME = ship
where RESULT = 'sunk'
group by ships.CLASS;

-- 2.5 Напишете заявка, която извежда броя на корабите потънали в битка според
-- класа, за тези класове с повече от 4 пуснати на вода кораба

use ships;
select class, COUNT(*)
from OUTCOMES
join ships on ship = NAME
where RESULT ='sunk'
group by CLASS
having Class in (select CLASS
					from (select CLass,COUNT(*)as p
							from ships
							group by CLASS)t
					where p > 4);

-- 2.6 Напишете заявка, която извежда средното тегло на корабите, за всяка страна.

use ships;
select country, AVG(DISPLACEMENT)
from CLASSES
join ships on CLASSES.CLASS = ships.CLASS
group by country;


