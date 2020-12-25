SELECT DISTINCT strftime('%m',l_shipdate), SUM(l_quantity)
FROM lineitem L
WHERE substr (L.l_shipdate, 1, 4) = "1997"
GROUP BY strftime('%m',l_shipdate)