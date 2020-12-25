UPDATE customer
SET c_acctbal = -100
WHERE c_nationkey IN (SELECT n_nationkey
                      FROM nation,
                           region
                      WHERE n_regionkey = r_regionkey
                        AND r_regionkey = 3);

SELECT COUNT(c_custkey)
FROM customer, nation
WHERE
    c_nationkey = n_nationkey AND
    n_name = 'FRANCE' AND
    c_acctbal < 0