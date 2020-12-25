--1. What makers produce Printers?
SELECT Product.maker
FROM Product, Printer
WHERE Product.model = Printer.model; --correct

--2. What makers produce color Printers cheaper than $200?
SELECT Product.maker
FROM Product, Printer
WHERE Product.model = Printer.model AND price < 200; --correct

--3.What makers produce PCs, Laptops, and Printers?
SELECT DISTINCT maker FROM
(SELECT DISTINCT maker
FROM Product 
WHERE type = 'pc'
UNION ALL 

SELECT DISTINCT maker
FROM Product
WHERE type = 'laptop'
UNION ALL 

SELECT DISTINCT maker 
FROM Product
WHERE type = 'printer');

--4.What makers produce PCs and Printers but do not produce Laptops?
SELECT Product.maker 
FROM Product 
WHERE model NOT IN (SELECT model FROM Laptop); -- maybe correct

--5. For every maker that sells both PCs and Laptops, 
--find the combination of PC and Laptop that has minimum price.  
--Print the maker, the PC model, Laptop model, and the combination 
--price (PC price+ Laptop price).


--6.What is the average price of a Printer?
SELECT AVG (price)
FROM Printer;
--correct

--7.How many models of each different type of Printers are offered?
SELECT COUNT(model)
FROM Printer
GROUP BY type; --Correct!

--8.How many models of laser color Printers are available?
SELECT COUNT(model)
FROM Printer
WHERE type = 'laser'; --Correct! 

--9.How many makers produce at least 2 different types (not models) of Printers?
SELECT COUNT(DISTINCT maker)
FROM printer, Product
WHERE Product.model = Printer.model 
GROUP BY maker HAVING COUNT(DISTINCT Printer.type) >=2; --Correct

--10.For every Laptop screen size, find the minimum price of Laptops having 
--that screen size.
SELECT MIN(price)
FROM Laptop
GROUP BY screen; --Correct

--11.What Laptop screen sizes are offered in at least 3 different models?
SELECT screen
FROM Laptop 
GROUP BY screen HAVING COUNT(DISTINCT model) >=3; --Correct

--12.What Laptop screen sizes are offered with at least 2 different speeds?
SELECT screen 
FROM Laptop
GROUP BY screen HAVING COUNT(DISTINCT speed) >=2; --correct

--13.What Laptops are more expensive than any PC? Print the model 
--and the price.
SELECT model, price
FROM Laptop
WHERE price <(SELECT MAX(price) FROM PC); --not sure how to check 

--14.What Printers produced by the maker of the most expensive PC that also produces 
--Printers are the cheapest?  Print the model and the price.
SELECT Product.maker
FROM Product
WHERE model IN(SELECT model FROM (SELECT model, MAX(price) FROM PC))
INTERSECT

SELECT Product.maker
FROM Product
WHERE model IN(SELECT model FROM(SELECT model, MIN(price) FROM printer));

--15.Find the average price for each product category (PC, Laptop, 
--Printer) for every maker having products in all the categories.
SELECT AVG(price)
FROM PC, Laptop Printer;


--16.What makers produce exactly a single Laptop model?
SELECT Product.maker
FROM Product, Laptop
WHERE Product.model = Laptop.model 
GROUP BY Product.maker HAVING COUNT (Laptop.model) = 1;

--17.What makers do not produce any Laptop model?
SELECT maker
FROM Product, PC
WHERE Product.model = PC.model
UNION

SELECT maker
FROM Product, Printer 
WHERE Product.model = Printer.model
EXCEPT

SELECT maker
FROM Laptop, Product
WHERE Laptop.model = Product.model;

--18.What makers produce a single Laptop model and exactly 3 PC models?
SELECT Product.maker
FROM Product, Laptop 
WHERE Product.model = Laptop.model 
GROUP BY Product.maker 
HAVING COUNT(Laptop.model) = 1
INTERSECT 

SELECT Product.maker
FROM PC, Product
WHERE Product.model = PC.model
GROUP BY maker
HAVING COUNT(PC.model) = 3;

--19.What makers produce at least a PC or Laptop model and at 
--most 3 Printer models?
SELECT Product.maker
FROM Product, Laptop
WHERE Product.model = Laptop.model
GROUP BY Product.maker
HAVING COUNT(Laptop.model) >= 1
UNION

SELECT Product.maker
FROM Product, PC
WHERE Product.model = PC.model
GROUP BY Product.maker
HAVING COUNT(PC.model) >= 1
INTERSECT

SELECT maker
FROM Product, Printer
WHERE Product.model = Printer.model
GROUP BY maker
HAVING COUNT(Printer.model) <= 3;


--20.List the Laptops with screen size 15 or larger and speed less than 
--2 made by a maker that also makes printers.  Print the laptop model, 
--the screen, the speed, and the maker;
SELECT Laptop.model, Laptop.screen, Laptop.speed, maker
FROM Laptop, Product,

(SELECT maker as printerMaker
FROM Product, Printer
WHERE Product.model = Printer.model
GROUP BY maker) as Nec1
WHERE Product.model = Laptop.model AND printerMaker = maker
GROUP BY Laptop.model
HAVING screen >= 15 AND speed < 2;