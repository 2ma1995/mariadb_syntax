-- 용량에 따라 표현범위 달라짐
-- byte 체계
-- 8bit -> 1byte
-- 1024byte -> mariadbmb-> gb -> tb
-- bit -> byte -> kb -> mb -> gb -> tb

-- tinyint는 -128~127 까지 표현(1byte 할당)
-- author 테이블에 age 컬럼 추가
alter table author add column age tinyint;
-- data insert 테스트:200살  insert
alter table author modify column age tinyint;
insert into author (id, age) values(5,200);

-- decimal실습
-- decimal(정수부자릿수,소수부자릿수)
alter table post add column price decimal(10,3);
-- decimal 소수점 초과후  값 짤림 현상
insert into post(id, title,price) values(4,'java programming',10.33345);

-- 문자열실습
alter table author add column self_initroduction text;
insert into author(id, self_initroduction) values(6,'안녕하세요');

-- blob(바이너리데이터) 타입 실습 // 실무에선 이미지위치만 저장한다.
alter table author add column profile_image longblob;
insert into author (id, profile_image) values(7,LOAD_FILE('C:\Users\Playdata\Desktop\BIRD.png'));

-- ENUM : 삽입될 수 있는 데이터의 종류를 한정하는 데이터 타입
-- roll컬럼추가
alter table author add column role ENUM('user','admin') not null default 'user';
-- user값 세팅후 insert
insert into author (id, role) values (8,'user');
-- user값 세팅 후 insert('잘못된 값)
insert into author (id, name, email) values (9,'ganggang', 'gang@naver.com');
-- 아무것도 안넣고 insert(default 값)

-- date : 날찌, datetime:날짜 및 시분초(microseconds) //current_timestamp() => sql내장 함수 현재시간기준
alter table post add column created_time datetime default current_timestamp();
-- datetime은 입력,수정,조회시에 문자열 형식을 활용
update post set created_time = '2024-11-18 19:12:16' where id=3;

-- 조회시 비교연산자
select * from author where id >= 2 and id <= 4; == select * from author where id between 2 and 4;--between 2와4를 포함한다.
select * from author where id not(id < 2 or id > 4);
select * from author where id in(2,3,4);
-- select * from author where id in(select author_id from post);
select * from author where id not in(1,5); --가정)전체데이터가 1~5까지 밖에 없음.
