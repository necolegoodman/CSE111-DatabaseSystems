SELECT s_name, COUNT (DISTINCT p_partkey)
from supplier, part, nation, partsupp
where  
    s_nationkey = n_nationkey AND
      p_partkey = ps_partkey AND 
      ps_suppkey = s_suppkey AND
      n_name = 'CHINA' AND
      p_size < 30 
    group by s_name;
