
SELECT COUNT(DISTINCT o_orderkey)
FROM supplier, customer, lineitem, orders
WHERE
    o_orderkey = l_orderkey AND 
    l_suppkey = s_suppkey AND 
    o_custkey = c_custkey AND 
    c_acctbal < 0 AND
    s_acctbal < '0'
