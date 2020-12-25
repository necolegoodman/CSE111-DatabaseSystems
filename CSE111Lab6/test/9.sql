SELECT DISTINCT p_name AS parts
FROM part,
    lineitem
WHERE l_orderkey IN (
SELECT o_orderkey
FROM region, nation, customer, orders
WHERE r_name = 'AMERICA' AND
r_regionkey = n_regionkey AND
 c_nationkey = n_nationkey AND
 c_custkey = o_custkey) AND
 p_partkey IN ( SELECT l_partkey
FROM region, nation, supplier, lineitem
 WHERE r_name = 'ASIA' AND
r_regionkey = n_regionkey AND
 n_nationkey = s_nationkey AND
 s_suppkey = l_suppkey
GROUP BY l_partkey
HAVING COUNT(DISTINCT l_suppkey) = 4) AND p_partkey = l_partkey
GROUP BY l_orderkey;