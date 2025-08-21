-- Упражнение - 27.05.2011г.
--			Тригери 

use ships;
-- зад.1: При изтриване на кораб автоматично да се 
-- изтрива и неговия клас, ако няма повече кораби от този клас. 

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

-- Забележка: ако не използваме deleted,
-- а направо ships, щяхме да изтием и
-- класовете, които са били празни и преди
-- съответния delete;

select * from ships;
select * from classes;
insert into classes values('Test','bb','BG',10,10,10000);
insert into ships values('Test','Test',2);
delete from ships where name= 'Test';
drop trigger DeleteEmptyClasses;

-- зад.2: Да се направи така, че при добавяне
-- на нов клас автоматично да се добавя и
-- нов кораб със същото име и с година на
-- пускане на вода = null.

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

-- зад.3: Да се направи така, че ако при
-- добавяне или обновяване на кораб
-- годината му на пускане е по-голяма от
-- текущата година, то годината му да бъде
-- променена на null.

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
-- зад.4: При промяна на черно-бял филм на 
-- цветен съответният продуцент да получава
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

-- зад.5: Да не се допуска довянето на кортеж
-- в OUTCOMES, който да указва, че даден
-- кораб е участвал в битка, преди да бъде
-- пуснат на вода.

-- а) ако се добавят няколко кортежа,
-- невалидните да бъдат игнорирани, а само
-- корректните да бъдат вмъкнати в OUTCOMES;

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

-- б)ако се даобавят няколко кортежа и 
-- поне един от тях нарушава условието за
-- коректност, цялата операция да бъде отменена;

create trigger t
on outcomes
after insert -- може и update освен insert
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

-- зад.6: Да се създаде изглед за всички
-- потънали кораби (име на кораб и битка),
-- който да позволява insert, update и delete.

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

