SELECT COUNT(DISTINCT s_suppkey) 
FROM supplier S, partsupp T, part P  
WHERE p_type LIKE '%MEDIUM POLISHED%'
AND S.s_suppkey = T.ps_suppkey AND T.ps_partkey=P.p_partkey AND p_size IN (23,36,3,49);