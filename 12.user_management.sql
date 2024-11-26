-- 사용자 관리
-- 사용자 목록 조회
select * from mysql.user;
-- 사용자 생성
-- %는 원격포함한 anywhere 접속
create user '계정명'@'localhost' identified by '비밀번호';
-- 예시
create user 'soby'@'localhost' identified by '4321';
create user 'soby'@'%' identified by '4321';-- %활용 예시
-- 사용자에게 select 권한 부여
grant select on board.author to 'soby'@'localhost';
-- 사용자 권한 회수
revoke select on board.author from 'soby'@'localhost';
-- 사용자 계정 삭제
drop user 'soby'@'localhost';
-- 사용자 권한 확인
show grants for 'soby'@'localhost';