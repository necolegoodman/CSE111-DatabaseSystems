/*select *
from (select count(o_orderstatus) as Success, r_name as S
from region, nation, customer, orders
where r_regionkey = n_regionkey and n_nationkey = c_nationkey and c_custkey = o_custkey and o_orderstatus = "F"
group by r_name, (select count(o_orderstatus) as Total, r_name as T
from region, nation, customer, orders
where r_regionkey = n_regionkey and n_nationkey = c_nationkey and c_custkey = o_custkey
group by (r_name)*/

Select region.r_name as region, COUNT(orders.o_orderstatus)
from region, orders, customer, nation
WHERE orders.o_custkey = customer.c_custkey AND customer.c_nationkey=nation.n_nationkey AND
nation.n_regionkey = region.r_regionkey AND orders.o_orderstatus = 'F'

Group by region.r_name;