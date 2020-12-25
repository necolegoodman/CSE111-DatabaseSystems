select distinct l_receiptdate as DeliveryDate, count(l_linenumber) as Total
from customer natural join lineitem natural join orders
where c_custkey = o_custkey AND c_name = 'Customer#000000106' AND l_orderkey = o_orderkey
group by l_receiptdate