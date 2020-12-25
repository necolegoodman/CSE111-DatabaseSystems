SELECT COUNT(DISTINCT  c_custkey)
FROM customer C, region R, nation N
WHERE R.r_regionkey=N.n_regionkey AND C.c_nationkey=N.n_nationkey AND R.r_name<>"AFRICA" AND R.r_name<>"EUROPE";