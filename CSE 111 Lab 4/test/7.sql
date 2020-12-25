select n_name, o_orderstatus, count(o_orderkey)
from customer, orders, nation, region
WHERE
o_custkey = c_custkey and 
c_nationkey = n_nationkey and 
n_regionkey = r_regionkey and 
r_name = 'EUROPE'
group by n_name, o_orderstatus
