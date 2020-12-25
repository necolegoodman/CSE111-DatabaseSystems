SELECT AVG(julianday(l_shipdate) - julianday(l_commitdate))
FROM lineitem 
WHERE l_commitdate <= l_shipdate;