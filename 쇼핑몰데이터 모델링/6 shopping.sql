
CREATE TABLE member
(
	zipcode               VARCHAR2(7)  NULL ,
	id                    VARCHAR2(20)  NOT NULL ,
	pwd                   VARCHAR2(20)  NULL ,
	name                  VARCHAR2(50)  NULL ,
	address               VARCHAR2(100)  NULL ,
	tel                   VARCHAR2(15)  NULL ,
	indate                DATE   DEFAULT  sysdate NULL 
);



CREATE UNIQUE INDEX XPK绊按 ON member
(id  ASC);



ALTER TABLE member
	ADD CONSTRAINT  XPK绊按 PRIMARY KEY (id);



CREATE TABLE orders
(
	id                    VARCHAR2(20)  NULL ,
	product_code          VARCHAR2(20)  NULL ,
	o_seq                 NUMBER(10)  NOT NULL ,
	product_size          VARCHAR2(5)  NULL ,
	quantity              VARCHAR2(5)  NULL ,
	result                CHAR(1)  NULL ,
	indate                DATE  NULL 
);



CREATE UNIQUE INDEX XPK林巩 ON orders
(o_seq  ASC);



ALTER TABLE orders
	ADD CONSTRAINT  XPK林巩 PRIMARY KEY (o_seq);



CREATE TABLE products
(
	product_code          VARCHAR2(20)  NOT NULL ,
	product_name          VARCHAR2(100)  NULL ,
	product_kind          CHAR(1)  NULL ,
	product_price1        VARCHAR2(10)  NULL ,
	product_price2        VARCHAR2(10)  NULL ,
	product_content       VARCHAR2(1000)  NULL ,
	product_image         VARCHAR2(50)  NULL ,
	sizest                VARCHAR2(5)  NULL ,
	sizeEt                VARCHAR2(5)  NULL ,
	product_quantiy       VARCHAR2(5)  NULL ,
	useyn                 CHAR(1)  NULL ,
	indate                DATE  NULL 
);



CREATE UNIQUE INDEX XPK惑前 ON products
(product_code  ASC);



ALTER TABLE products
	ADD CONSTRAINT  XPK惑前 PRIMARY KEY (product_code);



CREATE TABLE tb_zipcode
(
	zipcode               VARCHAR2(7)  NOT NULL ,
	sido                  VARCHAR2(30)  NULL ,
	gugun                 VARCHAR2(30)  NULL ,
	dong                  VARCHAR2(30)  NULL ,
	bunji                 VARCHAR2(30)  NULL 
);



CREATE UNIQUE INDEX XPK快祈锅龋 ON tb_zipcode
(zipcode  ASC);



ALTER TABLE tb_zipcode
	ADD CONSTRAINT  XPK快祈锅龋 PRIMARY KEY (zipcode);



ALTER TABLE member
	ADD (CONSTRAINT  R_3 FOREIGN KEY (zipcode) REFERENCES tb_zipcode(zipcode) ON DELETE SET NULL);



ALTER TABLE orders
	ADD (CONSTRAINT  R_4 FOREIGN KEY (id) REFERENCES member(id) ON DELETE SET NULL);



ALTER TABLE orders
	ADD (CONSTRAINT  R_6 FOREIGN KEY (product_code) REFERENCES products(product_code) ON DELETE SET NULL);



CREATE  TRIGGER tI_member BEFORE INSERT ON member for each row
-- ERwin Builtin 2021斥 11岿 11老 格夸老 12:10:02
-- INSERT trigger on member 
DECLARE NUMROWS INTEGER;
BEGIN
    /* ERwin Builtin 2021斥 11岿 11老 格夸老 12:10:02 */
    /* tb_zipcode  member on child insert set null */
    /* ERWIN_RELATION:CHECKSUM="0000e7aa", PARENT_OWNER="", PARENT_TABLE="tb_zipcode"
    CHILD_OWNER="", CHILD_TABLE="member"
    P2C_VERB_PHRASE="R/3", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_3", FK_COLUMNS="zipcode" */
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


-- ERwin Builtin 2021斥 11岿 11老 格夸老 12:10:02
END;
/

