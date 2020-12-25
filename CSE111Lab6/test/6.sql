SELECT s_name, c_name
FROM customer C, supplier S, lineitem L, orders O
WHERE S.s_suppkey = L.l_suppkey AND L.l_orderkey = O.o_orderkey AND O.o_custkey = C.c_custkey AND
O.o_totalprice= (SELECT MAX(o_totalprice) FROM orders WHERE o_orderstatus = "F");