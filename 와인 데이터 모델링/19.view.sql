create or replace view m_s_view
as
select s.s_seq,m.mem_id,m.mem_grade,s.sale_amount,s.sale_price,m.mem_tel,m.mem_pt
from member m, sale s
where m.mem_id = s.mem_id;

select* from m_s_view;