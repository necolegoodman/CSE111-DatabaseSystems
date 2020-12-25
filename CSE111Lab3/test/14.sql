select count(o_orderpriority)
from nation natural join customer natural join orders
where n_nationkey = c_nationkey and c_custkey = o_custkey and n_name = 'FRANCE' and o_orderpriority = '1-URGENT' and o_orderdate >= '1994-01-01' and o_orderdate <= '1996-12-31'
