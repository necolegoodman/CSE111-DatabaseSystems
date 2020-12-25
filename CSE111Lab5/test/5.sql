SELECT s_name, p_size, supplycost
FROM (SELECT DISTINCT s_name, p_size , MIN(ps_supplycost) AS supplycost
      FROM supplier, part, partsupp, nation
      WHERE p_type LIKE '%STEEL%' AND
            n_regionkey = 1 AND
            s_nationkey = n_nationkey AND
            s_suppkey = ps_suppkey AND
            ps_partkey = p_partkey
GROUP BY p_size);