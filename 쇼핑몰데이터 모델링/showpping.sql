
CREATE TABLE member
(
	zipcode               varchar2(7)  NULL ,
	id                    varchar2(20)  NOT NULL ,
	pwd                   varchar2(20)  NULL ,
	name                  varchar2(50)  NULL ,
	adress                varchar2(100)  NULL ,
	tel                   varchar2(15)  NULL ,
	indate                DATE   DEFAULT  sysdate NULL 
);



CREATE UNIQUE INDEX XPK고객 ON member
(id  ASC);



ALTER TABLE member
	ADD CONSTRAINT  XPK고객 PRIMARY KEY (id);



CREATE TABLE orders
(
	id                    varchar2(20)  NULL ,
	product_code          varchar2(20)  NULL ,
	o_seq                 NUMBER(10)  NOT NULL ,
	product_size          varchar2(5)  NULL ,
	quantity              varchar2(5)  NULL ,
	result                CHAR(1)  NULL ,
	indate                DATE  NULL 
);



CREATE UNIQUE INDEX XPK주문 ON orders
(o_seq  ASC);



ALTER TABLE orders
	ADD CONSTRAINT  XPK주문 PRIMARY KEY (o_seq);



CREATE TABLE products
(
	상품코드              varchar2(20)  NOT NULL ,
	product_code          varchar2(20)  NULL ,
	puroduct_kind         char(1)  NULL ,
	puroduct_price1       varchar2(10)  NULL ,
	puroduct_price2       varchar2(10)  NULL ,
	puroduct_content      varchar2(1000)  NULL ,
	puroduct_image        varchar2(50)  NULL ,
	sizeSt                varchar2(5)  NULL ,
	sizeEt                varchar2(5)  NULL ,
	puroduct_quantity     varchar2(5)  NULL ,
	useyn                 CHAR(1)  NULL ,
	indate                DATE  NULL 
);



CREATE UNIQUE INDEX XPK상품 ON products
(상품코드  ASC);



ALTER TABLE products
	ADD CONSTRAINT  XPK상품 PRIMARY KEY (상품코드);



CREATE TABLE tb_zipcode
(
	zipcode               varchar2(7)  NOT NULL ,
	sido                  varchar2(30)  NULL ,
	gugun                 varchar2(30)  NULL ,
	dong                  varchar2(30)  NULL ,
	bunji                 varchar2(30)  NULL 
);



CREATE UNIQUE INDEX XPK우편번호 ON tb_zipcode
(zipcode  ASC);



ALTER TABLE tb_zipcode
	ADD CONSTRAINT  XPK우편번호 PRIMARY KEY (zipcode);



ALTER TABLE member
	ADD (CONSTRAINT  R_1 FOREIGN KEY (zipcode) REFERENCES tb_zipcode(zipcode) ON DELETE SET NULL);



ALTER TABLE orders
	ADD (CONSTRAINT  R_2 FOREIGN KEY (id) REFERENCES member(id) ON DELETE SET NULL);



ALTER TABLE orders
	ADD (CONSTRAINT  R_4 FOREIGN KEY (product_code) REFERENCES products(상품코드) ON DELETE SET NULL);



CREATE  TRIGGER tI_member BEFORE INSERT ON member for each row
-- ERwin Builtin 2021년 11월 11일 목요일 오후 12:18:10
-- INSERT trigger on member 
DECLARE NUMROWS INTEGER;
BEGIN
    /* ERwin Builtin 2021년 11월 11일 목요일 오후 12:18:10 */
    /* tb_zipcode  member on child insert set null */
    /* ERWIN_RELATION:CHECKSUM="0000e79c", PARENT_OWNER="", PARENT_TABLE="tb_zipcode"
    CHILD_OWNER="", CHILD_TABLE="member"
    P2C_VERB_PHRASE="R/1", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_1", FK_COLUMNS="zipcode" */
    UPDATE member
      SET
        /* %SetFK(member,NULL) */
        member.zipcode = NULL
      WHERE
        NOT EXISTS (
          SELECT * FROM tb_zipcode
            WHERE
              /* %JoinFKPK(:%New,tb_zipcode," = "," AND") */
              :new.zipcode = tb_zipcode.zipcode
        ) 
        /* %JoinPKPK(member,:%New," = "," AND") */
         and member.id = :new.id;


