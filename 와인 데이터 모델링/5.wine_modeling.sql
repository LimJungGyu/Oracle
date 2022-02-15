
CREATE TABLE grade_pt_rade
(
	mem_grade             VARCHAR2(20)  NOT NULL ,
	grade_pt_rate         NUMBER(3,2)  NULL 
);



CREATE UNIQUE INDEX XPK등급별_마일리지율 ON grade_pt_rade
(mem_grade  ASC);



ALTER TABLE grade_pt_rade
	ADD CONSTRAINT  XPK등급별_마일리지율 PRIMARY KEY (mem_grade);



CREATE TABLE manager
(
	manager_id            VARCHAR2(30)  NOT NULL ,
	manager_pwd           VARCHAR2(20)  NOT NULL ,
	manager_tel           VARCHAR2(20)  NULL 
);



CREATE UNIQUE INDEX XPK관리자 ON manager
(manager_id  ASC);



ALTER TABLE manager
	ADD CONSTRAINT  XPK관리자 PRIMARY KEY (manager_id);



CREATE TABLE member
(
	mem_id                VARCHAR2(30)  NOT NULL ,
	mem_grade             VARCHAR2(20)  NULL ,
	mem_pw                VARCHAR2(20)  NOT NULL ,
	mem_birth             DATE   DEFAULT  sysdate NOT NULL ,
	mem_tel               VARCHAR2(20)  NULL ,
	mem_pt                NUMBER(10)  NOT NULL 
);



CREATE UNIQUE INDEX XPK회원 ON member
(mem_id  ASC);



ALTER TABLE member
	ADD CONSTRAINT  XPK회원 PRIMARY KEY (mem_id);



CREATE TABLE nation
(
	nation_code           VARCHAR2(6)  NOT NULL ,
	nation_name           VARCHAR2(100)  NOT NULL 
);



CREATE UNIQUE INDEX XPK_국가 ON nation
(nation_code  ASC);



ALTER TABLE nation
	ADD CONSTRAINT  XPK_국가 PRIMARY KEY (nation_code);



CREATE TABLE sale
(
	wine_code             VARCHAR2(6)  NOT NULL ,
	mem_id                VARCHAR2(30)  NOT NULL ,
	sale_code             VARCHAR2(20)  NOT NULL ,
	sale_amount           NUMBER(5)  NOT NULL ,
	sale_price            NUMBER(6)  NOT NULL ,
	sale_tot_price        NUMBER(15)  NOT NULL 
);



CREATE UNIQUE INDEX XPK판매 ON sale
(sale_code  ASC);



ALTER TABLE sale
	ADD CONSTRAINT  XPK판매 PRIMARY KEY (sale_code);



CREATE TABLE stock_management
(
	manager_id            VARCHAR2(30)  NULL ,
	wine_code             VARCHAR2(6)  NULL ,
	stock_code            VARCHAR2(6)  NOT NULL ,
	ware_date             DATE   DEFAULT  sysdate NULL ,
	stock_amount          NUMBER(5)  NULL 
);



CREATE UNIQUE INDEX XPK재고관리 ON stock_management
(stock_code  ASC);



ALTER TABLE stock_management
	ADD CONSTRAINT  XPK재고관리 PRIMARY KEY (stock_code);



CREATE TABLE theme
(
	theme_code            VARCHAR2(6)  NOT NULL ,
	theme_name            VARCHAR2(50)  NOT NULL 
);



CREATE UNIQUE INDEX XPK테마 ON theme
(theme_code  ASC);



ALTER TABLE theme
	ADD CONSTRAINT  XPK테마 PRIMARY KEY (theme_code);



CREATE TABLE today
(
	todaywine_code        VARCHAR2(6)  NOT NULL ,
	today_sens_value      NUMBER(3)  NULL ,
	today_intell_value    NUMBER(3)  NULL ,
	today_phy_value       NUMBER(3)  NULL 
);



CREATE UNIQUE INDEX XPK오늘의_와인 ON today
(todaywine_code  ASC);



ALTER TABLE today
	ADD CONSTRAINT  XPK오늘의_와인 PRIMARY KEY (todaywine_code);



CREATE TABLE wine
(
	todaywine_code        VARCHAR2(6)  NULL ,
	mem_grade             VARCHAR2(20)  NULL ,
	wine_type_code        VARCHAR2(6)  NULL ,
	theme_code            VARCHAR2(6)  NULL ,
	nation_code           VARCHAR2(6)  NULL ,
	wine_code             VARCHAR2(6)  NOT NULL ,
	wine_name             VARCHAR2(100)  NOT NULL ,
	wine_url              VARCHAR2(50)  NULL ,
	wine_price            NUMBER(15)  NOT NULL ,
	wine_vintage          DATE  NULL 
);



CREATE UNIQUE INDEX XPK와인 ON wine
(wine_code  ASC);



ALTER TABLE wine
	ADD CONSTRAINT  XPK와인 PRIMARY KEY (wine_code);



CREATE TABLE wine_type
(
	wine_type_code        VARCHAR2(6)  NOT NULL ,
	wine_type_name        VARCHAR2(50)  NULL 
);



CREATE UNIQUE INDEX XPK와인종류 ON wine_type
(wine_type_code  ASC);



