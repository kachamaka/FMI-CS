use ships;
--1
create view BritishShips
as
select s.name, s.class, c.type, c.numGuns, c.bore, c.displacement, s.launched
from ships s 
join classes c on s.class = c.class
where c.country = 'Gt.Britain';

--2
select numGuns, displacement
from BritishShips
where launched < 1919;

--3
select c.numGuns, c.displacement
from ships s 
join classes c on s.class = c.class
where c.country = 'Gt.Britain' and s.launched < 1919;

--4
select avg(displacement) from
(select max(c.displacement) displacement
from classes c
join ships s on c.class = s.class
group by c.country) allClasses;

select * from CLASSES

--5
create view SunkShips
as
select s.name, o.battle
from ships s
join outcomes o on s.name = o.ship
where o.result = 'sunk';

select * from SunkShips
select * from a

create view a
as
select ship, BATTLE
from OUTCOMES
where RESULT = 'sunk'	
