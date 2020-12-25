CREATE TRIGGER t4_insert after insert on lineitem
begin
	update orders
	set o_orderpriority = 'HIGH'
	where o_orderkey = new.l_orderkey;
end;

CREATE TRIGGER t4_delete after delete on lineitem
begin
	update orders
	set o_orderpriority = 'HIGH'
	where o_orderkey = old.l_orderkey;
    end;

    update orders
set o_orderpriority = 'HIGH';

delete from lineitem
where l_orderkey in (select o_orderkey 
                    from orders 
                    where o_orderdate like '%1996-11%');

SELECT count(o_orderpriority)
from orders
where o_orderdate like '%1996-11%';
end;