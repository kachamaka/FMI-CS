-- Задачите от упражнение 3 (в къщи)

-- 1.1 Напишете заявка, която извежда имената на актрисите,
-- които са също и продуценти с нетна стойност по-голяма от 10 милиона.

use movies;
select m.NAME
from MOVIESTAR m, (select name
				from MOVIEEXEC
				where NETWORTH > 10000000)t
where m.GENDER = 'F' and m.NAME = t.NAME;

-- 1.2 Напишете заявка, която извежда имената на тези
-- актьори (мъже и жени), които не са продуценти.

use movies;
select name
from MOVIESTAR 
where NAME not in (select name
					from MOVIEEXEC);

-- От Упражнение 2, да се решат с подзаявки

-- 1.3 Напишете заявка, която извежда имената на всички филми
-- с дължина по-голяма от дължината на филма ‘Gone With the Wind’

use movies;
select TITLE
from MOVIE
where LENGTH >(select length
				from movie
				where TITLE = 'Pretty Woman'); 

-- 1.4 Напишете заявка, която извежда имената на продуцентите и
-- имената на продукциите за които стойността им е по-голяма
-- от продукциите на продуценти ‘Mery Griffin’

-- (от Слав): Напишете заявка, която извежда имената на продуцентите,
-- за които нетната стойност е по-голяма от тази на 'Merv Griffin'.

use movies;
select name
from MOVIEEXEC
where NETWORTH > (select NETWORTH
					from MOVIEEXEC
					where NAME = 'Merv Griffin'); 

-- 2.1 Напишете заявка, която извежда производителите
-- на персонални компютри с честота поне 500.

use pc;
select distinct maker
from product
where model in (select model
					from pc
					where speed >= 500);

-- 2.2 Напишете заявка, която извежда принтерите с най-висока цена.

use pc;
select code
from printer
where price >= All(select price
					from printer);
					
use pc;
select code
from printer
where price = (select max (price)
				from printer);
									

-- 2.3 Напишете заявка, която извежда лаптопите, чиято честота
-- е по-ниска от честотата на който и да е персонален компютър.

use pc;
select code
from laptop 
where speed <(select top 1 speed
				from pc
				order by speed asc);
				
use pc;
select code
from laptop
where speed < (select MIN (speed)
				from pc	);
				 
use pc;
select code
from laptop
where speed < All(select speed 
					from pc);

-- 2.4 Напишете заявка, която извежда модела на продукта
-- (PC, лап топ или принтер) с най-висока цена.

use pc;
select top 1 model
from (select model,price from pc
		union
		select model, price from laptop
		union 
		select model,price from printer)t
order by price desc;

					

-- 2.5 Напишете заявка, която извежда производителя
-- на цветния принтер с най-ниска цена.

use pc;
select p.maker
from product p, (select top 1 price, model
				from printer
				where color = 'y'
				order by price asc)t
where p.model = t.model;


-- 2.6 Напишете заявка, която извежда производителите на
-- тези персонални компютри с най-малко RAM памет,
-- които имат най-бързи процесори.

use pc;
select maker
from product p, (select top 1 ram,speed,model
				from pc
				order by ram asc,speed desc)t
where p.model = t.model;

use pc;
select p.maker
from product p
join (select top 1 ram,speed,model
		from pc
		order by ram asc, speed desc) as t on t.model=p.model;

use pc;
select top 1 p.maker
from product p
join pc as p1 on p1.model=p.model
order by p1.ram asc,p1.speed desc;

-- 3.1 Напишете заявка, която извежда страните,
-- чиито кораби са с най-голям брой оръжия.

use ships;
select distinct country
from CLASSES
where NUMGUNS >= All(select top 1 NUMGUNS
					from CLASSES
					order by NUMGUNS desc);

-- 3.1 Напишете заявка, която извежда класовете,
-- за които поне един от корабите им е потънал в битка.

use ships;
select distinct CLASS
from CLASSES
where  exists(select ship
				from OUTCOMES
				where RESULT ='sunk');

-- 3.2 Напишете заявка, която извежда имената на
-- корабите с 16 инчови оръдия (bore).

use ships;
select name
from ships
where CLASS in (select CLASS
				from CLASSES
				where BORE = 16);

-- 3.3 Напишете заявка, която извежда имената на
-- битките, в които са участвали кораби от клас ‘Kongo’.

use ships;
select b.NAME 
from BATTLES b
join OUTCOMES as o on o.BATTLE = b.NAME
where o.SHIP in (select NAME
				from ships
				where CLASS = 'Kongo');

-- 3.4 Напишете заявка, която извежда иманата на корабите,
-- чиито брой оръдия е най-голям в сравнение с корабите
-- със същия калибър оръдия (bore).

use ships;
select s.NAME
from ships s
join CLASSES as c on s.CLASS = c.CLASS
where c.NUMGUNS >= All(select NUMGUNS
						from CLASSES
						where BORE = c.BORE);
