 SELECT DISTINCT reg2.r_name, reg1.r_name, COUNT(o_orderkey)
FROM nation nat1, nation nat2, region reg1, region reg2,
     lineitem, orders, supplier, customer
WHERE
    l_suppkey = s_suppkey AND
    l_orderkey = o_orderkey AND
    o_custkey = c_custkey AND
    s_nationkey = nat1.n_nationkey AND
    nat1.n_regionkey = reg1.r_regionkey AND
    c_nationkey = nat2.n_nationkey AND 
    nat2.n_regionkey = reg2.r_regionkey
    group by reg2.r_name, reg1.r_name
