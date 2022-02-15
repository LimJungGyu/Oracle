create or replace view o_m_p_view
as
select o.o_seq, m.name, o.id, o.product_code, p.product_name, product_size, o.quantity, m.zipcode,m.address, m.tel, o.indate 
from orders o, member m, products p 
where o.id = m.id and o.product_code = p.product_code;