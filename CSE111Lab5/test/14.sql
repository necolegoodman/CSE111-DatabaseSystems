SELECT R.r_name, R1.r_name, substr(l_shipdate,1,4),SUM((l_extendedprice * (1-l_discount)))
FROM  lineitem L, nation N, nation N1, supplier S, customer C, orders O, region R, region R1
WHERE (l_shipdate LIKE "1995%" OR l_shipdate LIKE "1996%") AND 
R.r_regionkey = N.n_regionkey  AND 
N1.n_nationkey = c_nationkey AND
R1.r_regionkey = N1.n_regionkey AND 
N.n_nationkey = s_nationkey AND  
O.o_orderkey = l_orderkey AND 
l_suppkey = s_suppkey
 AND C.c_custkey = O.o_custkey 
GROUP BY R.r_name, R1.r_name, substr(l_shipdate, 1, 4); 