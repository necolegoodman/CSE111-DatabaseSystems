select n_name, COUNT(DISTINCT l_orderkey)
from supplier, orders, region, lineitem, nation 
where
n_regionkey = r_regionkey and 
o_orderstatus = 'F' and 
l_suppkey = s_suppkey and 
s_nationkey = n_nationkey and 
o_orderkey = l_orderkey and 
o_orderdate BETWEEN '1994-01-00' and '1994-12-50'
group by n_name
having count(distinct l_orderkey) >300;

