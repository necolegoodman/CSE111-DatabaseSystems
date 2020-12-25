SELECT MAX(L.l_discount)
FROM orders O, lineitem L
WHERE L.l_discount < (SELECT AVG(L1.l_discount) 
FROM lineitem L1) AND O.o_orderkey=L.l_orderkey AND O.o_orderdate LIKE '1995%';
