SELECT n_name, COUNT(DISTINCT c_custkey), COUNT(DISTINCT s_suppkey)
FROM customer C, supplier S, region R, nation N
WHERE R.r_regionkey=N.n_regionkey AND N.n_nationkey=C.c_nationkey AND S.s_nationkey=C.c_nationkey AND R.r_name="EUROPE"
GROUP BY n_name;