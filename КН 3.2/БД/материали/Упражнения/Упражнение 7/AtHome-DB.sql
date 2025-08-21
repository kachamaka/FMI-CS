
-- �� �� ������ ���������� �� ��������� Nicole Kidman.
-- �� ��� ����� ����, �� � ������ �� 20-� ��� 1967.

use movies;
insert into MOVIESTAR(NAME,GENDER,BIRTHDATE,ADDRESS) values ('Nicole Kidman','F','1967-06-20', null);
select * from MOVIESTAR;
delete from MOVIESTAR where NAME = 'Nicole Kidman';

-- �� �� ������� ������ ���������� � ������� (networth) ��� 10 �������.

select * from MOVIEEXEC;
insert into MOVIEEXEC(CERT#, NAME, ADDRESS,NETWORTH) values ('1','aaaa','aaaa', '10');
insert into MOVIEEXEC(CERT#, NAME, ADDRESS,NETWORTH) values ('2','bbbb','bbbb', '20');
insert into MOVIEEXEC(CERT#, NAME, ADDRESS,NETWORTH) values ('3','cccc','cccc', '30');

delete from MOVIEEXEC where NETWORTH < 50;

-- �� �� ������ ������������ �� ������ ������� ������, �� ����� �� �� ���� ������.

select * from MOVIESTAR;
insert into MOVIESTAR(NAME,GENDER,BIRTHDATE) values ('aaaaaa','F','1967-06-20')
insert into MOVIESTAR(NAME,GENDER,BIRTHDATE,ADDRESS) values ('bbbbbb','F','1967-06-20', null)
insert into MOVIESTAR(NAME,GENDER,BIRTHDATE,ADDRESS) values ('cccccc','F','1967-06-20', null);

delete from MOVIESTAR where ADDRESS is null;

-- ����������� ��� INSERT ������, ��������� � ������ ����� �����,
-- �� ���������� �������� ����� 1100 � �������� �� ������������� C,
-- ��� �������� 2400 MHz, RAM 2048 MB, ����� ���� 500 GB, 52x DVD
-- ���������� � ������ $299. ���� ������ �������� ��� ��� 12.
-- ���������: ������� � CD �� �� ��� ���.
-- ��������: ������ �������� �� ����� � �������� ��� �� �����,
-- ��������� � ����� ��� � ��-������� �� �� ����� ������.

use pc;
select * from pc;
select * from product;
insert into product(maker, model, type) values ('C','1100','PC');
insert into pc(model,speed,ram,price,hd,code,cd) values ('1100', '2400','2048','299','500','12','52');

-- �� ����� ���������� �������� �� ������� � 15-����� ������ ��� ������ ���������,
-- �� � $500 ��-����. ����� �� ����� ������ � ��� 100 ��-����� �� ���� �� ����������
-- ��������. �������� ���� ���������� � ������.

insert into laptop(code,hd,model,price,ram,screen,speed)
select code+100, hd, model,price+500,ram,'15',speed 
from PC

-- �� �� ������ �������� ������� ���������� �� �������� ����� 1100.

delete from product where model='1100' and type = 'PC' and maker = 'C';
delete from pc where model = '1100' and code='12';

-- �� �� ������� ������ �������, ��������� �� ������������,
-- ����� �� ���������� ��������.
-- ��������: ������� ��, �� �������� ������ �� ������ ��� -
-- "�� �� ������� ������ �������, ...". ������ �� � ����� ������ ����� �������.
-- ��� ��������� �������� �� ������, ����� � �������� ��� ����� ������ ����
-- �� �������� ������ ������� � �� ������ ����� �� �������������� ���������
-- ��� �� �������� �� �����.

select * -- �� �� �� ������� ������ select * �� ������ delete
from laptop 
where model in (select model 
				from product
				where type = 'laptop' and maker not in (select maker 
													from product		
													where type = 'printer'));
						
-- ������������ � ������ ������������ B. �� ������ �������� �� � ��������� ������������� �� ���� �.

UPDATE product SET maker = 'A' where maker = 'B'

Update product set maker = 'B' where model = '1121' and type='PC'
Update product set maker = 'B' where model = '1750' and type='Laptop'

select * from laptop

-- �� �� ������ ��� ���� ������ �� ����� �������� � �� �� �������
-- �� 20 GB ��� ����� ����� ����. ��������: ���� ����� �� ��� ������� ������.

select * from pc;
update pc set price= price/2, hd = hd +20;

-- �� ����� ������ �� ������������ 'B' �������� �� ���� ��� ��� ��������� �� ������.

update laptop set screen = screen+1
where model in (select model
				from product
				where maker = 'B' and type = 'laptop');
				
-- ��� ��������� ����� ������ �� ����� Nelson - Nelson � Rory -
-- �� ���� ������� �� ���� ������������ ���� 1927 �.
-- ����� �� ����� 16-������ ������ (bore) � ��������������� ��
-- 34 000 ���� (displacement). �������� ���� ����� ��� ������ �� �����.

use ships;
insert into CLASSES(CLASS, NUMGUNS, BORE, DISPLACEMENT, TYPE, COUNTRY) values ('Nelson', '9','16','34000','bb','British');
insert into ships(NAME,CLASS,LAUNCHED) values ('Nelson', 'Nelson','1927')
insert into ships(NAME,CLASS,LAUNCHED) values ('Rory', 'Nelson','1927');

select * from ships

-- �������� �� Ships ������ ������, ����� �� �������� � �����.

select * -- �� �� �� ������� �� ������ �� select * �� ������ delete
from ships
where NAME in (select ship
				from OUTCOMES
				where RESULT = 'sunk');
				
-- ��������� ��������� Classes ����, �� ��������� (bore) 
-- �� �� ������� � ����������(� ������� � � ������, 1 ��� ~ 2.5 ��)
-- � ����������������� �� �� ������� � �������� ������ (1 �.�. = 1.1 �.)

select * from ships;
update CLASSES set BORE = BORE*2.5, DISPLACEMENT = DISPLACEMENT*1.1; 
	
-- �������� ������ �������, �� ����� ��� ��-����� �� ��� ������.

-- 1 �����
select CLASS 
from CLASSES c
where (select Count (NAME) 
		from ships s
		where c.CLASS = s.CLASS) < 3;
		
-- 2 �����		
select CLASS
from CLASSES c
where class not in (select class
					from ships
					group by class
					having count(*) >= 3)
				
-- ��������� �������� �� �������� � ����������������� �� ����� Iowa,
-- ���� �� �� �� ������ ���� ���� �� ����� Bismarck.

update CLASSES set BORE = (select bore
							from CLASSES
							where CLASS = 'Bismarck'),
					DISPLACEMENT = (select DISPLACEMENT
									from CLASSES
									where CLASS = 'Bismarck')
			where CLASS = 'Iowa';
			
select * from CLASSES;								

-- �� �� ������ ����� �� �������(���������), ��������(�) � ���-����� �����,
-- ����� � �������� �� ���-������ ����, � ����� ��������(���������) ��� ������,
-- � ����� �� ��������, � ����� ��������(���������) ��� ���-����� �������� ��
-- ������� ��� ����� �� ���� ������.





