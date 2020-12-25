select *
FROM    (select c_custkey, COUNT(c_custkey) AS tree
    from (select l_discount, c_custkey
    from (select o_orderkey, c_custkey
    from (select c_custkey
    from customer
    ),
    Orders
    where o_custkey = c_custkey
    ), lineitem
    where l_orderkey= o_orderkey AND l_discount >= 0.05)
    group by c_custkey)
    where tree >=70
