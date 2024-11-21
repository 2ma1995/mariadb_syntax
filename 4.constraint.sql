-- not null 제약조건 추가
alter table author modify column email VARCHAR(255) not null;

-- unique 제약조건 추가 (index가 설정됨/ 특정 컬럼에index)
alter table author modify column email VARCHAR(255) unique;
alter table author modify column email VARCHAR(255) not null unique;

create table post(id int ,title VARCHAR(255),content VARCHAR(255), author_id int not null,primary key(id), FOREIGN KEY(author_id)references author(id));

-- foreign key 제약조건 삭제 및 추가
-- 제약조건의 이름 확인 후 삭제 및 추가 가능
create table post(id int ,title VARCHAR(255) unique,content VARCHAR(255) not null, author_id int not null, FOREIGN KEY(author_id)references author(id));
-- 제약조건 조회
select * from information_schema.key_column_usage where table_name = 'post';
-- 제약조건 삭제
alter table post drop foreign key post_ibfk_1; -- 제약조건 조회후 나오는 foreign key 값 
-- 제약조건 추가

alter table post add constraint post_author_fk foreign key(author_id) references author(id);
-- alter table <table_name> add constraint
-- (ps. ADD CONSTRAINT는 새로운 제약조건을 테이블에 추가, post_author_fk는 새로 추가되는 외래 키 제약조건의 이름)


-- delete, update 관련 제약조건 테스트
-- on delete cascade 테스트
-- 제약조건 삭제
alter table post drop constraint post_author_fk;
-- 제약조건 추가
alter table post add constraint post_author_fk foreign key(author_id) references author(id) on delete cascade;

alter table post add constraint post_author_fk foreign key(author_id) references author(id) on update set null on update set null;
-- default옵션
alter table author modify column name varchar(255) default 'anonymous';
-- auto_increment //pk(id)값 자동적으로 올라감
alter table author modify column id bigint auto_increment;
alter table post modify column id bigint auto_increment;

-- UUID (auto 인크립트시키는 문법)
alter table post add column user_id char(36) default (UUID());