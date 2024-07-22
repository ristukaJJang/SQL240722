-- 데이터 조작어(DML)
-- 테이블에 레코드를 삽입, 조회, 수정, 삭제할 때 사용

-- insert : 테이블에 레코드를 삽입하는 명령어

-- 1. 모든 컬럼에 대하여 삽입
-- insert into 테이블명 values(data1, data2, ...);
-- 테이블 구조의 컬럼 순서에 맞게 데이터 입력해야 함.

use practice_sql;
insert into example_table values ('데이터1', '데이터2');

-- 2. 특정 컬럼을 선택하여 삽입
-- insert into 테이블명 (컬럼명1, 컬럼명2, ...) values (데이터1, 데이터2, ...);
-- 지정한 컬럼의 순서와 데이터의 순서가 일치해야 한다.
insert into example_table(example_column2) values ('선택 데이터1');

-- select : 테이블에서 레코드를 조회할 때 사용하는 명령어

-- 1. 모든 데이터 조회 : select * from 테이블명;
select * from example_table;

-- 2. 특정 컬럼 선택 조회 : select 컬럼명1, 컬럼명2, ... from 테이블명;
select example_column2 from example_table;

-- 3. 특정 레코드 선택 조회 : select 조회할컬럼 from 테이블명 where 조건;
select example_column2 from example_table where example_column2 = '데이터2';

-- update : 테이블에서 레코드를 수정할 때 사용하는 레코드
-- update 테이블명 set 컬럼명1 = 데이터1, ... ;
-- update 테이블명 set 컬럼명1 = 데이터1, ... where 조건;
update example_table set column1 = '수정 데이터'; 
update example_table set column1 = '선택 수정 데이터' where example_column2 = '데이터2';

-- delete : 테이블에서 레코드를 삭제할 때 사용하는 명령어
-- delete from 테이블명 where 조건;
delete from example_table where example_column2 = '선택 데이터1';

-- delete from 테이블명
delete from example_table;

create table auto_table (
	idx int PRIMARY KEY AUTO_INCREMENT,
    num int
);

insert into auto_table (num) values (0);
select * from auto_table;

delete from auto_table;

truncate table auto_table;

-- drop table : DDL 테이블 구조 전체를 제거
-- truncate table : DDL 테이블 구조만 남기고 상태를 초기화
-- delete from : DML 테이블 레코드만 제거

-- insert into select : 삽입 작업시에 조회 결과를 사용하여 삽입
insert into example_table 
select * from example_table
where column1 is null;

insert into example_table values ('데이터5', '데이터6');

-- update select : 수정 작업 시 조회 결과를 사용하여 수정(수정 값에 대하여)
update example_table A set A.column1 = (select B.num from auto_table B where B.idx = 1); 