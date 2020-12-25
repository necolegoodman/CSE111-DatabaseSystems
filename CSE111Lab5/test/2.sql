SELECT r_name, COUNT(DISTINCT s_suppkey)
FROM supplier S, region R, nation N
WHERE S.s_acctbal > (SELECT AVG(s_acctbal) FROM nation A, supplier K
WHERE n_nationkey = s_nationkey AND r_regionkey = n_regionkey)
AND s_nationkey = n_nationkey AND n_regionkey = r_regionkey
GROUP BY r_name;