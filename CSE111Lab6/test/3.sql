SELECT COUNT(A)
FROM(SELECT COUNT(ps_partkey) AS A
FROM supplier S, nation N, part P, partsupp S
WHERE S.s_nationkey=n.n_nationkey AND S.ps_suppkey=S.s_suppkey AND S.ps_partkey = P.p_partkey AND N.n_name="CANADA"
GROUP BY (ps_partkey) 
HAVING COUNT(ps_partkey) > 1);