select s_name, o_orderpriority, count(l_quantity)  
from lineitem, orders,supplier, nation, region
WHERE
 
s_suppkey = l_suppkey and 

o_orderkey = l_orderkey and 
s_nationkey = n_nationkey AND
n_regionkey = r_regionkey and 
r_name = 'AMERICA'
group by s_name, o_orderpriority;
