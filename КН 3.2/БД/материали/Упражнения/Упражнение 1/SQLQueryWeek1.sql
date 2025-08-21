use movies;

SELECT *
FROM MOVIE;

SELECT *
FROM MOVIE
WHERE studioName='Disney' AND year=1990;

SELECT studioName as Name, title
FROM MOVIE;

SELECT year-1900
FROM MOVIE;

-- Vsi34ki filmi, 4ieto ime zapo4va sas Star:
SELECT *
FROM MOVIE
WHERE TITLE LIKE 'Star %';

SELECT * FROM MovieStar
WHERE birthdate='1977-07-06';

SELECT *
FROM MOVIE
WHERE length IS NULL; -- ako napi6em length = NULL e gre6no!!! NULL otgovarq na uslovie samo na is NULL


-- vsi4ki filmi sortirani po daljina v namalqva6t red, a filmite s ednakva dylvina - po azbu4en red
SELECT *
FROM Movie
ORDER BY length DESC, title ASC;

--vsi4ki aktiori, sortirani po mesec na rajdane:
SELECT *
FROM MovieStar
ORDER BY month(birthdate);

SELECT name, month(birthdate) AS Month
FROM MovieStar
ORDER BY month(birthdate);

SELECT *
FROM Movie
WHERE year in (1977,1990,1995); --year=1977 or y=1990 or year=1955 

select *
from movies 
where year between 1970 and 1995; --year>=1970 and year<=1995

...where s like 'x%%x%' escape 'x'

-- Prosti zaqvki - zada4i 1

-- 1.1.
use movies;
select address
from studio
where name='MGM';

-- 1.3.
select starname
from starsin
where movieyear=1980 and movietitle like '%Empire%';

-- 1.4.
select name
from movieexec
where networth > 1000000;

-- 1.5.
select name
from moviestar
where gender='M' or address like '%Malibu%';

use pc;

-- 2.1.
select model, speed as MHz, hd as GB
from pc
where price<1200;

use ships;
-- 3.6.
select name
from ships
where name like '% %' and name not like '% % %';

use northwind;

-- 3.
select ProductName, UnitPrice * 0.9
from products;

-- 7.
select *
from orders
where orderdate between '1996-08-01' and '1996-09-01';

-- 10.
select FirstName + ' ' + LastName
from Employees;

-- SELECT DISTINCT >>> premahva povtoreniqta

-- 5.
select ContactTitle
from Customers
order by ContactTitle;

-- 6.
select distinct ContactTitle
from Customers
order by ContactTitle;

-- vsi4ki filmi 4iqto daljina e pod 2h 
-- vklu4itelno i tezi na koito daljinata ne e izvestna
use movies;
select * 
from movie
where length<120 or length is null;