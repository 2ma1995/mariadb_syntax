-- mariadb 서버에 접속
mariadb -u root -p

------ 중요 -------
-- board 는 테이블명
-- 스키마(databases) 목록조회
show databases;

--스키마(databases) 생성->중요
CREATE DATABASE board;
--스키마(databases) 삭제
DROP DATABASE board;

--데이터베이스 선택->중요
use board;

--테이블목록조회->중요
show tables;
------------------

--문자 인코딩 조회
show variables like 'character_set_server';

--문자인코딩 변경
alter database board default character set = utf8mb4;

--테이블 생성 ->중요
CREATE TABLE author(id INT PRIMARY KEY, name VARCHAR(255), email VARCHAR(255), password VARCHAR(255));

--테이블 컬럼조회 ->중요
describe author;

--테이블컬럼 상세조회
show full columns from author;

-- 테이블 생성명령문 조회
show create table author;

-- post테이블 신규생성(id,, title, content, author_id)->중요
create table post(id int PRIMARY KEY,title VARCHAR(255),content VARCHAR(255), author_id int not null, FOREIGN KEY(author_id)references author(id));
-- 테이블 index(성능향상 옵션) 조회
show index from author;

--alter문: table의 구조를 변경
-- 테이블의 이름변경
alter table post rename 
-- 테이블 컬럼추가
alter table author add column age int;
-- 테이블 컬럼 삭제
alter table author drop column age;
-- 테이블 컬럼명 변경
alter table post change column content contents VARCHAR(255);
-- 테이블 컬럼 타입과 제약조건 변경(옵션변경) ->중요(덮어쓰기 됨에 유의)
alter table author modify column email VARCHAR(100) not null;
  -- 연결해서사용시
  alter table author modify column email VARCHAR(100) not null, modify column content VARCHAR(100) not null;
-- 테이블 삭제
show create table post;
drop table post;
