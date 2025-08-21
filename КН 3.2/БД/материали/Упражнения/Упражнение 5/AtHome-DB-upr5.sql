-- �������� �� ���������� 5 (� ����)

-- 1.1 �������� ������, ����� ������� �������� ������� �� ����������

use pc;
select AVG(speed)
from pc;

-- 1.2 �������� ������, ����� ������� ������� ������ ��
-- �������� �� ��������� �� ����� ������������

use pc;
select maker, AVG(laptop.screen)
from product
join laptop on product.model = laptop.model
group by maker;

-- 1.3 �������� ������, ����� ������� �������� ������� �� ��������� � ���� ��� 1000

use pc;
select AVG(speed)
from laptop
where price > 1000;

-- 1.4 �������� ������, ����� ������� �������� ���� �� ����������
-- ����������� �� ������������ �A�

use pc;
select AVG(price)
from pc
join product on pc.model = product.model
where product.maker = 'A';

--1.5 �������� ������, ����� ������� �������� ���� �� ����������
-- � ��������� �� ������������ �B�

use pc;
select AVG(price)
from product p
join (select price, model
		from pc
		union all
		select price, model
		from laptop) t on p.model = t.model
where p.maker ='B';

--1.6 �������� ������, ����� ������� �������� ���� �� ����������
-- ������ ���������� �� �������

use pc;
select speed,AVG(price)
from pc
group by speed;

-- 1.7 �������� ������, ����� ������� ���������������, ����� ��
-- ��������� ���� �� 3 �������� ������ ���������

select maker
from product
where type = 'PC'
group by maker
having count(*) >= 3;


--1.8 �������� ������, ����� ������� ��������������� ��
-- ���������� � ���-������ ����

use pc;
select maker
from product
join pc on pc.model = product.model
where price = (select MAX(price) from pc);

-- 1.9 �������� ������, ����� ������� �������� ���� ��
-- ���������� �� ����� ������� ��-������ �� 800

use pc;
select AVG(price)
from pc
group by speed
having speed >800;

-- 1.10 �������� ������, ����� ������� ������� ������ �� ����� �� ���� ��������
-- ����������� �� �������������, ����� ����������� � �������� 

use pc;
select product.maker, AVG(hd)
from pc
join product on product.model = pc.model
group by maker
having maker in (select maker
					from product
					where type = 'Printer');

--1.11 �������� ������, ����� �� ����� ������ �� ������ ������ ���������
-- � ������ �� ���-������ � ���-������� ������ ��� ����� ������

use pc;
select screen, MAX(price)-MIN (price)
from laptop
group by screen;

-- 2.1 �������� ������, ����� ������� ���� �� ��������� ������

use ships;
select COUNT(*)
from CLASSES;

-- 2.2 �������� ������, ����� ������� ������� ���� �� ������
-- �� ������ ������, ������� �� ����

use ships;
select AVG(numguns)
from CLASSES
join ships on CLASSES.CLASS = ships.CLASS;

-- 2.3 �������� ������, ����� ������� �� ����� ���� ������� � ���������� ������, �
-- ����� ����� �� ���������� ���� � ������ �� ����

use ships;
select CLASS,min(LAUNCHED)as FirstYear,MAX (LAUNCHED) as LastYear
from ships
group by class;

-- 2.4 �������� ������, ����� ������� ���� �� �������� �������� � ����� ������ �����

use ships;
select CLASS, COUNT(*)
from ships
join OUTCOMES on NAME = ship
where RESULT = 'sunk'
group by ships.CLASS;

-- 2.5 �������� ������, ����� ������� ���� �� �������� �������� � ����� ������
-- �����, �� ���� ������� � ������ �� 4 ������� �� ���� ������

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

-- 2.6 �������� ������, ����� ������� �������� ����� �� ��������, �� ����� ������.

use ships;
select country, AVG(DISPLACEMENT)
from CLASSES
join ships on CLASSES.CLASS = ships.CLASS
group by country;


