SELECT(SELECT SUM(l_extendedprice*(1-l_discount)) 
       FROM lineitem, orders, customer, nation customerNation, region customerRegion, supplier, nation supplierNation 
       WHERE l_orderkey = o_orderkey AND
             o_custkey = c_custkey AND
             c_nationkey = customerNation.n_nationkey AND
             customerNation.n_regionkey = customerRegion.r_regionkey AND
             customerRegion.r_name = 'EUROPE' AND
             l_suppkey = s_suppkey AND
             s_nationkey = supplierNation.n_nationkey AND
             supplierNation.n_name = 'UNITED STATES' AND
             substr(l_shipdate,1,4) = '1996') /(SELECT SUM(l_extendedprice*(1-l_discount)) 
        FROM lineitem, orders, customer, nation customerNation, region customerRegion 
         WHERE l_orderkey = o_orderkey AND
             o_custkey = c_custkey AND
             c_nationkey = customerNation.n_nationkey AND
             customerNation.n_regionkey = customerRegion.r_regionkey AND
             customerRegion.r_name = 'EUROPE' AND
             substr(l_shipdate,1,4) = '1996') AS marketShare;