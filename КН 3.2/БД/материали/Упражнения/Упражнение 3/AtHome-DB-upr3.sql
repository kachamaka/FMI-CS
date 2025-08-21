-- �������� �� ���������� 3 (� ����)

-- 1.1 �������� ������, ����� ������� ������� �� ���������,
-- ����� �� ���� � ���������� � ����� �������� ��-������ �� 10 �������.

use movies;
select m.NAME
from MOVIESTAR m, (select name
				from MOVIEEXEC
				where NETWORTH > 10000000)t
where m.GENDER = 'F' and m.NAME = t.NAME;

-- 1.2 �������� ������, ����� ������� ������� �� ����
-- ������� (���� � ����), ����� �� �� ����������.

use movies;
select name
from MOVIESTAR 
where NAME not in (select name
					from MOVIEEXEC);

-- �� ���������� 2, �� �� ����� � ���������

-- 1.3 �������� ������, ����� ������� ������� �� ������ �����
-- � ������� ��-������ �� ��������� �� ����� �Gone With the Wind�

use movies;
select TITLE
from MOVIE
where LENGTH >(select length
				from movie
				where TITLE = 'Pretty Woman'); 

-- 1.4 �������� ������, ����� ������� ������� �� ������������ �
-- ������� �� ����������� �� ����� ���������� �� � ��-������
-- �� ����������� �� ���������� �Mery Griffin�

-- (�� ����): �������� ������, ����� ������� ������� �� ������������,
-- �� ����� ������� �������� � ��-������ �� ���� �� 'Merv Griffin'.

use movies;
select name
from MOVIEEXEC
where NETWORTH > (select NETWORTH
					from MOVIEEXEC
					where NAME = 'Merv Griffin'); 

-- 2.1 �������� ������, ����� ������� ���������������
-- �� ���������� �������� � ������� ���� 500.

use pc;
select distinct maker
from product
where model in (select model
					from pc
					where speed >= 500);

-- 2.2 �������� ������, ����� ������� ���������� � ���-������ ����.

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
									

-- 2.3 �������� ������, ����� ������� ���������, ����� �������
-- � ��-����� �� ��������� �� ����� � �� � ���������� ��������.

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

-- 2.4 �������� ������, ����� ������� ������ �� ��������
-- (PC, ��� ��� ��� �������) � ���-������ ����.

use pc;
select top 1 model
from (select model,price from pc
		union
		select model, price from laptop
		union 
		select model,price from printer)t
order by price desc;

					

-- 2.5 �������� ������, ����� ������� �������������
-- �� ������� ������� � ���-����� ����.

use pc;
select p.maker
from product p, (select top 1 price, model
				from printer
				where color = 'y'
				order by price asc)t
where p.model = t.model;


-- 2.6 �������� ������, ����� ������� ��������������� ��
-- ���� ���������� �������� � ���-����� RAM �����,
-- ����� ���� ���-����� ���������.

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

-- 3.1 �������� ������, ����� ������� ��������,
-- ����� ������ �� � ���-����� ���� ������.

use ships;
select distinct country
from CLASSES
where NUMGUNS >= All(select top 1 NUMGUNS
					from CLASSES
					order by NUMGUNS desc);

-- 3.1 �������� ������, ����� ������� ���������,
-- �� ����� ���� ���� �� �������� �� � ������� � �����.

use ships;
select distinct CLASS
from CLASSES
where  exists(select ship
				from OUTCOMES
				where RESULT ='sunk');

-- 3.2 �������� ������, ����� ������� ������� ��
-- �������� � 16 ������ ������ (bore).

use ships;
select name
from ships
where CLASS in (select CLASS
				from CLASSES
				where BORE = 16);

-- 3.3 �������� ������, ����� ������� ������� ��
-- �������, � ����� �� ��������� ������ �� ���� �Kongo�.

use ships;
select b.NAME 
from BATTLES b
join OUTCOMES as o on o.BATTLE = b.NAME
where o.SHIP in (select NAME
				from ships
				where CLASS = 'Kongo');

-- 3.4 �������� ������, ����� ������� ������� �� ��������,
-- ����� ���� ������ � ���-����� � ��������� � ��������
-- ��� ����� ������� ������ (bore).

use ships;
select s.NAME
from ships s
join CLASSES as c on s.CLASS = c.CLASS
where c.NUMGUNS >= All(select NUMGUNS
						from CLASSES
						where BORE = c.BORE);
