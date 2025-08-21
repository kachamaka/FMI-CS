-- ���������� - 27.05.2011�.
--			������� 

use ships;
-- ���.1: ��� ��������� �� ����� ����������� �� �� 
-- ������� � ������� ����, ��� ���� ������ ������ �� ���� ����. 

create trigger DeleteEmptyClasses
on ships
after delete
as 
delete from classes
where class in 
	(select class
	from deleted
	where class not in
		(select class
		from ships));

-- ���������: ��� �� ���������� deleted,
-- � ������� ships, ����� �� ������ �
-- ���������, ����� �� ���� ������ � �����
-- ���������� delete;

select * from ships;
select * from classes;
insert into classes values('Test','bb','BG',10,10,10000);
insert into ships values('Test','Test',2);
delete from ships where name= 'Test';
drop trigger DeleteEmptyClasses;

-- ���.2: �� �� ������� ����, �� ��� ��������
-- �� ��� ���� ����������� �� �� ������ �
-- ��� ����� ��� ������ ��� � � ������ ��
-- ������� �� ���� = null.

create trigger IsertFirthShip
on classes
after insert
as
insert into ships(name, class)
select class, class
from inserted;

insert into classes
values('Test','bb','BG',10,10,10000);

select * from ships;

delete from ships where launched is null;
delete from classes where class='Test';
drop trigger IsertFirthShip;

-- ���.3: �� �� ������� ����, �� ��� ���
-- �������� ��� ���������� �� �����
-- �������� �� �� ������� � ��-������ ��
-- �������� ������, �� �������� �� �� ����
-- ��������� �� null.

create trigger t
on ships
after insert, update
as
update ships
set launched = null
where name in
	(select name
	from inserted)
	and launched > year(getdate());

insert into ships values('Test', 'Iowa', 2258);

select * from ships;

drop trigger t;

use movies;
-- ���.4: ��� ������� �� �����-��� ���� �� 
-- ������ ����������� ��������� �� ��������
-- $100000.

create trigger t
on movie
after update
as
update movieexec
set networth = networth + 100000
where cert# in
	(select i.producerc#
	from deleted d
	join inserted i
		on d.title = i.title
		and d.year = i.year
	where d.incolor='n' and i.incolor='y');

drop trigger t;

-- ���.5: �� �� �� ������� �������� �� ������
-- � OUTCOMES, ����� �� ������, �� �����
-- ����� � �������� � �����, ����� �� ����
-- ������ �� ����.

-- �) ��� �� ������� ������� �������,
-- ����������� �� ����� ����������, � ����
-- ����������� �� ����� �������� � OUTCOMES;

use ships;

create trigger t
on outcomes
instead of insert
as
begin
insert into outcomes(ship, battle, result)
select ship, battle, result
from inserted i
join ships s on i.ship = s.name
join battels b on i.battle = b.name
where s.launched <= year(b.date)
end;

drop trigger t;

-- �)��� �� �������� ������� ������� � 
-- ���� ���� �� ��� �������� ��������� ��
-- ����������, ������ �������� �� ���� ��������;

create trigger t
on outcomes
after insert -- ���� � update ����� insert
as
	if exists (select *
				from inserted i
				join ships s on i.ship = s.name
				join battels b on i.battle = b.name
				where s.launched > year(b.date))
	begin
		raiserror('Error: ...',16,10);
		rollback
	end;
	
drop trigger t;

-- ���.6: �� �� ������� ������ �� ������
-- �������� ������ (��� �� ����� � �����),
-- ����� �� ��������� insert, update � delete.

create view SunkShips
as
select ship, battle
from outcomes
where result = 'sunk';

create trigger InsertSunkShip
on SunkShips
instead of insert
as
insert into outcomes (ship, battle, result)
select ship, battle, 'sunk'
from inserted;

drop trigger InsertSunkShip;

