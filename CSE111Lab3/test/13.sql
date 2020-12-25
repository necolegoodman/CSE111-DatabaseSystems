select avg(c_acctbal)
from customer natural join nation natural join region
where r_regionkey = n_regionkey and n_nationkey = c_nationkey and r_name = 'AFRICA' and c_mktsegment = 'MACHINERY'