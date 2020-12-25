SELECT n_name, count(DISTINCT o_orderkey)
FROM nation,customer, orders, lineitem
WHERE 
    c_custkey = o_custkey AND
    l_orderkey = o_orderkey AND
      c_nationkey = n_nationkey AND
      n_regionkey = 2
    group by n_name;
