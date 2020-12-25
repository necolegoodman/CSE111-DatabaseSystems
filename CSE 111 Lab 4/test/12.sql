SELECT DISTINCT n_name, AVG(s_acctbal)
FROM nation, supplier
WHERE s_nationkey = n_nationkey
    GROUP BY n_name
