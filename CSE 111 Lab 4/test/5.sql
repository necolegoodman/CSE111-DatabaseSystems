select count(o_orderkey)
from nation,orders,customer
where o_orderdate BETWEEN '1996-01-01' AND 
        '1996-12-31' AND
      c_custkey = o_custkey AND
      c_nationkey = n_nationkey AND
      n_name = 'PERU';