ALTER TABLE wine_type
	ADD CONSTRAINT  XPK와인종류 PRIMARY KEY (wine_type_code);



ALTER TABLE sale
	ADD (CONSTRAINT  R_8 FOREIGN KEY (wine_code) REFERENCES wine(wine_code) ON DELETE SET NULL);



ALTER TABLE sale
	ADD (CONSTRAINT  R_10 FOREIGN KEY (mem_id) REFERENCES member(mem_id) ON DELETE SET NULL);



ALTER TABLE stock_management
	ADD (CONSTRAINT  R_7 FOREIGN KEY (manager_id) REFERENCES manager(manager_id) ON DELETE SET NULL);



ALTER TABLE stock_management
	ADD (CONSTRAINT  R_12 FOREIGN KEY (wine_code) REFERENCES wine(wine_code) ON DELETE SET NULL);



ALTER TABLE wine
	ADD (CONSTRAINT  R_1 FOREIGN KEY (todaywine_code) REFERENCES today(todaywine_code) ON DELETE SET NULL);



ALTER TABLE wine
	ADD (CONSTRAINT  R_2 FOREIGN KEY (mem_grade) REFERENCES grade_pt_rade(mem_grade) ON DELETE SET NULL);



ALTER TABLE wine
	ADD (CONSTRAINT  R_3 FOREIGN KEY (wine_type_code) REFERENCES wine_type(wine_type_code) ON DELETE SET NULL);



ALTER TABLE wine
	ADD (CONSTRAINT  R_4 FOREIGN KEY (theme_code) REFERENCES theme(theme_code) ON DELETE SET NULL);



ALTER TABLE wine
	ADD (CONSTRAINT  R_5 FOREIGN KEY (nation_code) REFERENCES nation(nation_code) ON DELETE SET NULL);



CREATE  TRIGGER tD_grade_pt_rade AFTER DELETE ON grade_pt_rade for each row
-- ERwin Builtin 2021년 11월 23일 화요일 오전 10:03:30
-- DELETE trigger on grade_pt_rade 
DECLARE NUMROWS INTEGER;
BEGIN
    /* ERwin Builtin 2021년 11월 23일 ?요일 오전 10:03:30 */
    /* grade_pt_rade  wine on parent delete set null */
    /* ERWIN_RELATION:CHECKSUM="0000b34c", PARENT_OWNER="", PARENT_TABLE="grade_pt_rade"
    CHILD_OWNER="", CHILD_TABLE="wine"
    P2C_VERB_PHRASE="R/2", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_2", FK_COLUMNS="mem_grade" */
    UPDATE wine
      SET
        /* %SetFK(wine,NULL) */
        wine.mem_grade = NULL
      WHERE
        /* %JoinFKPK(wine,:%Old," = "," AND") */
        wine.mem_grade = :old.mem_grade;


-- ERwin Builtin 2021년 11월 23일 화요일 오전 10:03:30
END;
/

CREATE  TRIGGER tU_grade_pt_rade AFTER UPDATE ON grade_pt_rade for each row
-- ERwin Builtin 2021년 11월 23일 화요일 오전 10:03:30
-- UPDATE trigger on grade_pt_rade 
DECLARE NUMROWS INTEGER;
BEGIN
  /* grade_pt_rade  wine on parent update set null */
  /* ERWIN_RELATION:CHECKSUM="0000e9aa", PARENT_OWNER="", PARENT_TABLE="grade_pt_rade"
    CHILD_OWNER="", CHILD_TABLE="wine"
    P2C_VERB_PHRASE="R/2", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_2", FK_COLUMNS="mem_grade" */
  IF
    /* %JoinPKPK(:%Old,:%New," <> "," OR ") */
    :old.mem_grade <> :new.mem_grade
  THEN
    UPDATE wine
      SET
        /* %SetFK(wine,NULL) */
        wine.mem_grade = NULL
      WHERE
        /* %JoinFKPK(wine,:%Old," = ",",") */
        wine.mem_grade = :old.mem_grade;
  END IF;


-- ERwin Builtin 2021년 11월 23일 화요일 오전 10:03:30
END;
/


CREATE  TRIGGER tD_manager AFTER DELETE ON manager for each row
-- ERwin Builtin 2021년 11월 23일 화요일 오전 10:03:30
-- DELETE trigger on manager 
DECLARE NUMROWS INTEGER;
BEGIN
    /* ERwin Builtin 2021년 11월 23일 ?요일 오전 10:03:30 */
    /* manager  stock_management on parent delete set null */
    /* ERWIN_RELATION:CHECKSUM="0000d9b1", PARENT_OWNER="", PARENT_TABLE="manager"
    CHILD_OWNER="", CHILD_TABLE="stock_management"
    P2C_VERB_PHRASE="R/7", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_7", FK_COLUMNS="manager_id" */
    UPDATE stock_management
      SET
        /* %SetFK(stock_management,NULL) */
        stock_management.manager_id = NULL
      WHERE
        /* %JoinFKPK(stock_management,:%Old," = "," AND") */
        stock_management.manager_id = :old.manager_id;


-- ERwin Builtin 2021년 11월 23일 화요일 오전 10:03:30
END;
/

