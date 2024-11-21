-- inner join
-- 두테이블 사이에 지정된 조건에 맞는 레코드만 반환. on조건을 통해 교집합찾기,
select * from author inner join post on author_id = post.author_id;
select * from post p inner join author a on p.author_id = a.id;

-- 출력순서만 달라지뿐 조회결과는 동일.
select * from post inner join author on author.id = author_id;

-- 글쓴이가 있는 글 목록과 글쓴이의 이메일만을 출력
-- post의 글쓴이가 없는 데이터는 포함X, 글쓴이중에 글을 한번도 안쓴사람 포함X
select p.* , a.email from post p inner join author a on a.id = author_id;

-- 글쓴이가 있는 글의 제목,내용, 그리고 글쓴이의 이메일만 출력하시오.
select p.title, p.contents, a.email from post p inner join author a on a.id = author_id;

-- 모든글목록을 출력하고, 만약에 글쓴이가 있다면 이메일 정보를출력

-- left outer join -> left join으로 생략가능
-- 글을 한번도 안쓴 글쓴이 정보는 포함X
select p.*, a.email from post p left join author a on a.id = p.author_id ;

--글쓴이를 기준으로 left join할경우, 글쓴이가 n개의 글을 쓸수 있으므로, 같은 글쓴이가 여러번 출력될수있음
-- author와 post가 1:n 관계이므로. 
-- 글쓴이가 없는 글은 포함X
select * from author a left join post p on a.id = p.author_id;

-- 실습) 글쓴이가 있는 글중에서 , 글의 title과 저자의 email만을 출력하되,
-- 저자의 나이가 30세 이상인 글만 출력 
select p.title, a.email from author a inner join post p on a.id = p.author_id where a.age >= 30;

-- 글의 내용과 글의 저자의 이름이 있는(not null), 글 목록을 출력하되, 2024-06 이후에 만들어진 글만 출력;
select p.* from post p left join author a on a.id = p.author_id where a.name is not null and p.contents is not null and p.created_time like '2024-06%';
select p.* from post p left join author a on a.id = p.author_id where a.name is not null and p.contents is not null and date_format(p.created_time,'%Y-%m' ) >= '2024-06-01';

-- 문제 https://school.programmers.co.kr/learn/courses/30/lessons/144854
select b.book_id as book_id,
 a.author_name as author_name,
  date_format(b.published_date, "%Y-%m-%d") as published_date 
from book b inner join author a on a.author_id = b.author_id 
where category = '경제' order by b.published_date;

-- union : 두 테이블의 select결과를 횡으로 결합(기본적으로 distinct 적용) 
-- 컬럼의 갯수와 컬럼의 타입이 같아야함에 쥬의
-- union all : 중복까지 모두 포함
select name,email from author union select title,contents from post

-- 서브쿼리 : select문 안에 또다른 select문을 서브쿼리라 한다.
-- where절 안에 서브쿼리
-- 한번이라도 글을쓴 author 목록조회
select distinct a.* from author a inner join post p on a.id = p.author_id; 
select * from author where id in(select author_id from post);

-- select절 안에 서브쿼리
-- author의 email과 author별로 본인이 쓴 글의 갯수를 출력
select a.email, (select count(*) from post where author_id = a.id) from author a; 

-- from절 안에 서브쿼리
select a.name from (select * from author) as a;

-- 없어진 기록 찾기 https://school.programmers.co.kr/learn/courses/30/lessons/59042
-- 서브쿼리
select * from animal_outs where animal_id not in (select animal_id from aninmal_ins)
-- join
SELECT o.ANIMAL_ID , name
from ANIMAL_OUTS o
left join ANIMAL_INS n  on n.ANIMAL_ID = o.ANIMAL_ID
where i.animal_id is null;
order by ANIMAL_ID

-- 집계함수
select count(*) from author;
select sum(price) from post;
select avg(price) from post;

--소수점 첫번째자리에서 반올림해서 소수점을 없앰
select round(avg(price),0) from post;

-- group by : 그룹화된 데이터를 하나의 행(row)처럼 취급
-- author_id로 그룹핑 하였으면, 그외의 컬럼을 조회하는 것은 적절치 않음
select author_id from post group by author_id;
-- group by 와 집계함수
-- 아래 쿼리에서 *은 그룹화된 데이터내에서의 갯수
select author_id, count(*) from post group by author_id;
select author_id, count(*), sum(price) from post group by author_id;

-- author의 email과 author별로 본인이 쓴 글의 갯수를 출력
--join과 group by, 집계함수 활용한 글의 개수 출력
select a.email, (select count(*) from post where author_id = a.id) from author a; 

select a.email, count(p.id)  
from author a 
left join post p on a.id = p.author_id
group by a.email;

-- where와 group by
-- 연도별 post 글의갯수 출력, 연도가 null인 값은 제외
select date_format(created_time,'%Y') as year , count(*) from post
where created_time is not null
group by year

-- 자동차 종류별 특정 옵션이 포함된 자동차 수 구하기
SELECT CAR_TYPE , COUNT(CAR_ID) as CARS
from CAR_RENTAL_COMPANY_CAR
where OPTIONS like '%통풍시트%' or
      OPTIONS like '%열선시트%' or
      OPTIONS like '%가죽시트%'
group by CAR_TYPE
order by CAR_TYPE
;
-- 입양 시각 구하기
SELECT date_format(DATETIME, '%H')as hour,count(*) as count 
from ANIMAL_OUTS
where DATE_FORMAT(DATETIME,'%H') >= 09 and  DATE_FORMAT(DATETIME,'%H') < 20
group by  hour order by hour
;
-- having : group by를 통해 나온 집계값에 대한 조건
-- 글을 2개 이상 쓴사람에 대한 정보 조회
select author_id from post group by author_id having count(*)>=2;
select author_id ,count(*)as count from post group by author_id having count>=2;

-- 동명 동물 수 찾기https://school.programmers.co.kr/learn/courses/30/lessons/59041
select name , count(*)as count from animal_ins where name is not null group by name having count >=1 order by name;

-- 다중열 group by
-- post에서 작성자별로 만든 제목의 갯수를 출력하세요.
select author_id,title,count(*) from post group by author_id, title;

-- 재구매가 일어난 상품과 회원 리스트 구하기 https://school.programmers.co.kr/learn/courses/30/lessons/131536
SELECT USER_ID, PRODUCT_ID from ONLINE_SALE
GROUP BY  USER_ID, PRODUCT_ID HAVING COUNT(*) >= 2  
ORDER BY USER_ID, PRODUCT_ID DESC;

