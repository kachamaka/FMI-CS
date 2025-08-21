
-- Да се добави информация за актрисата Nicole Kidman.
-- За нея знаем само, че е родена на 20-и юни 1967.

use movies;
insert into MOVIESTAR(NAME,GENDER,BIRTHDATE,ADDRESS) values ('Nicole Kidman','F','1967-06-20', null);
select * from MOVIESTAR;
delete from MOVIESTAR where NAME = 'Nicole Kidman';

-- Да се изтрият всички продуценти с печалба (networth) под 10 милиона.

select * from MOVIEEXEC;
insert into MOVIEEXEC(CERT#, NAME, ADDRESS,NETWORTH) values ('1','aaaa','aaaa', '10');
insert into MOVIEEXEC(CERT#, NAME, ADDRESS,NETWORTH) values ('2','bbbb','bbbb', '20');
insert into MOVIEEXEC(CERT#, NAME, ADDRESS,NETWORTH) values ('3','cccc','cccc', '30');

delete from MOVIEEXEC where NETWORTH < 50;

-- Да се изтрие информацията за всички филмови звезди, за които не се знае адреса.

select * from MOVIESTAR;
insert into MOVIESTAR(NAME,GENDER,BIRTHDATE) values ('aaaaaa','F','1967-06-20')
insert into MOVIESTAR(NAME,GENDER,BIRTHDATE,ADDRESS) values ('bbbbbb','F','1967-06-20', null)
insert into MOVIESTAR(NAME,GENDER,BIRTHDATE,ADDRESS) values ('cccccc','F','1967-06-20', null);

delete from MOVIESTAR where ADDRESS is null;

-- Използвайки две INSERT заявки, съхранете в базата данни факта,
-- че персонален компютър модел 1100 е направен от производителя C,
-- има процесор 2400 MHz, RAM 2048 MB, твърд диск 500 GB, 52x DVD
-- устройство и струва $299. Нека новият компютър има код 12.
-- Забележка: моделът и CD са от тип низ.
-- Упътване: самото вмъкване на данни е очевидно как ще стане,
-- помислете в какъв ред е по-логично да са двете заявки.

use pc;
select * from pc;
select * from product;
insert into product(maker, model, type) values ('C','1100','PC');
insert into pc(model,speed,ram,price,hd,code,cd) values ('1100', '2400','2048','299','500','12','52');

-- За всеки персонален компютър се продава и 15-инчов лаптоп със същите параметри,
-- но с $500 по-скъп. Кодът на такъв лаптоп е със 100 по-голям от кода на съответния
-- компютър. Добавете тази информация в базата.

insert into laptop(code,hd,model,price,ram,screen,speed)
select code+100, hd, model,price+500,ram,'15',speed 
from PC

-- Да се изтрие всичката налична информация за компютри модел 1100.

delete from product where model='1100' and type = 'PC' and maker = 'C';
delete from pc where model = '1100' and code='12';

-- Да се изтрият всички лаптопи, направени от производител,
-- който не произвежда принтери.
-- Упътване: Мислете си, че решавате задача от познат тип -
-- "Да се изведат всички лаптопи, ...". Накрая ще е нужна съвсем малка промяна.
-- Ако започнете директно да триете, много е вероятно при някой грешен опит
-- да изтриете всички лаптопи и ще трябва често да възстановявате таблицата
-- или да работите на сляпо.

select * -- за да ги изтрием вместо select * ще сложим delete
from laptop 
where model in (select model 
				from product
				where type = 'laptop' and maker not in (select maker 
													from product		
													where type = 'printer'));
						
-- Производител А купува производител B. На всички продукти на В променете производителя да бъде А.

UPDATE product SET maker = 'A' where maker = 'B'

Update product set maker = 'B' where model = '1121' and type='PC'
Update product set maker = 'B' where model = '1750' and type='Laptop'

select * from laptop

-- Да се намали два пъти цената на всеки компютър и да се добавят
-- по 20 GB към всеки твърд диск. Упътване: няма нужда от две отделни заявки.

select * from pc;
update pc set price= price/2, hd = hd +20;

-- За всеки лаптоп от производител 'B' добавете по един инч към диагонала на екрана.

update laptop set screen = screen+1
where model in (select model
				from product
				where maker = 'B' and type = 'laptop');
				
-- Два британски бойни кораба от класа Nelson - Nelson и Rory -
-- са били пуснати на вода едновременно през 1927 г.
-- Имали са девет 16-инчови оръдия (bore) и водоизместимост от
-- 34 000 тона (displacement). Добавете тези факти към базата от данни.

use ships;
insert into CLASSES(CLASS, NUMGUNS, BORE, DISPLACEMENT, TYPE, COUNTRY) values ('Nelson', '9','16','34000','bb','British');
insert into ships(NAME,CLASS,LAUNCHED) values ('Nelson', 'Nelson','1927')
insert into ships(NAME,CLASS,LAUNCHED) values ('Rory', 'Nelson','1927');

select * from ships

-- Изтрийте от Ships всички кораби, които са потънали в битка.

select * -- за да ги изтрием на ястото на select * ще сложим delete
from ships
where NAME in (select ship
				from OUTCOMES
				where RESULT = 'sunk');
				
-- Променете релацията Classes така, че калибърът (bore) 
-- да се измерва в сантиметри(в момента е в инчове, 1 инч ~ 2.5 см)
-- и водоизместимостта да се измерва в метрични тонове (1 м.т. = 1.1 т.)

select * from ships;
update CLASSES set BORE = BORE*2.5, DISPLACEMENT = DISPLACEMENT*1.1; 
	
-- Изтрийте всички класове, от които има по-малко от три кораба.

-- 1 начин
select CLASS 
from CLASSES c
where (select Count (NAME) 
		from ships s
		where c.CLASS = s.CLASS) < 3;
		
-- 2 начин		
select CLASS
from CLASSES c
where class not in (select class
					from ships
					group by class
					having count(*) >= 3)
				
-- Променете калибъра на оръдията и водоизместимостта на класа Iowa,
-- така че да са същите като тези на класа Bismarck.

update CLASSES set BORE = (select bore
							from CLASSES
							where CLASS = 'Bismarck'),
					DISPLACEMENT = (select DISPLACEMENT
									from CLASSES
									where CLASS = 'Bismarck')
			where CLASS = 'Iowa';
			
select * from CLASSES;								

-- Да се изведе името на актьора(актрисата), участвал(а) в най-много филми,
-- името и годината на най-дългия филм, в който актьорът(актрисата) има учстие,
-- и името на студиото, с което актьорът(актрисата) има най-много договори за
-- участие във филми на това студио.