-- ERwin Builtin 2021년 11월 11일 목요일 오후 12:18:10
END;
/

CREATE  TRIGGER tD_member AFTER DELETE ON member for each row
-- ERwin Builtin 2021년 11월 11일 목요일 오후 12:18:10
-- DELETE trigger on member 
DECLARE NUMROWS INTEGER;
BEGIN
    /* ERwin Builtin 2021년 11월 11일 목요일 오후 12:18:10 */
    /* member  orders on parent delete set null */
    /* ERWIN_RELATION:CHECKSUM="0000aa23", PARENT_OWNER="", PARENT_TABLE="member"
    CHILD_OWNER="", CHILD_TABLE="orders"
    P2C_VERB_PHRASE="R/2", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_2", FK_COLUMNS="id" */
    UPDATE orders
      SET
        /* %SetFK(orders,NULL) */
        orders.id = NULL
      WHERE
        /* %JoinFKPK(orders,:%Old," = "," AND") */
        orders.id = :old.id;


-- ERwin Builtin 2021년 11월 11일 목요일 오후 12:18:10
END;
/

CREATE  TRIGGER tU_member AFTER UPDATE ON member for each row
-- ERwin Builtin 2021년 11월 11일 목요일 오후 12:18:10
-- UPDATE trigger on member 
DECLARE NUMROWS INTEGER;
BEGIN
  /* member  orders on parent update set null */
  /* ERWIN_RELATION:CHECKSUM="0001deab", PARENT_OWNER="", PARENT_TABLE="member"
    CHILD_OWNER="", CHILD_TABLE="orders"
    P2C_VERB_PHRASE="R/2", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_2", FK_COLUMNS="id" */
  IF
    /* %JoinPKPK(:%Old,:%New," <> "," OR ") */
    :old.id <> :new.id
  THEN
    UPDATE orders
      SET
        /* %SetFK(orders,NULL) */
        orders.id = NULL
      WHERE
        /* %JoinFKPK(orders,:%Old," = ",",") */
        orders.id = :old.id;
  END IF;

  /* ERwin Builtin 2021년 11월 11일 목요일 오후 12:18:10 */
  /* tb_zipcode  member on child update no action */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="tb_zipcode"
    CHILD_OWNER="", CHILD_TABLE="member"
    P2C_VERB_PHRASE="R/1", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_1", FK_COLUMNS="zipcode" */
  SELECT count(*) INTO NUMROWS
    FROM tb_zipcode
    WHERE
      /* %JoinFKPK(:%New,tb_zipcode," = "," AND") */
      :new.zipcode = tb_zipcode.zipcode;
  IF (
    /* %NotnullFK(:%New," IS NOT NULL AND") */
    :new.zipcode IS NOT NULL AND
    NUMROWS = 0
  )
  THEN
    raise_application_error(
      -20007,
      'Cannot update member because tb_zipcode does not exist.'
    );
  END IF;


-- ERwin Builtin 2021년 11월 11일 목요일 오후 12:18:10
END;
/


