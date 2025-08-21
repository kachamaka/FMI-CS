-- Задачите от упражнение (в къщи)

-- 1.1 Напишете заявка, която извежда адресът на студио ‘MGM’
use movies;
select address
from studio
where name = 'MGM';

-- 1.2 Напишете заявка, която извежда рождената дата на актрисата Sandra Bullock

use movies;
select birthdate
from MOVIESTAR
where NAME = 'Sandra Bullock';

-- 1.3 Напишете заявка, която извежда имената на всички актьори,
-- които са участвали във филм през 1980 
-- в заглавието на които има думата ‘Empire’

use movies;
select starname
from STARSIN
where MOVIEYEAR = 1980 and MOVIETITLE like '%Empire%';

-- 1.4 Напишете заявка, която извежда имената всички
-- изпълнители на филми на стойност над 10 000 000 долара

use movies;
select name
from MOVIEEXEC
where NETWORTH > 10000000;

-- 1.5 Напишете заявка, която извежда имената на всички актьори,
-- които са мъже или живеят в Malibu

use movies;
select NAME
from MOVIESTAR
where GENDER = 'M' or ADDRESS = '%Malibu%';

-- 2.1 Напишете заявка, която извежда номер на модел, честота и
-- размер на диска за всички компютри с цена по-малка от 1200 долара.
-- Задайте псевдоними за атрибутите честота и размер на диска, съответно MHz и GB

use pc;
select model,speed as MHz, hd as GB
from laptop
where price < 1200;


-- 2.2 Напишете заявка, която извежда всички производители на принтери без повторения

use pc;
select distinct maker
from product
where type = 'Printer';

-- 2.3 Напишете заявка, която извежда номер на модел, размер на паметта,
-- размер на екран за лаптопите, чиято цена е по-голяма от 1000 долара

use pc;
select model, hd, screen
from laptop
where price > 1000;

-- 2.4 Напишете заявка, която извежда всички цветни принтери

use pc;
select *
from printer
where color = 'y';

-- 2.5 Напишете заявка, която извежда номер на модел, честота
-- и размер на диска за тези компютри с DVD 12x или 16x и цена по-малка от 2000 долара.

use pc;
select model, speed, hd,
from pc
where (cd = '12x' or cd = '16x')and price < 2000;

-- 3.1 Напишете заявка, която извежда името на класа и страната
-- за всички класове с брой на оръдията по-малък от 10

use ships;
select class, country,
from CLASSES
where NUMGUNS < 10;

-- 3.2 Напишете заявка, която извежда имената на всички кораби,
-- пуснати на вода преди 1918. Задайте псевдоним на колоната shipName

use ships;
select name
from ships
where LAUNCHED < 1918;

-- 3.3 Напишете заявка, която извежда имената на корабите
-- потънали в битка и имената на битките в които са потънали

use ships;
select ship, Battle
from OUTCOMES
where RESULT = 'sunk';

-- 3.4 Напишете заявка, която извежда имената на корабите
-- с име съвпадащо с името на техния клас

use ships;
select name
from ships
where NAME = CLASS;

-- 3.5 Напишете заявка, която извежда имената
-- на всички кораби започващи с буквата R

use ships;
select name
from ships
where NAME like 'R%';

-- 3.6 Напишете заявка, която извежда имената
-- на всички кораби, чието име е съставено от точно две думи.

use ships;
select name
from ships
where NAME like '% %' and NAME not like '% % %';