CREATE  TRIGGER tU_manager AFTER UPDATE ON manager for each row
-- ERwin Builtin 2021년 11월 23일 화요일 오전 10:03:30
-- UPDATE trigger on manager 
DECLARE NUMROWS INTEGER;
BEGIN
  /* manager  stock_management on parent update set null */
  /* ERWIN_RELATION:CHECKSUM="0000fb17", PARENT_OWNER="", PARENT_TABLE="manager"
    CHILD_OWNER="", CHILD_TABLE="stock_management"
    P2C_VERB_PHRASE="R/7", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_7", FK_COLUMNS="manager_id" */
  IF
    /* %JoinPKPK(:%Old,:%New," <> "," OR ") */
    :old.manager_id <> :new.manager_id
  THEN
    UPDATE stock_management
      SET
        /* %SetFK(stock_management,NULL) */
        stock_management.manager_id = NULL
      WHERE
        /* %JoinFKPK(stock_management,:%Old," = ",",") */
        stock_management.manager_id = :old.manager_id;
  END IF;


-- ERwin Builtin 2021년 11월 23일 화요일 오전 10:03:30
END;
/


CREATE  TRIGGER tD_member AFTER DELETE ON member for each row
-- ERwin Builtin 2021년 11월 23일 화요일 오전 10:03:30
-- DELETE trigger on member 
DECLARE NUMROWS INTEGER;
BEGIN
    /* ERwin Builtin 2021년 11월 23일 ?요일 오전 10:03:30 */
    /* member  sale on parent delete set null */
    /* ERWIN_RELATION:CHECKSUM="0000aacb", PARENT_OWNER="", PARENT_TABLE="member"
    CHILD_OWNER="", CHILD_TABLE="sale"
    P2C_VERB_PHRASE="R/10", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_10", FK_COLUMNS="mem_id" */
    UPDATE sale
      SET
        /* %SetFK(sale,NULL) */
        sale.mem_id = NULL
      WHERE
        /* %JoinFKPK(sale,:%Old," = "," AND") */
        sale.mem_id = :old.mem_id;


-- ERwin Builtin 2021년 11월 23일 화요일 오전 10:03:30
END;
/

CREATE  TRIGGER tU_member AFTER UPDATE ON member for each row
-- ERwin Builtin 2021년 11월 23일 화요일 오전 10:03:30
-- UPDATE trigger on member 
DECLARE NUMROWS INTEGER;
BEGIN
  /* member  sale on parent update set null */
  /* ERWIN_RELATION:CHECKSUM="0000d6c2", PARENT_OWNER="", PARENT_TABLE="member"
    CHILD_OWNER="", CHILD_TABLE="sale"
    P2C_VERB_PHRASE="R/10", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_10", FK_COLUMNS="mem_id" */
  IF
    /* %JoinPKPK(:%Old,:%New," <> "," OR ") */
    :old.mem_id <> :new.mem_id
  THEN
    UPDATE sale
      SET
        /* %SetFK(sale,NULL) */
        sale.mem_id = NULL
      WHERE
        /* %JoinFKPK(sale,:%Old," = ",",") */
        sale.mem_id = :old.mem_id;
  END IF;


-- ERwin Builtin 2021년 11월 23일 화요일 오전 10:03:30
END;
/


CREATE  TRIGGER tD_nation AFTER DELETE ON nation for each row
-- ERwin Builtin 2021년 11월 23일 화요일 오전 10:03:30
-- DELETE trigger on nation 
DECLARE NUMROWS INTEGER;
BEGIN
    /* ERwin Builtin 2021년 11월 23일 ?요일 오전 10:03:30 */
    /* nation  wine on parent delete set null */
    /* ERWIN_RELATION:CHECKSUM="0000b600", PARENT_OWNER="", PARENT_TABLE="nation"
    CHILD_OWNER="", CHILD_TABLE="wine"
    P2C_VERB_PHRASE="R/5", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_5", FK_COLUMNS="nation_code" */
    UPDATE wine
      SET
        /* %SetFK(wine,NULL) */
        wine.nation_code = NULL
      WHERE
        /* %JoinFKPK(wine,:%Old," = "," AND") */
        wine.nation_code = :old.nation_code;


-- ERwin Builtin 2021년 11월 23일 화요일 오전 10:03:30
END;
/

CREATE  TRIGGER tU_nation AFTER UPDATE ON nation for each row
-- ERwin Builtin 2021년 11월 23일 화요일 오전 10:03:30
-- UPDATE trigger on nation 
DECLARE NUMROWS INTEGER;
BEGIN
  /* nation  wine on parent update set null */
  /* ERWIN_RELATION:CHECKSUM="0000e5a7", PARENT_OWNER="", PARENT_TABLE="nation"
    CHILD_OWNER="", CHILD_TABLE="wine"
    P2C_VERB_PHRASE="R/5", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_5", FK_COLUMNS="nation_code" */
  IF
    /* %JoinPKPK(:%Old,:%New," <> "," OR ") */
    :old.nation_code <> :new.nation_code
  THEN
    UPDATE wine
      SET
        /* %SetFK(wine,NULL) */
        wine.nation_code = NULL
      WHERE
        /* %JoinFKPK(wine,:%Old," = ",",") */
        wine.nation_code = :old.nation_code;
  END IF;


-- ERwin Builtin 2021년 11월 23일 화요일 오전 10:03:30
END;
/


