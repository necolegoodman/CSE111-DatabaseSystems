SELECT COUNT(DISTINCT s_suppkey)
FROM nation N, part P, partsupp K , supplier S
WHERE s_nationkey = n_nationkey AND n_name = "CANADA" 
AND K.ps_suppkey = S.s_suppkey;