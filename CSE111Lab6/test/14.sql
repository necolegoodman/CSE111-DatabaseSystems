SELECT n_name, (num2 - num1)
FROM nation, (SELECT n_name nName1, COUNT(l_suppkey) as num1
 FROM supplier, lineitem, nation
 WHERE s_suppkey = l_suppkey AND
s_nationkey != n_nationkey AND
 substr(l_shipdate, 1,4) = '1996'
 GROUP BY n_name) as mainQ1,


 (SELECT n_name as nName2, COUNT(l_suppkey) as num2
 FROM customer, lineitem, nation, orders
 WHERE o_custkey = c_custkey AND
 o_orderkey = l_orderkey AND
c_nationkey != n_nationkey AND
substr(l_shipdate, 1,4) = '1996'
 GROUP BY n_name) as mainQ2

WHERE
    nName1 = nName2 AND
    nName1 = n_name 

UNION
SELECT n_name, (num2 - num1)
FROM nation, (SELECT n_name nName1, COUNT(l_suppkey) as num1
 FROM supplier, lineitem, nation
 WHERE
 s_suppkey = l_suppkey AND
s_nationkey != n_nationkey AND
substr(l_shipdate, 1,4) = '1996'
GROUP BY n_name) as mainQ1,

(SELECT n_name as nName2, COUNT(l_suppkey) as num2
 FROM customer, lineitem, nation, orders
 WHERE o_custkey = c_custkey AND
 o_orderkey = l_orderkey AND
c_nationkey != n_nationkey AND
 substr(l_shipdate, 1,4) = '1996'
GROUP BY n_name) as mainQ2

WHERE
    nName1 = nName2 AND
    nName1 = n_name and n_name = 'UNITED KINGDOM'
    GROUP BY (num2 - num1)
    ORDER BY (num2 - num1) DESC