CREATE  TRIGGER tD_member AFTER DELETE ON member for each row
-- ERwin Builtin 2021斥 11岿 11老 格夸老 12:10:02
-- DELETE trigger on member 
DECLARE NUMROWS INTEGER;
BEGIN
    /* ERwin Builtin 2021斥 11岿 11老 格夸老 12:10:02 */
    /* member  orders on parent delete set null */
    /* ERWIN_RELATION:CHECKSUM="0000aace", PARENT_OWNER="", PARENT_TABLE="member"
    CHILD_OWNER="", CHILD_TABLE="orders"
    P2C_VERB_PHRASE="R/4", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_4", FK_COLUMNS="id" */
    UPDATE orders
      SET
        /* %SetFK(orders,NULL) */
        orders.id = NULL
      WHERE
        /* %JoinFKPK(orders,:%Old," = "," AND") */
        orders.id = :old.id;


-- ERwin Builtin 2021斥 11岿 11老 格夸老 12:10:02
END;
/

CREATE  TRIGGER tU_member AFTER UPDATE ON member for each row
-- ERwin Builtin 2021斥 11岿 11老 格夸老 12:10:02
-- UPDATE trigger on member 
DECLARE NUMROWS INTEGER;
BEGIN
  /* member  orders on parent update set null */
  /* ERWIN_RELATION:CHECKSUM="0001df82", PARENT_OWNER="", PARENT_TABLE="member"
    CHILD_OWNER="", CHILD_TABLE="orders"
    P2C_VERB_PHRASE="R/4", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_4", FK_COLUMNS="id" */
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

  /* ERwin Builtin 2021斥 11岿 11老 格夸老 12:10:02 */
  /* tb_zipcode  member on child update no action */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="tb_zipcode"
    CHILD_OWNER="", CHILD_TABLE="member"
    P2C_VERB_PHRASE="R/3", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_3", FK_COLUMNS="zipcode" */
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


-- ERwin Builtin 2021斥 11岿 11老 格夸老 12:10:02
END;
/


CREATE  TRIGGER tI_orders BEFORE INSERT ON orders for each row
-- ERwin Builtin 2021斥 11岿 11老 格夸老 12:10:02
-- INSERT trigger on orders 
DECLARE NUMROWS INTEGER;
BEGIN
    /* ERwin Builtin 2021斥 11岿 11老 格夸老 12:10:02 */
    /* member  orders on child insert set null */
    /* ERWIN_RELATION:CHECKSUM="0001e1ce", PARENT_OWNER="", PARENT_TABLE="member"
    CHILD_OWNER="", CHILD_TABLE="orders"
    P2C_VERB_PHRASE="R/4", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_4", FK_COLUMNS="id" */
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

    /* ERwin Builtin 2021斥 11岿 11老 格夸老 12:10:02 */
    /* products  orders on child insert set null */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="products"
    CHILD_OWNER="", CHILD_TABLE="orders"
    P2C_VERB_PHRASE="R/6", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_6", FK_COLUMNS="product_code" */
    UPDATE orders
      SET
        /* %SetFK(orders,NULL) */
        orders.product_code = NULL
      WHERE
        NOT EXISTS (
          SELECT * FROM products
            WHERE
              /* %JoinFKPK(:%New,products," = "," AND") */
              :new.product_code = products.product_code
        ) 
        /* %JoinPKPK(orders,:%New," = "," AND") */
         and orders.o_seq = :new.o_seq;


-- ERwin Builtin 2021斥 11岿 11老 格夸老 12:10:02
END;
/

CREATE  TRIGGER tU_orders AFTER UPDATE ON orders for each row
-- ERwin Builtin 2021斥 11岿 11老 格夸老 12:10:02
-- UPDATE trigger on orders 
DECLARE NUMROWS INTEGER;
BEGIN
  /* ERwin Builtin 2021斥 11岿 11老 格夸老 12:10:02 */
  /* member  orders on child update no action */
  /* ERWIN_RELATION:CHECKSUM="00021412", PARENT_OWNER="", PARENT_TABLE="member"
    CHILD_OWNER="", CHILD_TABLE="orders"
    P2C_VERB_PHRASE="R/4", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_4", FK_COLUMNS="id" */
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

  /* ERwin Builtin 2021斥 11岿 11老 格夸老 12:10:02 */
  /* products  orders on child update no action */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="products"
    CHILD_OWNER="", CHILD_TABLE="orders"
    P2C_VERB_PHRASE="R/6", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_6", FK_COLUMNS="product_code" */
  SELECT count(*) INTO NUMROWS
    FROM products
    WHERE
      /* %JoinFKPK(:%New,products," = "," AND") */
      :new.product_code = products.product_code;
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


