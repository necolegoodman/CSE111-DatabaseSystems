SELECT COUNT(DISTINCT l_suppkey) 
FROM (SELECT l_suppkey, COUNT(DISTINCT o_orderkey) AS A1
FROM nation N, customer C, orders O, lineitem L
WHERE (N.n_name = "FRANCE" OR
N.n_name = "GERMANY") AND L.l_orderkey = O.o_orderkey AND N.n_nationkey = C.c_nationkey AND 
C.c_custkey = O.o_custkey GROUP BY (l_suppkey))
AS A2 WHERE (A2.A1 < 30);