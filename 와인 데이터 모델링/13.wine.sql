alter table wine modify(wine_url varchar2(1000));
INSERT INTO wine(wine_code,wine_name,wine_url,nation_code,wine_type_code,mem_grade,wine_price,wine_vintage,theme_code,todaywine_code)
 VALUES ('w01', 'Cabernet Sauvignon','C:\winepicture\w01.jpg','na01','r01','S',11000000,sysdate,'tm01','mon01');
INSERT INTO wine(wine_code,wine_name,wine_url,nation_code,wine_type_code,mem_grade,wine_price,wine_vintage,theme_code,todaywine_code)
 VALUES ('w02', 'Sangiovese','C:\winepicture\w02.jpg','na02','r02','A',100000,sysdate,'tm02','mon01');
INSERT INTO wine(wine_code,wine_name,wine_url,nation_code,wine_type_code,mem_grade,wine_price,wine_vintage,theme_code,todaywine_code)
 VALUES ('w03', 'Pinot Noir','C:\winepicture\w03.jpg','na03','r03','AA',110000,sysdate,'tm03','tue02');
INSERT INTO wine(wine_code,wine_name,wine_url,nation_code,wine_type_code,mem_grade,wine_price,wine_vintage,theme_code,todaywine_code)
 VALUES ('w04', 'Shiraz','C:\winepicture\w04.jpg','na04','r04','B',53000,sysdate,'tm04','tue02');
INSERT INTO wine(wine_code,wine_name,wine_url,nation_code,wine_type_code,mem_grade,wine_price,wine_vintage,theme_code,todaywine_code)
 VALUES ('w05', 'Merlot','C:\winepicture\w05.jpg','na05','r05','C',20000,sysdate,'tm05','wen03');
INSERT INTO wine(wine_code,wine_name,wine_url,nation_code,wine_type_code,mem_grade,wine_price,wine_vintage,theme_code,todaywine_code)
 VALUES ('w06', 'Chenin Blanc','C:\winepicture\w06.jpg','na06','w01','D',100000,sysdate,'tm06','thur04');
INSERT INTO wine(wine_code,wine_name,wine_url,nation_code,wine_type_code,mem_grade,wine_price,wine_vintage,theme_code,todaywine_code)
 VALUES ('w07', 'Pinot Gris','C:\winepicture\w07.jpg','na07','w02','A',100000,sysdate,'tm07','fri05');
INSERT INTO wine(wine_code,wine_name,wine_url,nation_code,wine_type_code,mem_grade,wine_price,wine_vintage,theme_code,todaywine_code)
 VALUES ('w08', 'Riesling','C:\winepicture\w08.jpg','na08','w03','AA',110000,sysdate,'tm01','sat06');
INSERT INTO wine(wine_code,wine_name,wine_url,nation_code,wine_type_code,mem_grade,wine_price,wine_vintage,theme_code,todaywine_code)
 VALUES ('w09', 'Sauvignon Blanc','C:\winepicture\w09.jpg','na09','w04','B',53000,sysdate,'tm02','sun07');
INSERT INTO wine(wine_code,wine_name,wine_url,nation_code,wine_type_code,mem_grade,wine_price,wine_vintage,theme_code,todaywine_code)
 VALUES ('w10', 'Chardonnay','C:\winepicture\w10.jpg','na10','w05','C',20000,sysdate,'tm03','sun07');

commit;