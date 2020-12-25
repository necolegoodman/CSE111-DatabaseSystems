CREATE TRIGGER t3 after update on customer
begin
    update customer
    set c_comment = 'Positive balance'
    where c_custkey = new.c_custkey
        AND new.c_acctbal > 0
        AND old.c_acctbal < 0;
end;

UPDATE customer
SET c_comment = 'Positive Balance. You are good to go';

select *
from customer, nation
where c_nationkey = n_nationkey 
and n_name = 'EUROPE' 
and c_acctbal < 0;

UPDATE customer
SET c_acctbal = 100
WHERE c_nationkey IN (select n_nationkey 
                        from nation 
                        where n_name = 'ROMANIA');

SELECT count(c_name)
from customer, nation, region
where c_nationkey = n_nationkey
and n_regionkey = r_regionkey 
and r_name = 'EUROPE' 
and c_acctbal < 0;
