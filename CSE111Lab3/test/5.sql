select c_mktsegment, MIN(c_acctbal) as MIN, MAX(c_acctbal) as MAX, AVG(c_acctbal) as AVG, SUM(c_acctbal) as SUM 
FROM customer
group by c_mktsegment;