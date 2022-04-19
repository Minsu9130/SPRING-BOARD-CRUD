create table board(
no         number         primary key,
title      varchar2(100)  not null,
name       varchar(20)    not null,
content    clob           not null,
regdate    varvhar2(100)  default sysdate,
readcount  number         default 0,
password   varchar2(128)  not null
);

create sequence board_no_seq;

CREATE TABLE attach_file 
( uuid          VARCHAR2(100) NOT NULL,
  uploadPath    VARCHAR2(200) NOT NULL,
  fileName      VARCHAR(100)  NOT NULL, 
  fileType      CHAR(1)       default 0,         
  bno           NUMBER        NOT NULL,
  CONSTRAINT file_uuid_pk PRIMARY KEY (uuid),
  CONSTRAINT file_bno_fk FOREIGN KEY(bno) REFERENCES board(no) ON DELETE CASCADE,
  CONSTRAINT type_boolean CHECK(fileType IN ('0', '1'))
);

drop table attach_file;


create table reply_board (
    bno number not null ,
    rno number not null,
    content varchar2(1000) not null,
    writer varchar2(50) not null,
    regdate date default sysdate,
    primary key(bno, rno)
);

alter table reply_board add constraint reply_bno_fk foreign key(bno)
references board(no) ON DELETE CASCADE;

create sequence reply_board_seq START WITH 1 MINVALUE 0;


begin
for i in 1..100 loop
insert into board
     (no, title, name, password, content, regdate, readcount)
     values(board_no_seq.nextval, '제목','작성자','1111','내용..',
     sysdate, trunc(dbms_random.value(0, 100)));
  end loop;
end;
/

commit;

CREATE TABLE tb1_member (
    userid      VARCHAR2(50) NOT NULL,
    userpw      VARCHAR2(100) NOT NULL,
    username    VARCHAR2(100) NOT NULL,
    regdate     DATE DEFAULT sysdate,
    updatedate  DATE DEFAULT sysdate,
    enabled     CHAR(1) DEFAULT '1'
)

CREATE TABLE ace.tb1_member_auth (
    userid  VARCHAR2(50) NOT NULL,
    auth    VARCHAR2(50) NOT NULL,
    constraint fk_member_auth foreign key(userid) references tb1_member(userid) 
)



