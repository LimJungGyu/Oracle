create or replace trigger library_tri
before insert
on due
for each row
begin
select library_seq.nextval into:new.library_seq from dual;
end;
/
