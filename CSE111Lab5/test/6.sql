SELECT p_mfgr
FROM supplier S, partsupp T, part P
WHERE T.ps_suppkey=s_suppkey AND S.s_name="Supplier#000000053" AND P.p_partkey=T.ps_partkey AND T.ps_availqty=(SELECT MIN(ps_availqty) 
FROM supplier K , partsupp U WHERE K.s_name="Supplier#000000053" AND ps_suppkey=s_suppkey);