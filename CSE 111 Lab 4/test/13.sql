SELECT COUNT(l_orderkey)
FROM region, supplier, nation, customer, orders, lineitem
WHERE
 n_regionkey = r_regionkey and 
 o_orderkey = l_orderkey and 
l_suppkey = s_suppkey AND
  c_custkey = o_custkey and   
s_nationkey = n_nationkey AND
    
    r_name = 'ASIA' AND
    c_nationkey = 1;
