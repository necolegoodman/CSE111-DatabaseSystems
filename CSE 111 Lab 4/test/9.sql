SELECT COUNT(DISTINCT o_clerk)
FROM supplier, nation, orders,lineitem
WHERE 
    s_suppkey = l_suppkey AND
    l_orderkey = o_orderkey and
    s_nationkey = n_nationkey AND
    n_name = 'CANADA' 
    
