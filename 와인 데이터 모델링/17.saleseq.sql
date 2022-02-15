alter table sale add s_seq number(38);
INSERT INTO sale (sale_code,mem_id,wine_code,sale_amount,sale_price,sale_tot_price,s_seq) 
VALUES ('sale11','mem0001','w01',9,90000,900000,sale_seq.nextval);
INSERT INTO sale (sale_code,mem_id,wine_code,sale_amount,sale_price,sale_tot_price,s_seq) 
VALUES ('sale12','mem0001','w01',9,90000,900000,sale_seq.nextval);