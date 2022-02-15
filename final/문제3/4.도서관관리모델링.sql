
CREATE TABLE book
(
	book_title            VARCHAR2(50)  NULL ,
	country               VARCHAR2(50)  NULL ,
	classify              VARCHAR2(50)  NULL ,
	book_num              VARCHAR2(50)  NOT NULL ,
	pub_date              DATE  NULL 
);



CREATE UNIQUE INDEX XPK도서 ON book
(book_num  ASC);



CREATE TABLE member
(
	mem_id                VARCHAR2(50)  NOT NULL ,
	mem_pw                VARCHAR2(50)  NULL ,
	mem_birth             VARCHAR2(50)  NULL ,
	mem_phone             VARCHAR2(50)  NULL ,
	book_count            NUMBER(10)  NULL ,
	zipcode               VARCHAR2(50)  NOT NULL 
);



CREATE UNIQUE INDEX XPK회원 ON member
(mem_id  ASC);



CREATE TABLE tb_zipcode
(
	zipcode               VARCHAR2(50)  NOT NULL ,
	sido                  VARCHAR2(50)  NULL ,
	gugun                 VARCHAR2(50)  NULL ,
	dong                  VARCHAR2(50)  NULL ,
	bunji                 VARCHAR2(50)  NULL 
);



CREATE UNIQUE INDEX XPK주소 ON tb_zipcode
(zipcode  ASC);



CREATE TABLE due
(
	book_num              VARCHAR2(50)  NOT NULL ,
	mem_id                VARCHAR2(50)  NOT NULL ,
	book_title            VARCHAR2(50)  NULL ,
	due_num               NUMBER(10)  NOT NULL ,
	due_date              DATE  NULL 
);



CREATE UNIQUE INDEX XPK대출 ON due
(due_num  ASC);



ALTER TABLE book
ADD CONSTRAINT  XPK도서 PRIMARY KEY (book_num);



ALTER TABLE member
ADD CONSTRAINT  XPK회원 PRIMARY KEY (mem_id);



ALTER TABLE tb_zipcode
ADD CONSTRAINT  XPK주소 PRIMARY KEY (zipcode);



ALTER TABLE due
ADD CONSTRAINT  XPK대출 PRIMARY KEY (due_num);



ALTER TABLE member
ADD CONSTRAINT  R_3 FOREIGN KEY (zipcode) REFERENCES tb_zipcode(zipcode);



ALTER TABLE due
ADD CONSTRAINT  R_4 FOREIGN KEY (book_num) REFERENCES book(book_num);



ALTER TABLE due
ADD CONSTRAINT  R_8 FOREIGN KEY (mem_id) REFERENCES member(mem_id);



CREATE  TRIGGER tD_book AFTER DELETE ON book for each row
-- ERwin Builtin 2021년 12월 2일 목요일 오전 10:18:31
-- DELETE trigger on book 
DECLARE NUMROWS INTEGER;
BEGIN
    /* ERwin Builtin 2021년 12월 2일 목요일 오전 10:18:31 */
    /* book  due on parent delete restrict */
    /* ERWIN_RELATION:CHECKSUM="0000c9a9", PARENT_OWNER="", PARENT_TABLE="book"
    CHILD_OWNER="", CHILD_TABLE="due"
    P2C_VERB_PHRASE="R/4", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_4", FK_COLUMNS="book_num" */
    SELECT count(*) INTO NUMROWS
      FROM due
      WHERE
        /*  %JoinFKPK(due,:%Old," = "," AND") */
        due.book_num = :old.book_num;
    IF (NUMROWS > 0)
    THEN
      raise_application_error(
        -20001,
        'Cannot delete book because due exists.'
      );
    END IF;


-- ERwin Builtin 2021년 12월 2일 목요일 오전 10:18:31
END;
/

CREATE  TRIGGER tU_book AFTER UPDATE ON book for each row
-- ERwin Builtin 2021년 12월 2일 목요일 오전 10:18:31
-- UPDATE trigger on book 
DECLARE NUMROWS INTEGER;
BEGIN
  /* ERwin Builtin 2021년 12월 2일 목요일 오전 10:18:31 */
  /* book  due on parent update restrict */
  /* ERWIN_RELATION:CHECKSUM="0000fa09", PARENT_OWNER="", PARENT_TABLE="book"
    CHILD_OWNER="", CHILD_TABLE="due"
    P2C_VERB_PHRASE="R/4", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_4", FK_COLUMNS="book_num" */
  IF
    /* %JoinPKPK(:%Old,:%New," <> "," OR ") */
    :old.book_num <> :new.book_num
  THEN
    SELECT count(*) INTO NUMROWS
      FROM due
      WHERE
        /*  %JoinFKPK(due,:%Old," = "," AND") */
        due.book_num = :old.book_num;
    IF (NUMROWS > 0)
    THEN 
      raise_application_error(
        -20005,
        'Cannot update book because due exists.'
      );
    END IF;
  END IF;


-- ERwin Builtin 2021년 12월 2일 목요일 오전 10:18:31
END;
/


