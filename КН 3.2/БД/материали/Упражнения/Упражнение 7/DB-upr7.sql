begin transaction 

use movies;
-- �� �� ������ ���������� �� ��������� Nicole Kidman.
-- �� ��� ����� ����, �� � ������ �� 20-� ��� 1967.

insert into moviestar(name,gender,birthdate)
values('nicole Kidman','F','1967-06-20');

-- �� �� ������� ������ ���������� � ������� (networth) ��� 10 �������.

delete from movieexec
where networth < 10000000;

-- �� �� ������ ������������ �� ������ ������� ������, �� ����� �� �� ���� ������.

delete from moviestar
where address is null;

-- ����������� ��� INSERT ������, ��������� � ������ ����� �����,
-- �� ���������� �������� ����� 1100 � �������� �� ������������� C,
-- ��� �������� 2400 MHz, RAM 2048 MB, ����� ���� 500 GB, 52x DVD
-- ���������� � ������ $299. ���� ������ �������� ��� ��� 12.
-- ���������: ������� � CD �� �� ��� ���.
-- ��������: ������ �������� �� ����� � �������� ��� �� �����,
-- ��������� � ����� ��� � ��-������� �� �� ����� ������.

use pc;
insert into product(maker,model,type)
values('c','1100','PC')
insert into PC(code,model,speed,ram,hd,cd,price)
values(12,'1100',2400,2048,999,'52x',299)

-- �� ����� ���������� �������� �� ������� � 15-����� ������ ��� ������ ���������,
-- �� � $500 ��-����. ����� �� ����� ������ � ��� 100 ��-����� �� ���� �� ����������
-- ��������. �������� ���� ���������� � ������.

insert into laptop(code,model,speed,ram,hd,screen,price)
select code+100,model,speed,ram,hd,15,price + 500
from pc;

-- �� �� ������ �������� ������� ���������� �� �������� ����� 1100.

delete from pc where model = '1100'
delete from product where model = '1100'

-- �� �� ������� ������ �������, ��������� �� ������������,
-- ����� �� ���������� ��������.
-- ��������: ������� ��, �� �������� ������ �� ������ ��� -
-- "�� �� ������� ������ �������, ...". ������ �� � ����� ������ ����� �������.
-- ��� ��������� �������� �� ������, ����� � �������� ��� ����� ������ ����
-- �� �������� ������ ������� � �� ������ ����� �� �������������� ���������
-- ��� �� �������� �� �����.

delete from laptop
where model in
		(select model
		from product
		where type = 'laptop'
			and maker not in
						(select maker
						from product
						where type = 'printer'))
						
-- ������������ � ������ ������������ B. �� ������ �������� �� � ��������� ������������� �� ���� �.

update product
set maker = 'A'
where maker = 'B'

-- �� �� ������ ��� ���� ������ �� ����� �������� � �� �� �������
-- �� 20 GB ��� ����� ����� ����. ��������: ���� ����� �� ��� ������� ������.
--select *
--from pc

update pc
set price = price/2,hd = hd + 20

--select *
--from pc
-- �� ����� ������ �� ������������ 'B' �������� �� ���� ��� ��� ��������� �� ������.

update laptop
set screen = screen + 1
where model in (select model
				from product
				where maker ='B'
				and type = 'Laptop');
				
-- ��� ��������� ����� ������ �� ����� Nelson - Nelson � Rodney -
-- �� ���� ������� �� ���� ������������ ���� 1927 �.
-- ����� �� ����� 16-������ ������ (bore) � ��������������� ��
-- 34 000 ���� (displacement). �������� ���� ����� ��� ������ �� �����.

use ships;

insert into classes
values('Nelson','bb','Gt.Britain',9,16,34000);
insert into ships
values('Nelson','Nelson',1927);
insert into ships
values('Rodney','Nelson',1927);

--select *
--from ships
-- �������� �� Ships ������ ������, ����� �� �������� � �����.

delete from ships
where name in (select ship
				from outcomes
				where result = 'sunk');
				
-- ��������� ��������� Classes ����, �� ��������� (bore) 
-- �� �� ������� � ����������(� ������� � � ������, 1 ��� ~ 2.5 ��)
-- � ����������������� �� �� ������� � �������� ������ (1 �.�. = 1.1 �.)

update classes
set bore = bore * 2.5,
	displacement = displacement/1.1;
	
--select *
--from classes
-- �������� ������ �������, �� ����� ��� ��-����� �� ��� ������.

delete from classes
where class not in (select class
					from ships
					group by class
					having count(*) >= 3)
					
--2 �������
delete from classes
where class in (select c.class
				from classes c
				left join ships s on c.class = s.class
				group by c.class
				having count(s.name) < 3);
		use ships		
-- ��������� �������� �� �������� � ����������������� �� ����� Iowa,
-- ���� �� �� �� ������ ���� ���� �� ����� Bismarck.

update classes
set bore = (select bore
			from classes
			where class = 'Bismarck'),
	displacement = (select displacement
					from classes
					where class = 'Bismarck')
where class = 'Iowa'

rollback transaction

-- �� �� ������ ����� �� �������(���������), ��������(�) � ���-����� �����,
-- ����� � �������� �� ���-������ ����, � ����� ��������(���������) ��� ������,
-- � ����� �� ��������, � ����� ��������(���������) ��� ���-����� �������� ��
-- ������� ��� ����� �� ���� ������.

use movies;

select name, (select top 1 title from movie join starsin on title=movietitle and year=movieyear
				where si.starname = starsin.starname order by length desc),
			(select top 1 year from movie join starsin on title=movietitle and year=movieyear
				where si.starname = starsin.starname order by length desc),
			(select top 1 studioName from movie join starsin on title=movietitle and year=movieyear
				where si.starname = starsin.starname
			group by studioName
			order by count(*) desc)
from moviestar ms
join starsin si on ms.name = si.starname
join movie on title=movietitle and year=movieyear
group by name, si.starname
having count(*) >= all (select count(*) from moviestar ms join starsin si on ms.name = si.starname
group by name)

