SELECT DISTINCT p_name
FROM lineitem, part, (SELECT p_partkey as pKey, MAX(l_extendedprice*(1-l_discount)) as highVal
FROM lineitem, part
WHERE p_partkey = l_partkey AND
l_shipdate > '1994-10-02') as subQ
WHERE pKey = p_partkey 