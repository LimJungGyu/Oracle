column o_seq format 999
column name format a10
column id format a5
column product_code format a10
column product_name format a15
column product_size format a5
column address format a50

select *
from orders o, member m, products p
where o.id = m.id
and o.product_code = p.product_code;