CREATE  TRIGGER tI_sale BEFORE INSERT ON sale for each row
-- ERwin Builtin 2021년 11월 23일 화요일 오전 10:03:30
-- INSERT trigger on sale 
DECLARE NUMROWS INTEGER;
BEGIN
    /* ERwin Builtin 2021년 11월 23일 ?요일 오전 10:03:30 */
    /* wine  sale on child insert set null */
    /* ERWIN_RELATION:CHECKSUM="0001deb1", PARENT_OWNER="", PARENT_TABLE="wine"
    CHILD_OWNER="", CHILD_TABLE="sale"
    P2C_VERB_PHRASE="R/8", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_8", FK_COLUMNS="wine_code" */
    UPDATE sale
      SET
        /* %SetFK(sale,NULL) */
        sale.wine_code = NULL
      WHERE
        NOT EXISTS (
          SELECT * FROM wine
            WHERE
              /* %JoinFKPK(:%New,wine," = "," AND") */
              :new.wine_code = wine.wine_code
        ) 
        /* %JoinPKPK(sale,:%New," = "," AND") */
         and sale.sale_code = :new.sale_code;

    /* ERwin Builtin 2021년 11월 23일 ?요일 오전 10:03:30 */
    /* member  sale on child insert set null */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="member"
    CHILD_OWNER="", CHILD_TABLE="sale"
    P2C_VERB_PHRASE="R/10", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_10", FK_COLUMNS="mem_id" */
    UPDATE sale
      SET
        /* %SetFK(sale,NULL) */
        sale.mem_id = NULL
      WHERE
        NOT EXISTS (
          SELECT * FROM member
            WHERE
              /* %JoinFKPK(:%New,member," = "," AND") */
              :new.mem_id = member.mem_id
        ) 
        /* %JoinPKPK(sale,:%New," = "," AND") */
         and sale.sale_code = :new.sale_code;


-- ERwin Builtin 2021년 11월 23일 화요일 오전 10:03:30
END;
/

CREATE  TRIGGER tU_sale AFTER UPDATE ON sale for each row
-- ERwin Builtin 2021년 11월 23일 화요일 오전 10:03:30
-- UPDATE trigger on sale 
DECLARE NUMROWS INTEGER;
BEGIN
  /* ERwin Builtin 2021년 11월 23일 ?요일 오전 10:03:30 */
  /* wine  sale on child update no action */
  /* ERWIN_RELATION:CHECKSUM="0001fe63", PARENT_OWNER="", PARENT_TABLE="wine"
    CHILD_OWNER="", CHILD_TABLE="sale"
    P2C_VERB_PHRASE="R/8", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_8", FK_COLUMNS="wine_code" */
  SELECT count(*) INTO NUMROWS
    FROM wine
    WHERE
      /* %JoinFKPK(:%New,wine," = "," AND") */
      :new.wine_code = wine.wine_code;
  IF (
    /* %NotnullFK(:%New," IS NOT NULL AND") */
    :new.wine_code IS NOT NULL AND
    NUMROWS = 0
  )
  THEN
    raise_application_error(
      -20007,
      'Cannot update sale because wine does not exist.'
    );
  END IF;

  /* ERwin Builtin 2021년 11월 23일 ?요일 오전 10:03:30 */
  /* member  sale on child update no action */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="member"
    CHILD_OWNER="", CHILD_TABLE="sale"
    P2C_VERB_PHRASE="R/10", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_10", FK_COLUMNS="mem_id" */
  SELECT count(*) INTO NUMROWS
    FROM member
    WHERE
      /* %JoinFKPK(:%New,member," = "," AND") */
      :new.mem_id = member.mem_id;
  IF (
    /* %NotnullFK(:%New," IS NOT NULL AND") */
    :new.mem_id IS NOT NULL AND
    NUMROWS = 0
  )
  THEN
    raise_application_error(
      -20007,
      'Cannot update sale because member does not exist.'
    );
  END IF;


-- ERwin Builtin 2021년 11월 23일 화요일 오전 10:03:30
END;
/


CREATE  TRIGGER tI_stock_management BEFORE INSERT ON stock_management for each row
-- ERwin Builtin 2021년 11월 23일 화요일 오전 10:03:30
-- INSERT trigger on stock_management 
DECLARE NUMROWS INTEGER;
BEGIN
    /* ERwin Builtin 2021년 11월 23일 ?요일 오전 10:03:30 */
    /* manager  stock_management on child insert set null */
    /* ERWIN_RELATION:CHECKSUM="000233d7", PARENT_OWNER="", PARENT_TABLE="manager"
    CHILD_OWNER="", CHILD_TABLE="stock_management"
    P2C_VERB_PHRASE="R/7", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_7", FK_COLUMNS="manager_id" */
    UPDATE stock_management
      SET
        /* %SetFK(stock_management,NULL) */
        stock_management.manager_id = NULL
      WHERE
        NOT EXISTS (
          SELECT * FROM manager
            WHERE
              /* %JoinFKPK(:%New,manager," = "," AND") */
              :new.manager_id = manager.manager_id
        ) 
        /* %JoinPKPK(stock_management,:%New," = "," AND") */
         and stock_management.stock_code = :new.stock_code;

    /* ERwin Builtin 2021년 11월 23일 ?요일 오전 10:03:30 */
    /* wine  stock_management on child insert set null */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="wine"
    CHILD_OWNER="", CHILD_TABLE="stock_management"
    P2C_VERB_PHRASE="R/12", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_12", FK_COLUMNS="wine_code" */
    UPDATE stock_management
      SET
        /* %SetFK(stock_management,NULL) */
        stock_management.wine_code = NULL
      WHERE
        NOT EXISTS (
          SELECT * FROM wine
            WHERE
              /* %JoinFKPK(:%New,wine," = "," AND") */
              :new.wine_code = wine.wine_code
        ) 
        /* %JoinPKPK(stock_management,:%New," = "," AND") */
         and stock_management.stock_code = :new.stock_code;


