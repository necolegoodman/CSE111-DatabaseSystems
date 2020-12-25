--PRAGMA foreign_keys = ON;

--DROP TABLE Classes;
--DROP TABLE Ships; 
--DROP TABLE Battles;
--DROP TABLE Outcomes;

CREATE TABLE Classes(
    class VARCHAR(15) PRIMARY KEY,
    type CHAR(2),
    country VARCHAR(15), 
    numGuns DECIMAL(2,0),
    bore DECIMAL(2,0), 
    displacement DECIMAL(6,0),
    CHECK((type = 'bb') OR (type = 'bc'))
);

CREATE TABLE Ships (
    name VARCHAR(15) PRIMARY KEY,
    class VARCHAR(15) NOT NULL REFERENCES classes(class) 
    ON DELETE CASCADE ON UPDATE CASCADE,
    launched DECIMAL(4,0) NOT NULL
);

CREATE TABLE Battles(
    name VARCHAR(15) NOT NULL,
    date date
);

CREATE table Outcomes (
    ship VARCHAR(15) REFERENCES ships(name)
    ON DELETE SET NULL,
    battle VARCHAR(15) REFERENCES battles(name)
    ON DELETE CASCADE ON UPDATE CASCADE,
    result VARCHAR(15),
    CHECK((result = 'ok') OR (result = 'sunk') OR 
    (result = 'damaged'))
);
--1
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

--2. Delete all the Classes with a displacement larger than 50,000 or with numGuns larger than 10. 
    DELETE FROM classes 
    WHERE displacement > 50000 
    OR numGuns >10;

--3. For every Ship from USA that has class different than the name of the Ship, create a Class tuple that 
-- has class equal to the Ship name. The other attributes in Classes keep the same value as in the current 
-- class of the Ship. Update the class of every Ship for which a new Class is created to the new Class. 


--4.Delete “North Cape” from Battles.
    DELETE FROM battles
    WHERE name = 'North Cape';

--5.Update the “Guadalcanal” battle to “North Cape” in Outcomes.
    UPDATE outcomes
    SET battle = 'North Cape'
    WHERE battle = 'Guadalcanal';

--6. Rename “Surigao Strait” to “Strait of Surigao” in Battles. 
    UPDATE battles
    SET name = 'Strait of Surigao'
    WHERE name = 'Surigao Strait';

--7. Delete all the Ships that belong to Classes having more than 4 Ships. 
    DELETE FROM ships
    WHERE class IN 
    (SELECT class
    FROM ships
    GROUP BY class
    HAVING COUNT(class) > 4);

--8. Print all the tuples in Ships.
    SELECT *
    FROM ships;

--9. Print all the tuples in Outcomes. 
    SELECT *
    FROM outcomes;
