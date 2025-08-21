-- �������� �� ���������� 2 (� ����)

use movies;
select *
from STUDIO;

use movies;
select *
from movie;

use pc;

select distinct model as name1, price
from pc
where price < 600
union
select model, price
from laptop
where price < 1000;

use pc;
select maker
from product
where type = 'PC'
intersect
select maker
from product
where type = 'Laptop';

use movies;

select *
from movie, studio;

select *
from movie
cross join studio;


select * 
from STARSIN inner join MOVIESTAR
on Starsin.starname = moviestar.name;

-- 1.1 �������� ������, ����� ������� ������� �� ��������� ����,
-- ��������� � �Terms of Endearment�

use movies;
select STARNAME
from  STARSIN
join moviestar on starname = name 
where MOVIETITLE = 'Terms of Endearment' and GENDER = 'M';

-- 1.2 �������� ������, ����� ������� ������� �� ���������, ��������� ��� �����,
-- ����������� �� �MGM����� 1995 �.

use movies;
select Starname
from STARSIN
join movie on MOVIETITLE = TITLE and MOVIEYEAR = YEAR
where STUDIONAME = 'MGM';

-- 1.3 �������� ������, ����� ������� ����� �� ���������� �� �MGM�

use movies;
select MOVIEEXEC.NAME
from studio
join movieexec on presc# = cert#
where studio.name = 'MGM';

-- 1.4 �������� ������, ����� ������� ������� �� ������ ����� � �������,
-- ��-������ �� ��������� �� ����� �Star Wars�

use movies;
select m1.TITLE
from movie as m1
cross join movie as m2
where m2.TITLE = 'Star Wars' and m1.TITLE > m2.TITLE;

-- 2.1 �������� ������, ����� ������� ������������� � ��������� �� ���� ������� �
-- ������ �� ����� ���� 9 GB

use pc;
select maker, laptop.speed
from product 
join laptop on product.model = laptop.model 
where laptop.hd > 9;

-- 2.2 �������� ������, ����� ������� ����� �� ����� � ���� �� ������ ��������,
-- ����������� �� ������������ � ��� �B�

use pc;
select price, pc.model
from pc 
join product on product.model = pc.model
where product.maker ='B'
union 
select price, printer.model
from printer 
join product on product.model = printer.model
where product.maker ='B'
union
select price, laptop.model
from laptop 
join product on product.model = laptop.model
where product.maker ='B';

-- 2.3 �������� ������, ����� ������� ��������� �� ���� �������,
-- ����� �� ��������� � ������ �� ��� ���������

use pc;
select distinct pc1.hd
from pc as pc1
join pc as pc2 on pc1.hd = pc2.hd
join pc as pc3 on pc2.hd = pc3.hd
where pc1.code != pc2.code and pc2.code != pc3.code and pc1.code != pc3.code;


use pc;
select hd
from pc;


-- 2.4 �������� ������, ����� ������� ������ ������ ������ �� ��������,
-- ����� ���� ������� ������� � �����. �������� ������ �� �� ��������
-- ���� �� ������, �������� ���� (i, j), �� �� � (j, i)

use pc;
select distinct m1.model, m2.model
from pc as m1
join pc as m2 on m1.speed = m2.speed and m1.hd = m2.hd
where m1.code < m2.code;

-- 2.5 �������� ������, ����� ������� ��������������� �� ���� ��� ��������
-- ��������� � ������� ���� 1000.

use pc;
select distinct p1.maker
from pc as pc1
join product as p1 on pc1.model = p1.model
join product as p2 on p2.maker = p1.maker 
join pc as pc2 on p2.model = pc2.model
where pc1.code != pc2.code and pc1.speed >= 1000 and pc2.speed >=1000;

use pc;
select *
from product;
 


-- 3.1 �������� ������, ����� ������� ����� �� ��������, ��-����� (displacement) �� 35000

use ships;
select name
from ships as s1 
join CLASSES c1 on c1.CLASS = s1.CLASS
where c1.DISPLACEMENT > 35000; 

-- 3.2 �������� ������, ����� ������� �������, ����������������� � ���� ������ ��
-- ������ ������, ��������� � ������� ��� �Guadalcanal�

use ships;
select name, displacement, NUMGUNS
from ships as s1
join CLASSES c1 on c1.CLASS = s1.CLASS
join OUTCOMES o1 on o1.SHIP = s1.NAME
where o1.BATTLE = 'Guadalcanal';

select *
from OUTCOMES;

-- 3.3 �������� ������, ����� ������� ������� �� ���� �������, ����� ���� ������� ��
-- ��� �bb� � �bc� ������������

use ships;
select distinct c1.COUNTRY
from CLASSES as c1
join CLASSES as c2 on c1.COUNTRY = c2.COUNTRY
where c1.TYPE != c2.TYPE and ((c1.TYPE = 'bb'and c2.TYPE = 'bc') or (c1.TYPE = 'bc'and c2.TYPE = 'bb'));

-- 3.4 �������� ������, ����� ������� ������� �� ���� ������, ����� �� ����
-- ��������� � ���� �����, �� ��-����� �� ��������� � ����� �����.

select o1.SHIP
from OUTCOMES as o1
join OUTCOMES as o2 on o1.SHIP = o2.SHIP
join BATTLES as b1 on b1.NAME = o1.BATTLE
join BATTLES as b2 on b2.NAME = o2.BATTLE
where o1.RESULT = 'damaged' and  b1.DATE < b2.DATE;