-- ERwin Builtin 2021년 11월 23일 화요일 오전 10:03:30
END;
/

CREATE  TRIGGER tU_stock_management AFTER UPDATE ON stock_management for each row
-- ERwin Builtin 2021년 11월 23일 화요일 오전 10:03:30
-- UPDATE trigger on stock_management 
DECLARE NUMROWS INTEGER;
BEGIN
  /* ERwin Builtin 2021년 11월 23일 ?요일 오전 10:03:30 */
  /* manager  stock_management on child update no action */
  /* ERWIN_RELATION:CHECKSUM="000234d5", PARENT_OWNER="", PARENT_TABLE="manager"
    CHILD_OWNER="", CHILD_TABLE="stock_management"
    P2C_VERB_PHRASE="R/7", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_7", FK_COLUMNS="manager_id" */
  SELECT count(*) INTO NUMROWS
    FROM manager
    WHERE
      /* %JoinFKPK(:%New,manager," = "," AND") */
      :new.manager_id = manager.manager_id;
  IF (
    /* %NotnullFK(:%New," IS NOT NULL AND") */
    :new.manager_id IS NOT NULL AND
    NUMROWS = 0
  )
  THEN
    raise_application_error(
      -20007,
      'Cannot update stock_management because manager does not exist.'
    );
  END IF;

  /* ERwin Builtin 2021년 11월 23일 ?요일 오전 10:03:30 */
  /* wine  stock_management on child update no action */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="wine"
    CHILD_OWNER="", CHILD_TABLE="stock_management"
    P2C_VERB_PHRASE="R/12", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_12", FK_COLUMNS="wine_code" */
  SELECT count(*) INTO NUMROWS
    FROM wine
    WHERE
      /* %JoinFKPK(:%New,wine," = "," AND") */
      :new.wine_code = wine.wine_code;
  IF (
    /* %NotnullFK(:%New," IS NOT NULL AND") */
    :new.wine_code IS NOT NULL AND
    NUMROWS = 0
  )
  THEN
    raise_application_error(
      -20007,
      'Cannot update stock_management because wine does not exist.'
    );
  END IF;


-- ERwin Builtin 2021년 11월 23일 화요일 오전 10:03:30
END;
/


CREATE  TRIGGER tD_theme AFTER DELETE ON theme for each row
-- ERwin Builtin 2021년 11월 23일 화요일 오전 10:03:30
-- DELETE trigger on theme 
DECLARE NUMROWS INTEGER;
BEGIN
    /* ERwin Builtin 2021년 11월 23일 ?요일 오전 10:03:30 */
    /* theme  wine on parent delete set null */
    /* ERWIN_RELATION:CHECKSUM="0000b362", PARENT_OWNER="", PARENT_TABLE="theme"
    CHILD_OWNER="", CHILD_TABLE="wine"
    P2C_VERB_PHRASE="R/4", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_4", FK_COLUMNS="theme_code" */
    UPDATE wine
      SET
        /* %SetFK(wine,NULL) */
        wine.theme_code = NULL
      WHERE
        /* %JoinFKPK(wine,:%Old," = "," AND") */
        wine.theme_code = :old.theme_code;


-- ERwin Builtin 2021년 11월 23일 화요일 오전 10:03:30
END;
/

CREATE  TRIGGER tU_theme AFTER UPDATE ON theme for each row
-- ERwin Builtin 2021년 11월 23일 화요일 오전 10:03:30
-- UPDATE trigger on theme 
DECLARE NUMROWS INTEGER;
BEGIN
  /* theme  wine on parent update set null */
  /* ERWIN_RELATION:CHECKSUM="0000d426", PARENT_OWNER="", PARENT_TABLE="theme"
    CHILD_OWNER="", CHILD_TABLE="wine"
    P2C_VERB_PHRASE="R/4", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_4", FK_COLUMNS="theme_code" */
  IF
    /* %JoinPKPK(:%Old,:%New," <> "," OR ") */
    :old.theme_code <> :new.theme_code
  THEN
    UPDATE wine
      SET
        /* %SetFK(wine,NULL) */
        wine.theme_code = NULL
      WHERE
        /* %JoinFKPK(wine,:%Old," = ",",") */
        wine.theme_code = :old.theme_code;
  END IF;


-- ERwin Builtin 2021년 11월 23일 화요일 오전 10:03:30
END;
/


