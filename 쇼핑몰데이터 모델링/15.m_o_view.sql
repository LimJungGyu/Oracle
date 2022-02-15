create or replace view o_m_view
as
select o.o_seq,m.name, o.id, o.product_code, o.product_size, o.quantity, m.zipcode,m.address, m.tel, o.indate 
from orders o, member m
where o.id = m.id;