CREATE  TRIGGER tI_orders BEFORE INSERT ON orders for each row
-- ERwin Builtin 2021년 11월 11일 목요일 오후 12:18:10
-- INSERT trigger on orders 
DECLARE NUMROWS INTEGER;
BEGIN
    /* ERwin Builtin 2021년 11월 11일 목요일 오후 12:18:10 */
    /* member  orders on child insert set null */
    /* ERWIN_RELATION:CHECKSUM="0001da1b", PARENT_OWNER="", PARENT_TABLE="member"
    CHILD_OWNER="", CHILD_TABLE="orders"
    P2C_VERB_PHRASE="R/2", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_2", FK_COLUMNS="id" */
    UPDATE orders
      SET
        /* %SetFK(orders,NULL) */
        orders.id = NULL
      WHERE
        NOT EXISTS (
          SELECT * FROM member
            WHERE
              /* %JoinFKPK(:%New,member," = "," AND") */
              :new.id = member.id
        ) 
        /* %JoinPKPK(orders,:%New," = "," AND") */
         and orders.o_seq = :new.o_seq;

    /* ERwin Builtin 2021년 11월 11일 목요일 오후 12:18:10 */
    /* products  orders on child insert set null */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="products"
    CHILD_OWNER="", CHILD_TABLE="orders"
    P2C_VERB_PHRASE="R/4", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_4", FK_COLUMNS="product_code" */
    UPDATE orders
      SET
        /* %SetFK(orders,NULL) */
        orders.product_code = NULL
      WHERE
        NOT EXISTS (
          SELECT * FROM products
            WHERE
              /* %JoinFKPK(:%New,products," = "," AND") */
              :new.product_code = products.상품코드
        ) 
        /* %JoinPKPK(orders,:%New," = "," AND") */
         and orders.o_seq = :new.o_seq;


-- ERwin Builtin 2021년 11월 11일 목요일 오후 12:18:10
END;
/

CREATE  TRIGGER tU_orders AFTER UPDATE ON orders for each row
-- ERwin Builtin 2021년 11월 11일 목요일 오후 12:18:10
-- UPDATE trigger on orders 
DECLARE NUMROWS INTEGER;
BEGIN
  /* ERwin Builtin 2021년 11월 11일 목요일 오후 12:18:10 */
  /* member  orders on child update no action */
  /* ERWIN_RELATION:CHECKSUM="00020aae", PARENT_OWNER="", PARENT_TABLE="member"
    CHILD_OWNER="", CHILD_TABLE="orders"
    P2C_VERB_PHRASE="R/2", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_2", FK_COLUMNS="id" */
  SELECT count(*) INTO NUMROWS
    FROM member
    WHERE
      /* %JoinFKPK(:%New,member," = "," AND") */
      :new.id = member.id;
  IF (
    /* %NotnullFK(:%New," IS NOT NULL AND") */
    :new.id IS NOT NULL AND
    NUMROWS = 0
  )
  THEN
    raise_application_error(
      -20007,
      'Cannot update orders because member does not exist.'
    );
  END IF;

  /* ERwin Builtin 2021년 11월 11일 목요일 오후 12:18:10 */
  /* products  orders on child update no action */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="products"
    CHILD_OWNER="", CHILD_TABLE="orders"
    P2C_VERB_PHRASE="R/4", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_4", FK_COLUMNS="product_code" */
  SELECT count(*) INTO NUMROWS
    FROM products
    WHERE
      /* %JoinFKPK(:%New,products," = "," AND") */
      :new.product_code = products.상품코드;
  IF (
    /* %NotnullFK(:%New," IS NOT NULL AND") */
    :new.product_code IS NOT NULL AND
    NUMROWS = 0
  )
  THEN
    raise_application_error(
      -20007,
      'Cannot update orders because products does not exist.'
    );
  END IF;


-- ERwin Builtin 2021년 11월 11일 목요일 오후 12:18:10
END;
/