CREATE  TRIGGER tD_today AFTER DELETE ON today for each row
-- ERwin Builtin 2021년 11월 23일 화요일 오전 10:03:30
-- DELETE trigger on today 
DECLARE NUMROWS INTEGER;
BEGIN
    /* ERwin Builtin 2021년 11월 23일 ?요일 오전 10:03:30 */
    /* today  wine on parent delete set null */
    /* ERWIN_RELATION:CHECKSUM="0000be20", PARENT_OWNER="", PARENT_TABLE="today"
    CHILD_OWNER="", CHILD_TABLE="wine"
    P2C_VERB_PHRASE="R/1", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_1", FK_COLUMNS="todaywine_code" */
    UPDATE wine
      SET
        /* %SetFK(wine,NULL) */
        wine.todaywine_code = NULL
      WHERE
        /* %JoinFKPK(wine,:%Old," = "," AND") */
        wine.todaywine_code = :old.todaywine_code;


-- ERwin Builtin 2021년 11월 23일 화요일 오전 10:03:30
END;
/

CREATE  TRIGGER tU_today AFTER UPDATE ON today for each row
-- ERwin Builtin 2021년 11월 23일 화요일 오전 10:03:30
-- UPDATE trigger on today 
DECLARE NUMROWS INTEGER;
BEGIN
  /* today  wine on parent update set null */
  /* ERWIN_RELATION:CHECKSUM="0000eacd", PARENT_OWNER="", PARENT_TABLE="today"
    CHILD_OWNER="", CHILD_TABLE="wine"
    P2C_VERB_PHRASE="R/1", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_1", FK_COLUMNS="todaywine_code" */
  IF
    /* %JoinPKPK(:%Old,:%New," <> "," OR ") */
    :old.todaywine_code <> :new.todaywine_code
  THEN
    UPDATE wine
      SET
        /* %SetFK(wine,NULL) */
        wine.todaywine_code = NULL
      WHERE
        /* %JoinFKPK(wine,:%Old," = ",",") */
        wine.todaywine_code = :old.todaywine_code;
  END IF;


-- ERwin Builtin 2021년 11월 23일 화요일 오전 10:03:30
END;
/


CREATE  TRIGGER tI_wine BEFORE INSERT ON wine for each row
-- ERwin Builtin 2021년 11월 23일 화요일 오전 10:03:30
-- INSERT trigger on wine 
DECLARE NUMROWS INTEGER;
BEGIN
    /* ERwin Builtin 2021년 11월 23일 ?요일 오전 10:03:30 */
    /* today  wine on child insert set null */
    /* ERWIN_RELATION:CHECKSUM="00050186", PARENT_OWNER="", PARENT_TABLE="today"
    CHILD_OWNER="", CHILD_TABLE="wine"
    P2C_VERB_PHRASE="R/1", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_1", FK_COLUMNS="todaywine_code" */
    UPDATE wine
      SET
        /* %SetFK(wine,NULL) */
        wine.todaywine_code = NULL
      WHERE
        NOT EXISTS (
          SELECT * FROM today
            WHERE
              /* %JoinFKPK(:%New,today," = "," AND") */
              :new.todaywine_code = today.todaywine_code
        ) 
        /* %JoinPKPK(wine,:%New," = "," AND") */
         and wine.wine_code = :new.wine_code;

    /* ERwin Builtin 2021년 11월 23일 ?요일 오전 10:03:30 */
    /* grade_pt_rade  wine on child insert set null */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="grade_pt_rade"
    CHILD_OWNER="", CHILD_TABLE="wine"
    P2C_VERB_PHRASE="R/2", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_2", FK_COLUMNS="mem_grade" */
    UPDATE wine
      SET
        /* %SetFK(wine,NULL) */
        wine.mem_grade = NULL
      WHERE
        NOT EXISTS (
          SELECT * FROM grade_pt_rade
            WHERE
              /* %JoinFKPK(:%New,grade_pt_rade," = "," AND") */
              :new.mem_grade = grade_pt_rade.mem_grade
        ) 
        /* %JoinPKPK(wine,:%New," = "," AND") */
         and wine.wine_code = :new.wine_code;

    /* ERwin Builtin 2021년 11월 23일 ?요일 오전 10:03:30 */
    /* wine_type  wine on child insert set null */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="wine_type"
    CHILD_OWNER="", CHILD_TABLE="wine"
    P2C_VERB_PHRASE="R/3", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_3", FK_COLUMNS="wine_type_code" */
    UPDATE wine
      SET
        /* %SetFK(wine,NULL) */
        wine.wine_type_code = NULL
      WHERE
        NOT EXISTS (
          SELECT * FROM wine_type
            WHERE
              /* %JoinFKPK(:%New,wine_type," = "," AND") */
              :new.wine_type_code = wine_type.wine_type_code
        ) 
        /* %JoinPKPK(wine,:%New," = "," AND") */
         and wine.wine_code = :new.wine_code;

    /* ERwin Builtin 2021년 11월 23일 ?요일 오전 10:03:30 */
    /* theme  wine on child insert set null */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="theme"
    CHILD_OWNER="", CHILD_TABLE="wine"
    P2C_VERB_PHRASE="R/4", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_4", FK_COLUMNS="theme_code" */
    UPDATE wine
      SET
        /* %SetFK(wine,NULL) */
        wine.theme_code = NULL
      WHERE
        NOT EXISTS (
          SELECT * FROM theme
            WHERE
              /* %JoinFKPK(:%New,theme," = "," AND") */
              :new.theme_code = theme.theme_code
        ) 
        /* %JoinPKPK(wine,:%New," = "," AND") */
         and wine.wine_code = :new.wine_code;

    /* ERwin Builtin 2021년 11월 23일 ?요일 오전 10:03:30 */
    /* nation  wine on child insert set null */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="nation"
    CHILD_OWNER="", CHILD_TABLE="wine"
    P2C_VERB_PHRASE="R/5", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_5", FK_COLUMNS="nation_code" */
    UPDATE wine
      SET
        /* %SetFK(wine,NULL) */
        wine.nation_code = NULL
      WHERE
        NOT EXISTS (
          SELECT * FROM nation
            WHERE
              /* %JoinFKPK(:%New,nation," = "," AND") */
              :new.nation_code = nation.nation_code
        ) 
        /* %JoinPKPK(wine,:%New," = "," AND") */
         and wine.wine_code = :new.wine_code;


