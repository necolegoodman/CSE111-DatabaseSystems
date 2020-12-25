SELECT r_name, COUNT(DISTINCT c_custkey)
FROM customer C, orders O, region R, nation N
WHERE C.c_nationkey = N.n_nationkey  AND N.n_regionkey = R.r_regionkey  
AND c_acctbal > (SELECT AVG(c_acctbal) 
FROM customer C) AND c_custkey NOT IN (SELECT o_custkey
FROM orders K , customer E WHERE K.o_custkey = E.c_custkey)
GROUP BY r_name;