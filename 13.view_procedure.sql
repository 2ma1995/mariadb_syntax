-- view : 실제 데이터를 참조만 하는 가상의 테이블
-- 사용목적 1)복잡한 쿼리 대신 2)테이블의 컬럼까지 권한 분리

-- view생성
create view author_for_marketing as select name, email from author;
-- view 조회
select * from author_for_marketing;
-- view 권한부여
grant select on board.author_for_marketing to '계정명'@'localhost';
-- view 삭제
drop view author_for_marketing;

-- 프로시저 생성
DELIMITER //

CREATE PROCEDURE hello_procedure()
BEGIN
    SELECT 'hello world';
END //

DELIMITER ;
-- 프로시저 호출
call hello_procedure();
-- 프로시저 삭제
drop procedure hello_procedure;

-- 게시글 목록 조회 프로시저 생성
DELIMITER //

CREATE PROCEDURE 게시글목록조회()
BEGIN
    SELECT * from post;
END //

DELIMITER ;
-- 게시글 목록 조회
call 게시글목록조회();

-- 게시글 id단건 조회
DELIMITER //

CREATE PROCEDURE 게시글id단건조회(in postid bigint)
BEGIN
    SELECT * from post where id = postid;
END //

DELIMITER ;

CALL 게시글id단건조회(1)
-- 게시글목록조회byemail
DELIMITER //
CREATE PROCEDURE 게시글목록조회byemail(in inputEmail varchar(255))
BEGIN
    SELECT p.id,p.title,p.content from post p
    join board.author a on p.id = a.id
    where a.email = inputEmail;
END //
DELIMITER ;

-- 글쓰기
DELIMITER //
DELIMITER //
CREATE PROCEDURE 글쓰기(in inputTitle varchar(255), in inputContents varchar(255),in inputEmail varchar(255))
BEGIN
    DECLARE authorID bigint;
    DECLARE postId bigint;
    insert into post(title, content) values(inputTitle,inputContents);
    select id into postId from post order by id desc limit 1;
    select id into authorId from author where email = inputEmail;
    insert into author_post(author_id,posted_id)values(authorId,postId);
END //
DELIMITER ;


-- 글삭제 : 입력값으로 글id, 본인email

DELIMITER //
CREATE PROCEDURE 글삭제(in inputPostId bigint, in inputEmail varchar(255))
BEGIN
    DECLARE authorPostCount bigint;
    DECLARE authorId bigint;
    select COUNT(*) into authorPostCount from author_post where posted_id = inputPostId;
    select id into authorId from author where email = inputEmail;
    if authorPostCount>=2 then
    -- elseif까지 사용 가능
    delete from author_post where posted_id=inputPostId and author_id = authorId;
    else
        delete from author_post where posted_id=inputPostId and author_id = authorId;
        delete from post where id = inputPostId;
    end if;
END //
DELIMITER ;

-- 반복문을 통해 post대량생성 : title, 글쓴이email


DELIMITER //
CREATE PROCEDURE 글도배(in count int, in inputEmail varchar(255))
BEGIN
    DECLARE countValue int default 0;
    DECLARE authorID bigint;
    DECLARE postId bigint;
    WHILE countValue < count
    -- post테이블에 insert
    insert into post(title, content) values('안녕하세요');
    select id into postId from post order by id desc limit 1;
    select id into authorId from author where email = inputEmail;
    -- author_post 테이블 insert : author_id, post_id
    insert into author_post(author_id,posted_id)values(authorId,postId);
        SET countValue+=1;
    END WHILE
END //
DELIMITER ;

