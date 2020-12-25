SELECT COUNT(A)
FROM(SELECT COUNT(DISTINCT o_orderkey) AS A
FROM orders O, customer C
WHERE O.o_custkey = C.c_custkey AND O.o_orderdate LIKE "1996-08-%"
GROUP BY (c_custkey)
HAVING COUNT(o_orderkey) <= 2);
