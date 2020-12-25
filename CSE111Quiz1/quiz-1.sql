

CREATE TABLE CLASSES(
    class varchar(15) not null,
    type char(2) not null,
    country varchar(15) not null, 
    numGuns decimal(2,0) not null,
    bore decimal(2,0) not null, 
    displacement decimal (6,0) not null
);

CREATE TABLE ships (
    name varchar(15) not null,
    class varchar(15) not NULL,
    launched decimal(4,0) not null
);

create TABLE battles(
    name varchar(15) not null,
    date date
);

create table outcomes (
    ship varchar(15) not null,
    battle varchar (15) not null,
    result varchar(15) not null
);
SELECT *
FROM CLASSES;
INSERT INTO CLASSES VALUES('Bismarck', 'bb', 'Germany', 8, 15, 42000);
INSERT INTO CLASSES VALUES('Iowa', 'bb', 'USA', 9, 16, 46000);
INSERT INTO CLASSES VALUES('Kongo', 'bc', 'Japan', 8, 14, 32000);
INSERT INTO CLASSES VALUES('North Carolina', 'bb', 'USA', 9, 16, 37000);
INSERT INTO CLASSES VALUES('Renown', 'bc', 'Britain', 6, 15, 32000);
INSERT INTO CLASSES VALUES('Revenge', 'bb', 'Britain', 8, 15, 29000);
INSERT INTO CLASSES VALUES('Tennessee', 'bb', 'USA', 12, 14, 32000);
INSERT INTO CLASSES VALUES('Yamato', 'bb', 'Japan', 9, 18, 65000);

SELECT *
FROM SHIPS;
INSERT INTO SHIPS VALUES('California' ,'Tenenessee', 1915);
INSERT INTO SHIPS VALUES('Haruna' ,'Kongo', 1915);
INSERT INTO SHIPS VALUES('Hiei' , 'Kongo',1915);
INSERT INTO SHIPS VALUES('Iowa' ,'Iowa',1933);
INSERT INTO SHIPS VALUES('Kirishima' ,'Kongo',1915);
INSERT INTO SHIPS VALUES('Kongo' ,'Kongo',1913);
INSERT INTO SHIPS VALUES('Missouri' ,'Iowa',1935);
INSERT INTO SHIPS VALUES('Musahi' ,'Yamato',1942);
INSERT INTO SHIPS VALUES('New Jersey','Iowa',1936);
INSERT INTO SHIPS VALUES('North Carolina' ,'North Carolina',1941);
INSERT INTO SHIPS VALUES('Ramillies' ,'Revenge',1917);
INSERT INTO SHIPS VALUES('Renown' ,'Renown',1916);
INSERT INTO SHIPS VALUES('Repulse' ,'Renown',1916);
INSERT INTO SHIPS VALUES('Resolution' ,'Revenge',1916);
INSERT INTO SHIPS VALUES('Revenge' ,'Revenge',1916);
INSERT INTO SHIPS VALUES('Royal Oak' ,'Revenge',1916);
INSERT INTO SHIPS VALUES('Royal Sovereign' ,'Revenge',1916);
INSERT INTO SHIPS VALUES('Tennessee' ,'Tennessee',1915);
INSERT INTO SHIPS VALUES('Washington' ,'North Carolina',1941);
INSERT INTO SHIPS VALUES('Wisconsin' ,'Iowa',1940);
INSERT INTO SHIPS VALUES('Yamato' ,'Yamato',1941);

SELECT *
FROM BATTLES;
INSERT INTO BATTLES VALUES('Denmark Strait' ,1941-05-24);
INSERT INTO BATTLES VALUES('Guadalcanal',1942-11-15);
INSERT INTO BATTLES VALUES('North Cape' ,1943-12-26);
INSERT INTO BATTLES VALUES('Surigao Strait' ,1944-10-25);

SELECT *
FROM OUTCOMES;
INSERT INTO OUTCOMES VALUES('California','Surigao Strait','ok');
INSERT INTO OUTCOMES VALUES('Kirishima','Guadalcanal','sunk');
INSERT INTO OUTCOMES VALUES('Resolution','Denamark Strait','ok');
INSERT INTO OUTCOMES VALUES('Wisconsin','Guadalcanal','damaged');
INSERT INTO OUTCOMES VALUES('Tennessee','Surigao Strait','ok');
INSERT INTO OUTCOMES VALUES('Washington','Guadalcanal','ok');
INSERT INTO OUTCOMES VALUES('New Jersey','Surigao Strait','ok');
INSERT INTO OUTCOMES VALUES('Yamato','Surigao Strait','sunk');
INSERT INTO OUTCOMES VALUES('Wisconsin','Surigao Strait','damaged');

SELECT class, country /* #1 */
From classes
where bore >=15;

select name /* #2 */
from ships 
where launched < 1918;

select ship /* #3 */
from outcomes 
where result = 'sunk' and battle = 'Surigao Strait';

select NAME/* #4 */
from ships
where launched > 1921
intersect 
select class 
from classes 
where displacement  > 40000;



select ship, displacement, numGuns /*#5 */
from outcomes, CLASSES
where ship = class and battle = 'Surigao Strait';

select class /*#6 */
from CLASSES
union 
select name 
from ships 
union select ship 
from outcomes;

select class /*#7 */
from ships
group by class 
having count(distinct name) = 2;

select country /*#8 */
from classes
where type = 'bb'
intersect 
select country 
from classes
where type = 'bc';

select ship /*#9 */
from outcomes
where results = 'damaged'
INTERSECT
select ships 
from outcomes
where result = 'damaged';