CREATE  TRIGGER tI_member BEFORE INSERT ON member for each row
-- ERwin Builtin 2021년 12월 2일 목요일 오전 10:18:31
-- INSERT trigger on member 
DECLARE NUMROWS INTEGER;
BEGIN
    /* ERwin Builtin 2021년 12월 2일 목요일 오전 10:18:31 */
    /* tb_zipcode  member on child insert restrict */
    /* ERWIN_RELATION:CHECKSUM="0000fee5", PARENT_OWNER="", PARENT_TABLE="tb_zipcode"
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
      
      NUMROWS = 0
    )
    THEN
      raise_application_error(
        -20002,
        'Cannot insert member because tb_zipcode does not exist.'
      );
    END IF;


-- ERwin Builtin 2021년 12월 2일 목요일 오전 10:18:31
END;
/

CREATE  TRIGGER tD_member AFTER DELETE ON member for each row
-- ERwin Builtin 2021년 12월 2일 목요일 오전 10:18:31
-- DELETE trigger on member 
DECLARE NUMROWS INTEGER;
BEGIN
    /* ERwin Builtin 2021년 12월 2일 목요일 오전 10:18:31 */
    /* member  due on parent delete restrict */
    /* ERWIN_RELATION:CHECKSUM="0000d50f", PARENT_OWNER="", PARENT_TABLE="member"
    CHILD_OWNER="", CHILD_TABLE="due"
    P2C_VERB_PHRASE="R/8", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_8", FK_COLUMNS="mem_id" */
    SELECT count(*) INTO NUMROWS
      FROM due
      WHERE
        /*  %JoinFKPK(due,:%Old," = "," AND") */
        due.mem_id = :old.mem_id;
    IF (NUMROWS > 0)
    THEN
      raise_application_error(
        -20001,
        'Cannot delete member because due exists.'
      );
    END IF;


-- ERwin Builtin 2021년 12월 2일 목요일 오전 10:18:31
END;
/

CREATE  TRIGGER tU_member AFTER UPDATE ON member for each row
-- ERwin Builtin 2021년 12월 2일 목요일 오전 10:18:31
-- UPDATE trigger on member 
DECLARE NUMROWS INTEGER;
BEGIN
  /* ERwin Builtin 2021년 12월 2일 목요일 오전 10:18:31 */
  /* member  due on parent update restrict */
  /* ERWIN_RELATION:CHECKSUM="0002006f", PARENT_OWNER="", PARENT_TABLE="member"
    CHILD_OWNER="", CHILD_TABLE="due"
    P2C_VERB_PHRASE="R/8", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_8", FK_COLUMNS="mem_id" */
  IF
    /* %JoinPKPK(:%Old,:%New," <> "," OR ") */
    :old.mem_id <> :new.mem_id
  THEN
    SELECT count(*) INTO NUMROWS
      FROM due
      WHERE
        /*  %JoinFKPK(due,:%Old," = "," AND") */
        due.mem_id = :old.mem_id;
    IF (NUMROWS > 0)
    THEN 
      raise_application_error(
        -20005,
        'Cannot update member because due exists.'
      );
    END IF;
  END IF;

  /* ERwin Builtin 2021년 12월 2일 목요일 오전 10:18:31 */
  /* tb_zipcode  member on child update restrict */
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
    
    NUMROWS = 0
  )
  THEN
    raise_application_error(
      -20007,
      'Cannot update member because tb_zipcode does not exist.'
    );
  END IF;


-- ERwin Builtin 2021년 12월 2일 목요일 오전 10:18:31
END;
/


CREATE  TRIGGER tD_tb_zipcode AFTER DELETE ON tb_zipcode for each row
-- ERwin Builtin 2021년 12월 2일 목요일 오전 10:18:31
-- DELETE trigger on tb_zipcode 
DECLARE NUMROWS INTEGER;
BEGIN
    /* ERwin Builtin 2021년 12월 2일 목요일 오전 10:18:31 */
    /* tb_zipcode  member on parent delete restrict */
    /* ERWIN_RELATION:CHECKSUM="0000e9ff", PARENT_OWNER="", PARENT_TABLE="tb_zipcode"
    CHILD_OWNER="", CHILD_TABLE="member"
    P2C_VERB_PHRASE="R/3", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_3", FK_COLUMNS="zipcode" */
    SELECT count(*) INTO NUMROWS
      FROM member
      WHERE
        /*  %JoinFKPK(member,:%Old," = "," AND") */
        member.zipcode = :old.zipcode;
    IF (NUMROWS > 0)
    THEN
      raise_application_error(
        -20001,
        'Cannot delete tb_zipcode because member exists.'
      );
    END IF;


-- ERwin Builtin 2021년 12월 2일 목요일 오전 10:18:31
END;
/

