SELECT SUM(ps_supplycost)
FROM partsupp, part, lineitem, supplier
WHERE p_retailprice <1000 AND
l_suppkey = s_suppkey AND
ps_partkey = p_partkey AND 
s_suppkey = ps_suppkey AND
l_partkey = p_partkey AND
substr(l_shipdate,1,4) = '1996' AND
s_suppkey NOT IN (SELECT l_suppkey
FROM lineitem
WHERE l_extendedprice < 2000 AND 
substr(l_shipdate,1,4) = '1995')