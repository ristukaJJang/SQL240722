# 주석 달기
-- 주석 달기

-- 데이터 정의어(DDL)
-- 데이터베이스, 테이블, 사용자 등(스키마)을 정의하는데 사용 

-- CREATE : 구조를 생성하는 명령어
-- CREATE 생성할구조 구조이름 [... 구조의 정의]

create database practive_sql;

-- 데이터베이스 사용 : 데이터베이스 작업을 수행하기 전에 반드시 작업할 데이터베이스를 선택해야 함
use practive_sql;

-- 테이블 생성
create table example_table(
	example_column1 int, 
    example_column2 boolean
);

-- 사용자 생성
-- 사용자 이름으로 구분하는 것이 아닌, IP주소로 구분한다.
-- create user '사용자명'@'접속IP' IDENTIFIED BY '비밀번호'
CREATE USER 'developer'@'127.0.0.1' identified by 'P!ssw0rd';

-- '%'는 어느 사용자든 접근 가능하도록 하는 wildcard
CREATE USER 'developer'@'%' identified by 'P!ssw0rd';

-- 컬럼 데이터 타입
create table data_type(
	-- 1. int : 정수 타입
    int_column int,
    -- 2. double : 실수 타입
    double_column double,
    -- 3. float : 실수 타입
    float_column float,
    -- 4. boolean : 논리 타입
    boolean_column boolean,
    -- 5. varchar(문자열길이) : 가변길이 문자열
    strring_column varchar(10),
    -- 6. text : 문자열
    text_column text,
    -- 7. date : 날짜
    date_column DATE,
    -- 8. datetime : 날짜 및 시간
    datetime_column datetime
);

