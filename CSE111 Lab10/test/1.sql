CREATE TRIGGER t1 before insert on orders
begin
    update orders
    set o_orderdate = '2020-12-01'
    where o_orderkey = new.o_orderkey;
end;

select COUNT(o_orderkey)
FROM orders
WHERE o_orderdate >= '2020-01-01'
AND o_orderdate <= '2020-12-31';