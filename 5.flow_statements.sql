-- case문
select 컬럼1, 컬럼2, 컬럼3,
-- if(컬럼4==비교값1){결과값1출력}else if(컬럼4==비교값2){결과값2출력}else{결과값3출력}
case 컬럼4
    when 비교값1 then 결과값1
    when 비교값2 then 결과값2
    else 결과값3
end
from 테이블명;
-- 예제
select id, email,
case  
    when name is null then '익명사용자'
    else name
end
from author;

-- ifnull(name,b) : 만약에 a가 null이면 b반환 , null이 아니면 a반환
select id,email, ifnull(column,'익명사용자') as '사용자명' from author;
select id,email, ifnull(name,'익명사용자') as '사용자명' from author;

-- if(a,b,c) : a조건이 참이면 b반환, a가 거짓이면 c반환
select id, email, if(name is null, '익명사용자', name) as '사용자명' from author;
-- -- -- -- 문제 (프로그래머스)
-- SELECT BOARD_ID, WRITER_ID, TITLE, PRICE,
--        CASE 
--            WHEN STATUS = 'SALE' THEN '판매중'
--            WHEN STATUS = 'RESERVED' THEN '예약중'
--            ELSE '거래완료'  
--            END AS STATUS
-- FROM USED_GOODS_BOARD
-- where CREATED_DATE = '2022-10-05'
-- ORDER BY BOARD_ID DESC;

-- -- 선생님답
-- SELECT BOARD_ID, WRITER_ID, TITLE, PRICE,
--        CASE STATUS
--            WHEN  'SALE' THEN '판매중'
--            WHEN  'RESERVED' THEN '예약중'
--            ELSE '거래완료'  
--            END AS STATUS
-- FROM USED_GOODS_BOARD
-- where CREATED_DATE = '2022-10-05'
-- ORDER BY BOARD_ID DESC;
-- -- -- --

-- SELECT PT_NAME,PT_NO,GEND_CD,AGE,
-- if(TLNO is null, 'NONE',TLNO) as TLNO
-- from PATIENT 
-- where (AGE <= 12)
-- order by AGE desc;

-- -- 선생님답
-- SELECT PT_NAME,PT_NO,GEND_CD,AGE,
-- ifnull(TLNO, 'NONE')
-- from PATIENT 
-- where AGE <= 12 and GEND_CD='W'
-- order by AGE desc, PT_NAME;
