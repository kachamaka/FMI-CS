
----- ��������� � ���������  01.04.2011 -----

use movies;
SELECT AVG (netWorth)
FROM MovieExec;

SELECT COUNT(*)
FROM StarsIn;

SELECT COUNT(DISTINCT starName)
FROM StarsIn;

-- ��.: �� ����� ������ ������� ������ �� ��������� �� ������ �����
SELECT studioName, SUM(length)
FROM Movie
GROUP BY studioName;

-- ��.: �� �� ������ �� ����� ������ ����� ������� ������ �� ������:

select year(birthdate), count(*)
from moviestar
group by year(birthdate);

-- ��.: ������� � ���-������ �������:
-- ����� �� �������� � ... > all (select lenth ...)

select *
from movie
where length = (select max (length) from movie);

-- ����������� ������: where lentgth = max( select length ... )

-- ������ 

use pc;
-- 1.1 �������� ������, ����� ������� �������� ������� �� ����������

select avg(speed)
from pc;

-- 1.2 �������� ������, ����� ������� ������� ������ �� �������� �� ��������� ��
-- ����� ������������

select maker, avg(screen)
from laptop l
join product p on l.model = p.model
group by maker;

-- 1.3 �������� ������, ����� ������� �������� ������� �� ��������� � ���� ��� 1000

select avg(speed)
from  laptop
where price > 1000;

-- 1.4 �������� ������, ����� ������� �������� ���� �� ���������� ����������� ��
--������������ �A�

-- 1.5 �������� ������, ����� ������� �������� ���� �� ���������� � ��������� ��
--������������ �B�

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

-- 1.6 �������� ������, ����� ������� �������� ���� �� ���������� ������
--���������� �� �������

select speed, avg (price)
from pc
group by speed;

-- 1.7 �������� ������, ����� ������� ���������������, ����� �� ��������� ���� �� 3
--�������� ������ ���������

select maker
from product
where type = 'PC'
group by maker
having count(*) >= 3;

-- 1.8 �������� ������, ����� ������� ��������������� �� ���������� � ���-������
--����

select distinct maker
from product p
join pc on p.model = pc.model
where price = (select max(price) from pc);

-- 1.9 �������� ������, ����� ������� �������� ���� �� ���������� �� ����� �������
--��-������ �� 800

select speed, avg(price)
from pc
where speed >800
group by speed;

-- 1.10 �������� ������, ����� ������� ������� ������ �� ����� �� ���� ��������
--����������� �� �������������, ����� ����������� � ��������

select avg(hd)
from pc
join product p on pc.model = p.model
where maker in (select maker
				from product
				where type = 'Printer');

-- 1.11 �������� ������, ����� �� ����� ������ �� ������ ������ ��������� � ������ ��
--���-������ � ���-������� ������ ��� ����� ������

select screen, max(price) - min (price) 
from laptop
group by screen;


use ships;
-- 2.1 �������� ������, ����� ������� ���� �� ��������� ������

select count(*)
from classes;

-- 2.2 �������� ������, ����� ������� ������� ���� �� ������ �� ������ ������,
--������� �� ����

select avg(numguns)
from classes c
join ships s on c.class = s.class;

-- 2.3 �������� ������, ����� ������� �� ����� ���� ������� � ���������� ������, �
--����� ����� �� ���������� ���� � ������ �� ����

select class, min (launched) as FirstYear,
	max(launched) as LastYear
from ships
group by class;

-- 2.4 �������� ������, ����� ������� ���� �� �������� �������� � ����� ������ �����
--( ���� �� ������� ����� ���� ���� 1 ������� �����)

select class , count (*)
from ships s
join outcomes o on s.name = o.ship
where result = 'sunk'
group by class;


-- 2.5 �������� ������, ����� ������� ���� �� �������� �������� � ����� ������
--�����, �� ���� ������� � ������ �� 4 ������� �� ���� ������

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

-- 2.6 �������� ������, ����� ������� �������� ����� �� ��������, �� ����� ������.

select country, avg(displacement)
from classes c
join ships s on c.class = s.class
group by country;


-- ������ 2

use movies;
-- �� ����� ������/������� �������� ���� �� ���������� ������, 
-- � ����� �� ��������� �����.

select starname, count (distinct studioname)
from starsin
join movie on movietitle = title and movieyear = year
group by starname;


-- ��� ������ �� ���. � ���������, ����� �� �� ������ � ���� 1 ����

select starname, count (distinct studioname)
from movie
join starsin on movietitle = title and movieyear = year
right join moviestar on name = starname
group by starname;

-- �� ����� ������/������� �������� ���� �� ���������� ������,
-- � ����� �� ��������� �����, ����������� � �� ����, 
-- �� ����� ������ ���������� � ����� ����� �� ������.

-- �������� ������� �� ���������, ��������� � ���� 3 ����� ���� 1990 �.

select starname
from starsin
where movieyear >1990
group by starname
having count (*) >=3;

use pc;
-- �� �� ������� ���������� ������ ��������, ��������� 
-- �� ���� �� ���-������ ��������� �������� �� ����� �����.

select model
from pc
group by model
order by max(price);

use ships;
-- �������� ���� �� ���������� ����������� ������ �� ����� 
-- ��������� ����� � ���� ���� ������� ����������� �����.

select battle, count(*)
from classes c
join ships s on s.class = c.class
join outcomes o on s.name = o.ship
where c.country = 'USA' and result = 'sunk'
group by battle;

-- �������, � ����� �� ��������� ���� 3 ������ �� ���� � ���� ������.

select distinct o.battle
from classes c
join ships s on s.class = c.class
join outcomes o on s.name = o.ship
group by o.battle, c.country
having count(*)>=3;

-- ������� �� ���������, �� ����� ���� �����, 
-- ������ �� ���� ���� 1921 �., �� ���� ������ ���� ���� �����.

select class
from ships
group by class
having max(launched)<=1921;

-- (*) �� ����� ����� �������� ���� �� �������, 
-- � ����� � ��� �������. ��� ������� �� � ��������
-- � ����� ��� ��� ������ �� � ��� ��������, � ��������� �� �� ������ 0.

------1 �����:

select s.name, count(battle)
from ships s
left join outcomes o on s.name = o.ship and result = 'damaged'
group by s.name;

------ 2 �����:(������ � ������ ���� �� 1 �����)

select name, count(battle)
from ships s
left join (select *
		from outcomes
		where result = 'damaged' ) o
	on s.name = o.ship
group by name;

------ 3 �����:

select name, (select count(battle)
	from outcomes o
	where result = 'damaged'
	and s.name = o.ship)
from ships s;

-- (*) �������� �� ����� ���� � ���� 3 ������ ���� 
-- �� �������� �� ���� ����, ����� �� �������� � �����

select class, count (distinct ship)
from ships 
left outer join outcomes
on name = ship and result = 'ok'
group by class
having count (distinct name) >= 3;