SELECT o_orderpriority, COUNT(o_orderkey)  
FROM orders O, lineitem L
WHERE L.l_receiptdate > L.l_commitdate AND O.o_orderkey= L.l_orderkey AND O.o_orderdate LIKE "1996%" 
GROUP BY o_orderpriority
ORDER BY o_orderpriority DESC;
