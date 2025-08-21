-- 1. ������ �������, ����� �� �� ������ ��� �����
-- (�.�. ������ ���������� � ��� ����� �� ������)

use movies;
select NAME
from MOVIESTAR 
left join STARSIN on NAME = STARNAME
where MOVIETITLE is null;

-- 2. ������������, ����� � ��� �� ������� �� ������
-- ��������, ����� �� �� ��������, �.�. ��� ������ �
-- ��������� Product, �� ���� ������ � �����������
-- ������� PC/Laptop/Printer

use pc;
select distinct p.maker, p.model, p.type
from product p
left join laptop l on p.model = l.model
left join pc p1 on p.model = p1.model
left join printer pr on p.model = pr.model
where l.code is null and p1.code  is null and pr.code is null;



-- 3. �� ����� ������� �� �� ������� ������� �� 
-- ��������, ����� ������ �� �� ��������� � �����

use ships;
select country, name, ship
from classes c
join ships s on c.class = s.class
left join outcomes o on s.name = o.ship
where o.ship is null;

--������ �� ������ �� �����������:

-- ������ 1: ������� � �������� �� ������� �� ���� �� ������
-- ������, ����� ��� ������� � ����� �� ����� ��.

use ships;
select name, LAUNCHED
from ships
where NAME = CLASS;

-- ������ 4: ������ �������, ����� ���� �������� � ����� ������

use ships;
select distinct country
from CLASSES
join ships on CLASSES.CLASS = ships.CLASS
where ships.NAME in (select ship
				from OUTCOMES
				where RESULT = 'sunk');
				
--������ 5: ������ �������, ����� ����� ���� ���� ������� �����
-- (���� ����� ������� � ������, ����� �� �� ��������� � ����� � �.�.)

use ships;
select distinct country
from CLASSES
where COUNTRY not in (select distinct country
						from CLASSES
						join ships on CLASSES.CLASS = ships.CLASS
						where ships.NAME in (select ship
						from OUTCOMES
						where RESULT = 'sunk'));
						
--������ 7: ���������, ����� ���� ������� � �������� �������
--(����. ��� ���� � 14 ������� ������� � 16
-- �������, ������ �������������� ��� ���� ������� � 15)

use ships;
select distinct c1.COUNTRY
from CLASSES c1
join CLASSES c2 on c1.COUNTRY = c2.COUNTRY
where c1.BORE != c2.BORE;

-- ������ 8: ����-��, ����� �� ��-������ �� ����� ������ 
-- � ������ �� ����� ������������

use pc;
select p1.*
from product p
join pc p1 on p.model = p1.model
where p1.price < All(select la.price
						from product k
						join laptop la on la.model = k.model
						where k.maker = p.maker)
						and
		p1.price < All(select pr.price
						from product l
						join printer pr on pr.model = l.model
						where l.maker = p.maker);
						
-- ������ 10: ��������, ����� ����������� ������ � ���-����� ���� ������
--(numguns)

use ships;
select distinct country
from CLASSES
where NUMGUNS >= All(select NUMGUNS
					from CLASSES);


-- ����� ���� �� ����������, ����� �� �������, ����� �� � �����. 
-- �� ����� ����� �� �� ������ �������� ���� � networth (��� ���)

use movies;
select ms.BIRTHDATE, me.NETWORTH
from MOVIEEXEC me
full join MOVIESTAR ms on me.NAME = ms.NAME;