-- ERwin Builtin 2021斥 11岿 11老 格夸老 12:10:02
END;
/


CREATE  TRIGGER tD_products AFTER DELETE ON products for each row
-- ERwin Builtin 2021斥 11岿 11老 格夸老 12:10:02
-- DELETE trigger on products 
DECLARE NUMROWS INTEGER;
BEGIN
    /* ERwin Builtin 2021斥 11岿 11老 格夸老 12:10:02 */
    /* products  orders on parent delete set null */
    /* ERWIN_RELATION:CHECKSUM="0000cebc", PARENT_OWNER="", PARENT_TABLE="products"
    CHILD_OWNER="", CHILD_TABLE="orders"
    P2C_VERB_PHRASE="R/6", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_6", FK_COLUMNS="product_code" */
    UPDATE orders
      SET
        /* %SetFK(orders,NULL) */
        orders.product_code = NULL
      WHERE
        /* %JoinFKPK(orders,:%Old," = "," AND") */
        orders.product_code = :old.product_code;


-- ERwin Builtin 2021斥 11岿 11老 格夸老 12:10:02
END;
/

CREATE  TRIGGER tU_products AFTER UPDATE ON products for each row
-- ERwin Builtin 2021斥 11岿 11老 格夸老 12:10:02
-- UPDATE trigger on products 
DECLARE NUMROWS INTEGER;
BEGIN
  /* products  orders on parent update set null */
  /* ERWIN_RELATION:CHECKSUM="0000e89d", PARENT_OWNER="", PARENT_TABLE="products"
    CHILD_OWNER="", CHILD_TABLE="orders"
    P2C_VERB_PHRASE="R/6", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_6", FK_COLUMNS="product_code" */
  IF
    /* %JoinPKPK(:%Old,:%New," <> "," OR ") */
    :old.product_code <> :new.product_code
  THEN
    UPDATE orders
      SET
        /* %SetFK(orders,NULL) */
        orders.product_code = NULL
      WHERE
        /* %JoinFKPK(orders,:%Old," = ",",") */
        orders.product_code = :old.product_code;
  END IF;


-- ERwin Builtin 2021斥 11岿 11老 格夸老 12:10:02
END;
/


CREATE  TRIGGER tD_tb_zipcode AFTER DELETE ON tb_zipcode for each row
-- ERwin Builtin 2021斥 11岿 11老 格夸老 12:10:02
-- DELETE trigger on tb_zipcode 
DECLARE NUMROWS INTEGER;
BEGIN
    /* ERwin Builtin 2021斥 11岿 11老 格夸老 12:10:02 */
    /* tb_zipcode  member on parent delete set null */
    /* ERWIN_RELATION:CHECKSUM="0000b654", PARENT_OWNER="", PARENT_TABLE="tb_zipcode"
    CHILD_OWNER="", CHILD_TABLE="member"
    P2C_VERB_PHRASE="R/3", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_3", FK_COLUMNS="zipcode" */
    UPDATE member
      SET
        /* %SetFK(member,NULL) */
        member.zipcode = NULL
      WHERE
        /* %JoinFKPK(member,:%Old," = "," AND") */
        member.zipcode = :old.zipcode;


-- ERwin Builtin 2021斥 11岿 11老 格夸老 12:10:02
END;
/

CREATE  TRIGGER tU_tb_zipcode AFTER UPDATE ON tb_zipcode for each row
-- ERwin Builtin 2021斥 11岿 11老 格夸老 12:10:02
-- UPDATE trigger on tb_zipcode 
DECLARE NUMROWS INTEGER;
BEGIN
  /* tb_zipcode  member on parent update set null */
  /* ERWIN_RELATION:CHECKSUM="0000ddd7", PARENT_OWNER="", PARENT_TABLE="tb_zipcode"
    CHILD_OWNER="", CHILD_TABLE="member"
    P2C_VERB_PHRASE="R/3", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_3", FK_COLUMNS="zipcode" */
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


-- ERwin Builtin 2021斥 11岿 11老 格夸老 12:10:02
END;
/

