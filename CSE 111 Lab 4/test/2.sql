select n_name, COUNT(DISTINCT s_name)
from supplier,nation
WHERE s_nationkey = n_nationkey
GROUP BY n_name;