-- �������� �� ���������� (� ����)

-- 1.1 �������� ������, ����� ������� ������� �� ������ �MGM�
use movies;
select address
from studio
where name = 'MGM';

-- 1.2 �������� ������, ����� ������� ��������� ���� �� ��������� Sandra Bullock

use movies;
select birthdate
from MOVIESTAR
where NAME = 'Sandra Bullock';

-- 1.3 �������� ������, ����� ������� ������� �� ������ �������,
-- ����� �� ��������� ��� ���� ���� 1980 
-- � ���������� �� ����� ��� ������ �Empire�

use movies;
select starname
from STARSIN
where MOVIEYEAR = 1980 and MOVIETITLE like '%Empire%';

-- 1.4 �������� ������, ����� ������� ������� ������
-- ����������� �� ����� �� �������� ��� 10 000 000 ������

use movies;
select name
from MOVIEEXEC
where NETWORTH > 10000000;

-- 1.5 �������� ������, ����� ������� ������� �� ������ �������,
-- ����� �� ���� ��� ������ � Malibu

use movies;
select NAME
from MOVIESTAR
where GENDER = 'M' or ADDRESS = '%Malibu%';

-- 2.1 �������� ������, ����� ������� ����� �� �����, ������� �
-- ������ �� ����� �� ������ �������� � ���� ��-����� �� 1200 ������.
-- ������� ���������� �� ���������� ������� � ������ �� �����, ��������� MHz � GB

use pc;
select model,speed as MHz, hd as GB
from laptop
where price < 1200;


-- 2.2 �������� ������, ����� ������� ������ ������������� �� �������� ��� ����������

use pc;
select distinct maker
from product
where type = 'Printer';

-- 2.3 �������� ������, ����� ������� ����� �� �����, ������ �� �������,
-- ������ �� ����� �� ���������, ����� ���� � ��-������ �� 1000 ������

use pc;
select model, hd, screen
from laptop
where price > 1000;

-- 2.4 �������� ������, ����� ������� ������ ������ ��������

use pc;
select *
from printer
where color = 'y';

-- 2.5 �������� ������, ����� ������� ����� �� �����, �������
-- � ������ �� ����� �� ���� �������� � DVD 12x ��� 16x � ���� ��-����� �� 2000 ������.

use pc;
select model, speed, hd,
from pc
where (cd = '12x' or cd = '16x')and price < 2000;

-- 3.1 �������� ������, ����� ������� ����� �� ����� � ��������
-- �� ������ ������� � ���� �� �������� ��-����� �� 10

use ships;
select class, country,
from CLASSES
where NUMGUNS < 10;

-- 3.2 �������� ������, ����� ������� ������� �� ������ ������,
-- ������� �� ���� ����� 1918. ������� ��������� �� �������� shipName

use ships;
select name
from ships
where LAUNCHED < 1918;

-- 3.3 �������� ������, ����� ������� ������� �� ��������
-- �������� � ����� � ������� �� ������� � ����� �� ��������

use ships;
select ship, Battle
from OUTCOMES
where RESULT = 'sunk';

-- 3.4 �������� ������, ����� ������� ������� �� ��������
-- � ��� ��������� � ����� �� ������ ����

use ships;
select name
from ships
where NAME = CLASS;

-- 3.5 �������� ������, ����� ������� �������
-- �� ������ ������ ��������� � ������� R

use ships;
select name
from ships
where NAME like 'R%';

-- 3.6 �������� ������, ����� ������� �������
-- �� ������ ������, ����� ��� � ��������� �� ����� ��� ����.

use ships;
select name
from ships
where NAME like '% %' and NAME not like '% % %';