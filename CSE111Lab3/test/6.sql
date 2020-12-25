select distinct(n_name) as countries
from customer, nation, orders
WHERE 
c_custkey = o_custkey AND 
c_nationkey = n_nationkey AND
o_orderdate <= '1995-03-12' AND
o_orderdate >= '1995-03-10'
order by n_name;