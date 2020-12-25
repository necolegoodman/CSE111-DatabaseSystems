SELECT c_name, SUM(o_totalprice)
FROM nation, orders, customer
WHERE 
    n_name = 'RUSSIA' AND
      o_orderdate BETWEEN '1996-01-01' AND
    '1996-12-31' AND
      c_custkey = o_custkey AND
      c_nationkey = n_nationkey
      GROUP BY c_name;