CREATE  TRIGGER tU_tb_zipcode AFTER UPDATE ON tb_zipcode for each row
-- ERwin Builtin 2021년 12월 2일 목요일 오전 10:18:31
-- UPDATE trigger on tb_zipcode 
DECLARE NUMROWS INTEGER;
BEGIN
  /* ERwin Builtin 2021년 12월 2일 목요일 오전 10:18:31 */
  /* tb_zipcode  member on parent update restrict */
  /* ERWIN_RELATION:CHECKSUM="00010978", PARENT_OWNER="", PARENT_TABLE="tb_zipcode"
    CHILD_OWNER="", CHILD_TABLE="member"
    P2C_VERB_PHRASE="R/3", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_3", FK_COLUMNS="zipcode" */
  IF
    /* %JoinPKPK(:%Old,:%New," <> "," OR ") */
    :old.zipcode <> :new.zipcode
  THEN
    SELECT count(*) INTO NUMROWS
      FROM member
      WHERE
        /*  %JoinFKPK(member,:%Old," = "," AND") */
        member.zipcode = :old.zipcode;
    IF (NUMROWS > 0)
    THEN 
      raise_application_error(
        -20005,
        'Cannot update tb_zipcode because member exists.'
      );
    END IF;
  END IF;


-- ERwin Builtin 2021년 12월 2일 목요일 오전 10:18:31
END;
/


CREATE  TRIGGER tI_due BEFORE INSERT ON due for each row
-- ERwin Builtin 2021년 12월 2일 목요일 오전 10:18:31
-- INSERT trigger on due 
DECLARE NUMROWS INTEGER;
BEGIN
    /* ERwin Builtin 2021년 12월 2일 목요일 오전 10:18:31 */
    /* book  due on child insert restrict */
    /* ERWIN_RELATION:CHECKSUM="0001e5af", PARENT_OWNER="", PARENT_TABLE="book"
    CHILD_OWNER="", CHILD_TABLE="due"
    P2C_VERB_PHRASE="R/4", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_4", FK_COLUMNS="book_num" */
    SELECT count(*) INTO NUMROWS
      FROM book
      WHERE
        /* %JoinFKPK(:%New,book," = "," AND") */
        :new.book_num = book.book_num;
    IF (
      /* %NotnullFK(:%New," IS NOT NULL AND") */
      
      NUMROWS = 0
    )
    THEN
      raise_application_error(
        -20002,
        'Cannot insert due because book does not exist.'
      );
    END IF;

    /* ERwin Builtin 2021년 12월 2일 목요일 오전 10:18:31 */
    /* member  due on child insert restrict */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="member"
    CHILD_OWNER="", CHILD_TABLE="due"
    P2C_VERB_PHRASE="R/8", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_8", FK_COLUMNS="mem_id" */
    SELECT count(*) INTO NUMROWS
      FROM member
      WHERE
        /* %JoinFKPK(:%New,member," = "," AND") */
        :new.mem_id = member.mem_id;
    IF (
      /* %NotnullFK(:%New," IS NOT NULL AND") */
      
      NUMROWS = 0
    )
    THEN
      raise_application_error(
        -20002,
        'Cannot insert due because member does not exist.'
      );
    END IF;


-- ERwin Builtin 2021년 12월 2일 목요일 오전 10:18:31
END;
/

CREATE  TRIGGER tU_due AFTER UPDATE ON due for each row
-- ERwin Builtin 2021년 12월 2일 목요일 오전 10:18:31
-- UPDATE trigger on due 
DECLARE NUMROWS INTEGER;
BEGIN
  /* ERwin Builtin 2021년 12월 2일 목요일 오전 10:18:31 */
  /* book  due on child update restrict */
  /* ERWIN_RELATION:CHECKSUM="0001d58d", PARENT_OWNER="", PARENT_TABLE="book"
    CHILD_OWNER="", CHILD_TABLE="due"
    P2C_VERB_PHRASE="R/4", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_4", FK_COLUMNS="book_num" */
  SELECT count(*) INTO NUMROWS
    FROM book
    WHERE
      /* %JoinFKPK(:%New,book," = "," AND") */
      :new.book_num = book.book_num;
  IF (
    /* %NotnullFK(:%New," IS NOT NULL AND") */
    
    NUMROWS = 0
  )
  THEN
    raise_application_error(
      -20007,
      'Cannot update due because book does not exist.'
    );
  END IF;

  /* ERwin Builtin 2021년 12월 2일 목요일 오전 10:18:31 */
  /* member  due on child update restrict */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="member"
    CHILD_OWNER="", CHILD_TABLE="due"
    P2C_VERB_PHRASE="R/8", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_8", FK_COLUMNS="mem_id" */
  SELECT count(*) INTO NUMROWS
    FROM member
    WHERE
      /* %JoinFKPK(:%New,member," = "," AND") */
      :new.mem_id = member.mem_id;
  IF (
    /* %NotnullFK(:%New," IS NOT NULL AND") */
    
    NUMROWS = 0
  )
  THEN
    raise_application_error(
      -20007,
      'Cannot update due because member does not exist.'
    );
  END IF;


-- ERwin Builtin 2021년 12월 2일 목요일 오전 10:18:31
END;
/

