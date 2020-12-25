SELECT COUNT(DISTINCT s_suppkey)
FROM part P, partsupp U, supplier S
WHERE S.s_suppkey = U.ps_suppkey AND U.ps_partkey = P.p_partkey 
AND p_retailprice =(SELECT MIN(p_retailprice) FROM (part P));