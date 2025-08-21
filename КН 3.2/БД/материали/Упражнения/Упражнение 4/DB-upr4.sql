-- ������ �� NATURAL JOIN
-- ���� ����� ���� 2 �������:
-- Movies(ModieID, Name, StudioID)
-- Studios(StudioID, Name, Address)

-- select *
-- from Movies
-- nalural join Studios;

-- <=> 

--select MoviesID, Movies.Name, Movies.StudioID, Address
-- from Movies
-- join Studios on Movies.StudioID = Studios.StudiosID
-- and Movies.Name = Studios.Name <---- �������

-- ������ 1: ������ �������, ����� �� �� ��� �����
-- (�.�. ������ ���� � ��� ����� �� ������)
use movies;
select *
from moviestar
left join starsin on name = starname
where starname is null;

select * from moviestar
where name not in (select starname from starsin);

-- ������ 2: ������������, ����� � ��� �� ������� �� ������
-- ��������, ����� �� �� ��������, �.�. ��� ������ � 
-- ��������� Product �� ���� ������ � ����������� 
-- �������PC/Laptop/Printer

--������� 1
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

--������ �� ��������� ��� ����� ������, �.�. �� ��� �� ����� �������

--������� 2 ������

select maker, p.model, p.type
from product p
left join pc on pc.model = p.model
left join laptop on laptop.model = p.model
left join printer on printer.model = p.model
where pc.model is null and laptop.model is null 
		and printer.model is null;

--������ 3: �� ����� ������� �� �� ������� ������� �� 
-- ��������, ����� ������ �� �� ��������� � �����

use ships;
select country, name
from classes c
join ships s on c.class = s.class
left join outcomes o on s.name = o.ship
where o.ship is null;

-- �������� �� ���� ������
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

-- ������ 4: (����������� �� �������� ������)
-- �� ����� �������� �� �� ������� ����� �� � ����� 
-- �� ������ �� ��������. ������ �: �� �� ������� � 
-- ���� ���������, ����� ����� ��������
use northwind;
-- � ���������� ������� �������� "left" ���� "join"

------------------------------------------------------------
------------------------------------------------------------

--������ �� ������ �� �����������:

-- ������ 1: ������� � �������� �� ������� �� ���� �� ������
-- ������, ����� ��� ������� � ����� �� ����� ��.

use ships;
select name, launched
from ships
where name = class;

-- ������ 2: (Northwind) ������ ��������� ����� ����� �������
-- ������������ ���� ������ "Ave" � "th" (�� ���������� � ���� ���).
-- ��������� �� ���� �������� �� ���� �� �����������
-- (����� ���-������) , � ����������� �� ���� ���� ��
-- ����� ��������� �� ������� ���.

use northwind;
select *
from employees
where address like '%Ave%' and address like '%th%'
order by hiredate desc, firstname asc, lastname asc; 

-- ������ 3: ���������, �� ����� ��� �������, ��������� �� 
-- ���������, ������ �/� 1.1.1970 � 1.1.1980.

select distinct ShipCity
from Employees e
join Orders o on e.EmployeeID = o.EmployeeID
where birthDate between '1970-01-01' and '1980-01-01'

-- ������ 4: ������ �������, ����� ���� �������� � ����� ������

use ships;
select distinct country
from classes c
join ships s on c.class = s.class
join outcomes o on s.name = o.ship
where o.result = 'sunk';

--������ 5: ������ �������, ����� ����� ���� ���� ������� �����
-- (���� ����� ������� � ������, ����� �� �� ��������� � ����� � �.�.)

select distinct country
from classes
where country not in
	( select distinct country
	from classes c
	join ships s on c.class = s.class
	join outcomes o on s.name = o.ship
	where o.result = 'sunk');

-- ������ �������: ��������� �� 4-� � o.result != 'sunk'

--������ 6: �������� �� ������ ���������, ����� �� �� 
--��������� ���� ���� ������� ���� 1.5.1998 . ��� �����
--�������� �� � �������� ���� ���� ������� ������,
-- ���� �� ���� �������

use northwind;
select FirstName, LastName
from Employees
where EmployeeID not in
	(select EmployeeID 
		from Orders
		where OrderDate > '1998-05-01'); 

--2�� �����
select FirstName, LastName
from Employees e
where not exists
	(select *
	from Orders
	where OrderDate > '1998-05-01'
		and Orders.EmployeeID = e.EmployeeID);

-- 3�� �����
select FirstName, LastName, OrderID, OrderDate
from Employees e
left join Orders o
	on o.EmployeeID = e.EmployeeID
		and OrderDate > '1998-05-01' -- ������������ � on ��������!
where OrderId is null;
	
--������ 7: ���������, ����� ���� ������� � �������� �������
--(����. ��� ���� � 14 ������� ������� � 16
-- �������, ������ �������������� ��� ���� ������� � 15)

use ships;
select distinct c1.country
from classes c1
join classes c2 on c1.country = c2.country
where c1.bore<>c2.bore;

-- ������ 8: ����-��, ����� �� ��-������ �� ����� ������ 
-- � ������ �� ����� ������������

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

-- ������ 9: �� ����� ������ � Order ������� ( � Northwind)
-- �� �� ������ ��������� ������� - �������� ���� +
--����������, ���������� ��������

use northwind;
select OrderID, ProductId,
		UnitPrice * Quantity * (1 - Discount)
from "Order Details";

-- ������ 10: ��������, ����� ����������� ������ � ���-����� ���� ������
--(numguns)

use ships;
select distinct country
from classes
where numguns >= all (select numguns from classes);

-- �������� CASE

use movies;
select Name, case Gender
			when 'M' then 'Male'
			when 'F' then 'Female'
		end as Gender
from moviestar;

-- ����� ���� �� ����������, ����� �� �������, ����� �� � �����. 
-- �� ����� ����� �� �� ������ �������� ���� � networth (��� ���)

select me.name, ms.birthdate, me.networth
from Movieexec me
full join  Moviestar ms on me.name = ms.name;

--2�� �����

select case
		when me.name is null then ms.name
		else me.name
	end as Name,
	ms.birthdate, me.networth
	from Movieexec me
full join MovieStar ms on me.name = ms.name;