-- ERwin Builtin 2021년 11월 23일 화요일 오전 10:03:30
END;
/

CREATE  TRIGGER tD_wine AFTER DELETE ON wine for each row
-- ERwin Builtin 2021년 11월 23일 화요일 오전 10:03:30
-- DELETE trigger on wine 
DECLARE NUMROWS INTEGER;
BEGIN
    /* ERwin Builtin 2021년 11월 23일 ?요일 오전 10:03:30 */
    /* wine  sale on parent delete set null */
    /* ERWIN_RELATION:CHECKSUM="0001a718", PARENT_OWNER="", PARENT_TABLE="wine"
    CHILD_OWNER="", CHILD_TABLE="sale"
    P2C_VERB_PHRASE="R/8", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_8", FK_COLUMNS="wine_code" */
    UPDATE sale
      SET
        /* %SetFK(sale,NULL) */
        sale.wine_code = NULL
      WHERE
        /* %JoinFKPK(sale,:%Old," = "," AND") */
        sale.wine_code = :old.wine_code;

    /* ERwin Builtin 2021년 11월 23일 ?요일 오전 10:03:30 */
    /* wine  stock_management on parent delete set null */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="wine"
    CHILD_OWNER="", CHILD_TABLE="stock_management"
    P2C_VERB_PHRASE="R/12", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_12", FK_COLUMNS="wine_code" */
    UPDATE stock_management
      SET
        /* %SetFK(stock_management,NULL) */
        stock_management.wine_code = NULL
      WHERE
        /* %JoinFKPK(stock_management,:%Old," = "," AND") */
        stock_management.wine_code = :old.wine_code;


-- ERwin Builtin 2021년 11월 23일 화요일 오전 10:03:30
END;
/

