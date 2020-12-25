SELECT o_orderpriority, COUNT(DISTINCT o_orderkey)
FROM lineitem L, orders O
WHERE (O.o_orderdate LIKE "1996-12-__" OR O.o_orderdate LIKE "1996-11-__" OR O.o_orderdate LIKE "1996-10-__") AND L.l_receiptdate > l_commitdate AND O.o_orderkey = L.l_orderkey
GROUP BY o_orderpriority;