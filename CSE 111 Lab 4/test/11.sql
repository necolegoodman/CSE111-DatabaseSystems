SELECT DISTINCT n_name, s_name, MAX(s_acctbal)
FROM nation, supplier
WHERE s_nationkey = n_nationkey
    GROUP BY n_name
