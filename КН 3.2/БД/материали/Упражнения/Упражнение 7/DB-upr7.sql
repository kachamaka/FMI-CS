begin transaction 

use movies;
-- Да се добави информация за актрисата Nicole Kidman.
-- За нея знаем само, че е родена на 20-и юни 1967.

insert into moviestar(name,gender,birthdate)
values('nicole Kidman','F','1967-06-20');

-- Да се изтрият всички продуценти с печалба (networth) под 10 милиона.

delete from movieexec
where networth < 10000000;

-- Да се изтрие информацията за всички филмови звезди, за които не се знае адреса.

delete from moviestar
where address is null;

-- Използвайки две INSERT заявки, съхранете в базата данни факта,
-- че персонален компютър модел 1100 е направен от производителя C,
-- има процесор 2400 MHz, RAM 2048 MB, твърд диск 500 GB, 52x DVD
-- устройство и струва $299. Нека новият компютър има код 12.
-- Забележка: моделът и CD са от тип низ.
-- Упътване: самото вмъкване на данни е очевидно как ще стане,
-- помислете в какъв ред е по-логично да са двете заявки.

use pc;
insert into product(maker,model,type)
values('c','1100','PC')
insert into PC(code,model,speed,ram,hd,cd,price)
values(12,'1100',2400,2048,999,'52x',299)

-- За всеки персонален компютър се продава и 15-инчов лаптоп със същите параметри,
-- но с $500 по-скъп. Кодът на такъв лаптоп е със 100 по-голям от кода на съответния
-- компютър. Добавете тази информация в базата.

insert into laptop(code,model,speed,ram,hd,screen,price)
select code+100,model,speed,ram,hd,15,price + 500
from pc;

-- Да се изтрие всичката налична информация за компютри модел 1100.

delete from pc where model = '1100'
delete from product where model = '1100'

-- Да се изтрият всички лаптопи, направени от производител,
-- който не произвежда принтери.
-- Упътване: Мислете си, че решавате задача от познат тип -
-- "Да се изведат всички лаптопи, ...". Накрая ще е нужна съвсем малка промяна.
-- Ако започнете директно да триете, много е вероятно при някой грешен опит
-- да изтриете всички лаптопи и ще трябва често да възстановявате таблицата
-- или да работите на сляпо.

delete from laptop
where model in
		(select model
		from product
		where type = 'laptop'
			and maker not in
						(select maker
						from product
						where type = 'printer'))
						
-- Производител А купува производител B. На всички продукти на В променете производителя да бъде А.

update product
set maker = 'A'
where maker = 'B'

-- Да се намали два пъти цената на всеки компютър и да се добавят
-- по 20 GB към всеки твърд диск. Упътване: няма нужда от две отделни заявки.
--select *
--from pc

update pc
set price = price/2,hd = hd + 20

--select *
--from pc
-- За всеки лаптоп от производител 'B' добавете по един инч към диагонала на екрана.

update laptop
set screen = screen + 1
where model in (select model
				from product
				where maker ='B'
				and type = 'Laptop');
				
-- Два британски бойни кораба от класа Nelson - Nelson и Rodney -
-- са били пуснати на вода едновременно през 1927 г.
-- Имали са девет 16-инчови оръдия (bore) и водоизместимост от
-- 34 000 тона (displacement). Добавете тези факти към базата от данни.

use ships;

insert into classes
values('Nelson','bb','Gt.Britain',9,16,34000);
insert into ships
values('Nelson','Nelson',1927);
insert into ships
values('Rodney','Nelson',1927);

--select *
--from ships
-- Изтрийте от Ships всички кораби, които са потънали в битка.

delete from ships
where name in (select ship
				from outcomes
				where result = 'sunk');
				
-- Променете релацията Classes така, че калибърът (bore) 
-- да се измерва в сантиметри(в момента е в инчове, 1 инч ~ 2.5 см)
-- и водоизместимостта да се измерва в метрични тонове (1 м.т. = 1.1 т.)

update classes
set bore = bore * 2.5,
	displacement = displacement/1.1;
	
--select *
--from classes
-- Изтрийте всички класове, от които има по-малко от три кораба.

delete from classes
where class not in (select class
					from ships
					group by class
					having count(*) >= 3)
					
--2 вариант
delete from classes
where class in (select c.class
				from classes c
				left join ships s on c.class = s.class
				group by c.class
				having count(s.name) < 3);
		use ships		
-- Променете калибъра на оръдията и водоизместимостта на класа Iowa,
-- така че да са същите като тези на класа Bismarck.

update classes
set bore = (select bore
			from classes
			where class = 'Bismarck'),
	displacement = (select displacement
					from classes
					where class = 'Bismarck')
where class = 'Iowa'

rollback transaction

-- Да се изведе името на актьора(актрисата), участвал(а) в най-много филми,
-- името и годината на най-дългия филм, в който актьорът(актрисата) има учстие,
-- и името на студиото, с което актьорът(актрисата) има най-много договори за
-- участие във филми на това студио.

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

