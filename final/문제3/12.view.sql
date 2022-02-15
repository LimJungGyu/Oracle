create or replace view m_d_view
as
select d.library_seq,m.mem_id,m.mem_phone,d.book_title,d.due_num
from member m, due d
where m.mem_id = d.mem_id;

select* from m_d_view;