CREATE  TRIGGER tU_wine AFTER UPDATE ON wine for each row
-- ERwin Builtin 2021년 11월 23일 화요일 오전 10:03:30
-- UPDATE trigger on wine 
DECLARE NUMROWS INTEGER;
BEGIN
  /* wine  sale on parent update set null */
  /* ERWIN_RELATION:CHECKSUM="00074c17", PARENT_OWNER="", PARENT_TABLE="wine"
    CHILD_OWNER="", CHILD_TABLE="sale"
    P2C_VERB_PHRASE="R/8", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_8", FK_COLUMNS="wine_code" */
  IF
    /* %JoinPKPK(:%Old,:%New," <> "," OR ") */
    :old.wine_code <> :new.wine_code
  THEN
    UPDATE sale
      SET
        /* %SetFK(sale,NULL) */
        sale.wine_code = NULL
      WHERE
        /* %JoinFKPK(sale,:%Old," = ",",") */
        sale.wine_code = :old.wine_code;
  END IF;

  /* wine  stock_management on parent update set null */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="wine"
    CHILD_OWNER="", CHILD_TABLE="stock_management"
    P2C_VERB_PHRASE="R/12", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_12", FK_COLUMNS="wine_code" */
  IF
    /* %JoinPKPK(:%Old,:%New," <> "," OR ") */
    :old.wine_code <> :new.wine_code
  THEN
    UPDATE stock_management
      SET
        /* %SetFK(stock_management,NULL) */
        stock_management.wine_code = NULL
      WHERE
        /* %JoinFKPK(stock_management,:%Old," = ",",") */
        stock_management.wine_code = :old.wine_code;
  END IF;

  /* ERwin Builtin 2021년 11월 23일 ?요일 오전 10:03:30 */
  /* today  wine on child update no action */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="today"
    CHILD_OWNER="", CHILD_TABLE="wine"
    P2C_VERB_PHRASE="R/1", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_1", FK_COLUMNS="todaywine_code" */
  SELECT count(*) INTO NUMROWS
    FROM today
    WHERE
      /* %JoinFKPK(:%New,today," = "," AND") */
      :new.todaywine_code = today.todaywine_code;
  IF (
    /* %NotnullFK(:%New," IS NOT NULL AND") */
    :new.todaywine_code IS NOT NULL AND
    NUMROWS = 0
  )
  THEN
    raise_application_error(
      -20007,
      'Cannot update wine because today does not exist.'
    );
  END IF;

  /* ERwin Builtin 2021년 11월 23일 ?요일 오전 10:03:30 */
  /* grade_pt_rade  wine on child update no action */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="grade_pt_rade"
    CHILD_OWNER="", CHILD_TABLE="wine"
    P2C_VERB_PHRASE="R/2", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_2", FK_COLUMNS="mem_grade" */
  SELECT count(*) INTO NUMROWS
    FROM grade_pt_rade
    WHERE
      /* %JoinFKPK(:%New,grade_pt_rade," = "," AND") */
      :new.mem_grade = grade_pt_rade.mem_grade;
  IF (
    /* %NotnullFK(:%New," IS NOT NULL AND") */
    :new.mem_grade IS NOT NULL AND
    NUMROWS = 0
  )
  THEN
    raise_application_error(
      -20007,
      'Cannot update wine because grade_pt_rade does not exist.'
    );
  END IF;

  /* ERwin Builtin 2021년 11월 23일 ?요일 오전 10:03:30 */
  /* wine_type  wine on child update no action */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="wine_type"
    CHILD_OWNER="", CHILD_TABLE="wine"
    P2C_VERB_PHRASE="R/3", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_3", FK_COLUMNS="wine_type_code" */
  SELECT count(*) INTO NUMROWS
    FROM wine_type
    WHERE
      /* %JoinFKPK(:%New,wine_type," = "," AND") */
      :new.wine_type_code = wine_type.wine_type_code;
  IF (
    /* %NotnullFK(:%New," IS NOT NULL AND") */
    :new.wine_type_code IS NOT NULL AND
    NUMROWS = 0
  )
  THEN
    raise_application_error(
      -20007,
      'Cannot update wine because wine_type does not exist.'
    );
  END IF;

  /* ERwin Builtin 2021년 11월 23일 ?요일 오전 10:03:30 */
  /* theme  wine on child update no action */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="theme"
    CHILD_OWNER="", CHILD_TABLE="wine"
    P2C_VERB_PHRASE="R/4", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_4", FK_COLUMNS="theme_code" */
  SELECT count(*) INTO NUMROWS
    FROM theme
    WHERE
      /* %JoinFKPK(:%New,theme," = "," AND") */
      :new.theme_code = theme.theme_code;
  IF (
    /* %NotnullFK(:%New," IS NOT NULL AND") */
    :new.theme_code IS NOT NULL AND
    NUMROWS = 0
  )
  THEN
    raise_application_error(
      -20007,
      'Cannot update wine because theme does not exist.'
    );
  END IF;

  /* ERwin Builtin 2021년 11월 23일 ?요일 오전 10:03:30 */
  /* nation  wine on child update no action */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="nation"
    CHILD_OWNER="", CHILD_TABLE="wine"
    P2C_VERB_PHRASE="R/5", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_5", FK_COLUMNS="nation_code" */
  SELECT count(*) INTO NUMROWS
    FROM nation
    WHERE
      /* %JoinFKPK(:%New,nation," = "," AND") */
      :new.nation_code = nation.nation_code;
  IF (
    /* %NotnullFK(:%New," IS NOT NULL AND") */
    :new.nation_code IS NOT NULL AND
    NUMROWS = 0
  )
  THEN
    raise_application_error(
      -20007,
      'Cannot update wine because nation does not exist.'
    );
  END IF;


-- ERwin Builtin 2021년 11월 23일 화요일 오전 10:03:30
END;
/


CREATE  TRIGGER tD_wine_type AFTER DELETE ON wine_type for each row
-- ERwin Builtin 2021년 11월 23일 화요일 오전 10:03:30
-- DELETE trigger on wine_type 
DECLARE NUMROWS INTEGER;
BEGIN
    /* ERwin Builtin 2021년 11월 23일 ?요일 오전 10:03:30 */
    /* wine_type  wine on parent delete set null */
    /* ERWIN_RELATION:CHECKSUM="0000bccd", PARENT_OWNER="", PARENT_TABLE="wine_type"
    CHILD_OWNER="", CHILD_TABLE="wine"
    P2C_VERB_PHRASE="R/3", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_3", FK_COLUMNS="wine_type_code" */
    UPDATE wine
      SET
        /* %SetFK(wine,NULL) */
        wine.wine_type_code = NULL
      WHERE
        /* %JoinFKPK(wine,:%Old," = "," AND") */
        wine.wine_type_code = :old.wine_type_code;


-- ERwin Builtin 2021년 11월 23일 화요일 오전 10:03:30
END;
/

CREATE  TRIGGER tU_wine_type AFTER UPDATE ON wine_type for each row
-- ERwin Builtin 2021년 11월 23일 화요일 오전 10:03:30
-- UPDATE trigger on wine_type 
DECLARE NUMROWS INTEGER;
BEGIN
  /* wine_type  wine on parent update set null */
  /* ERWIN_RELATION:CHECKSUM="0000eb97", PARENT_OWNER="", PARENT_TABLE="wine_type"
    CHILD_OWNER="", CHILD_TABLE="wine"
    P2C_VERB_PHRASE="R/3", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_3", FK_COLUMNS="wine_type_code" */
  IF
    /* %JoinPKPK(:%Old,:%New," <> "," OR ") */
    :old.wine_type_code <> :new.wine_type_code
  THEN
    UPDATE wine
      SET
        /* %SetFK(wine,NULL) */
        wine.wine_type_code = NULL
      WHERE
        /* %JoinFKPK(wine,:%Old," = ",",") */
        wine.wine_type_code = :old.wine_type_code;
  END IF;


-- ERwin Builtin 2021년 11월 23일 화요일 오전 10:03:30
END;
/

