alter table due add library_seq number(38);
INSERT INTO due (due_num, mem_id, book_title, book_num, DUE_DATE,library_seq) 
VALUES (006,'one','one',1,sysdate,library_seq.nextval);
alter table due add library_seq number(38);
INSERT INTO due (due_num, mem_id, book_title, book_num, DUE_DATE,library_seq) 
VALUES (007,'one','one',1,sysdate,library_seq.nextval);