CREATE  TRIGGER tD_products AFTER DELETE ON products for each row
-- ERwin Builtin 2021년 11월 11일 목요일 오후 12:18:10
-- DELETE trigger on products 
DECLARE NUMROWS INTEGER;
BEGIN
    /* ERwin Builtin 2021년 11월 11일 목요일 오후 12:18:10 */
    /* products  orders on parent delete set null */
    /* ERWIN_RELATION:CHECKSUM="0000c2be", PARENT_OWNER="", PARENT_TABLE="products"
    CHILD_OWNER="", CHILD_TABLE="orders"
    P2C_VERB_PHRASE="R/4", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_4", FK_COLUMNS="product_code" */
    UPDATE orders
      SET
        /* %SetFK(orders,NULL) */
        orders.product_code = NULL
      WHERE
        /* %JoinFKPK(orders,:%Old," = "," AND") */
        orders.product_code = :old.상품코드;


-- ERwin Builtin 2021년 11월 11일 목요일 오후 12:18:10
END;
/

CREATE  TRIGGER tU_products AFTER UPDATE ON products for each row
-- ERwin Builtin 2021년 11월 11일 목요일 오후 12:18:10
-- UPDATE trigger on products 
DECLARE NUMROWS INTEGER;
BEGIN
  /* products  orders on parent update set null */
  /* ERWIN_RELATION:CHECKSUM="0000dd55", PARENT_OWNER="", PARENT_TABLE="products"
    CHILD_OWNER="", CHILD_TABLE="orders"
    P2C_VERB_PHRASE="R/4", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_4", FK_COLUMNS="product_code" */
  IF
    /* %JoinPKPK(:%Old,:%New," <> "," OR ") */
    :old.상품코드 <> :new.상품코드
  THEN
    UPDATE orders
      SET
        /* %SetFK(orders,NULL) */
        orders.product_code = NULL
      WHERE
        /* %JoinFKPK(orders,:%Old," = ",",") */
        orders.product_code = :old.상품코드;
  END IF;


-- ERwin Builtin 2021년 11월 11일 목요일 오후 12:18:10
END;
/


CREATE  TRIGGER tD_tb_zipcode AFTER DELETE ON tb_zipcode for each row
-- ERwin Builtin 2021년 11월 11일 목요일 오후 12:18:10
-- DELETE trigger on tb_zipcode 
DECLARE NUMROWS INTEGER;
BEGIN
    /* ERwin Builtin 2021년 11월 11일 목요일 오후 12:18:10 */
    /* tb_zipcode  member on parent delete set null */
    /* ERWIN_RELATION:CHECKSUM="0000c017", PARENT_OWNER="", PARENT_TABLE="tb_zipcode"
    CHILD_OWNER="", CHILD_TABLE="member"
    P2C_VERB_PHRASE="R/1", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_1", FK_COLUMNS="zipcode" */
    UPDATE member
      SET
        /* %SetFK(member,NULL) */
        member.zipcode = NULL
      WHERE
        /* %JoinFKPK(member,:%Old," = "," AND") */
        member.zipcode = :old.zipcode;


-- ERwin Builtin 2021년 11월 11일 목요일 오후 12:18:10
END;
/

CREATE  TRIGGER tU_tb_zipcode AFTER UPDATE ON tb_zipcode for each row
-- ERwin Builtin 2021년 11월 11일 목요일 오후 12:18:10
-- UPDATE trigger on tb_zipcode 
DECLARE NUMROWS INTEGER;
BEGIN
  /* tb_zipcode  member on parent update set null */
  /* ERWIN_RELATION:CHECKSUM="0000e863", PARENT_OWNER="", PARENT_TABLE="tb_zipcode"
    CHILD_OWNER="", CHILD_TABLE="member"
    P2C_VERB_PHRASE="R/1", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_1", FK_COLUMNS="zipcode" */
  IF
    /* %JoinPKPK(:%Old,:%New," <> "," OR ") */
    :old.zipcode <> :new.zipcode
  THEN
    UPDATE member
      SET
        /* %SetFK(member,NULL) */
        member.zipcode = NULL
      WHERE
        /* %JoinFKPK(member,:%Old," = ",",") */
        member.zipcode = :old.zipcode;
  END IF;


-- ERwin Builtin 2021년 11월 11일 목요일 오후 12:18:10
END;
/

