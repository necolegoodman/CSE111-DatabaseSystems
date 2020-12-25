SELECT DISTINCT p_type, AVG(l_discount)
FROM part, lineitem
WHERE substr(p_type, 1,5) = 'PROMO' and p_partkey = l_partkey
GROUP BY p_type
