SELECT COUNT(DISTINCT c_custkey) FROM orders O, customer C
WHERE O.o_custkey = C.c_custkey AND O.o_orderkey NOT IN
(SELECT DISTINCT o_orderkey FROM nation, supplier, orders, region, lineitem
WHERE n_regionkey = r_regionkey AND s_nationkey = n_nationkey AND 
s_suppkey = l_suppkey AND l_orderkey = o_orderkey AND r_name NOT IN ("ASIA"));