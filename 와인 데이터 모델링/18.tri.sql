create or replace trigger s_tri
before insert
on sale
for each row
begin
select sale_seq.nextval into:new.s_seq from dual;
end;
/
