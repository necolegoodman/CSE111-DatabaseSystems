SELECT substr(o_orderdate, 1, 4), r_name, COUNT(*) 
FROM orders, nation, supplier, region, lineitem 
WHERE s_suppkey = l_suppkey AND l_orderkey = o_orderkey AND s_nationkey = n_nationkey AND r_regionkey = n_regionkey AND o_orderpriority = '1-URGENT' 
GROUP BY substr(o_orderdate, 1, 4), r_name;