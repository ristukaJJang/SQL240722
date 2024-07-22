-- 카타르 아시안컵 데이터베이스alter
-- 참가 국가(국가명, 조, 감독, 피파랭킹)
-- 선수(이름, 나이, 포지션, 등번호, 소속팀)
-- 경기장(이름, 수용인원, 주소)
-- 심판(이름, 나이, 국적, 포지션)

-- 1. 카타르 아시안컵 데이터베이스 생성
-- qatar_asian_cup
create database qatar_asian_cup;
use qatar_asian_cup;

-- 2. 개발자 계정 생성
-- 사용자명 : qatar_developer / 접근 위치 : (모든 곳에서 접근 가능)% / 비밀번호 : qatar123
create user 'qatar_developer'@'%' identified by 'qatar123';

-- 3. 테이블 생성
-- country : name[varchar30], group_name[varchar5], manager[varchar30], rankikg[int]
-- player : name[varchar30], age[int], position[varchar10], uniform_number[int], country[varchar30]
-- stadium : name[varchar50], volume[int], address[text]
-- referee : name[varchar30], age[int], country[varchar30], position[varchar 10]
create table country(
	name varchar(30),
    group_name varchar(5),
    manager varchar(30),
    ranking int
);
create table player(
	name varchar(30),
    age int,
    position varchar(10),
    uniform_number int,
    country varchar(30)
);
create table stadium(
	name varchar(50),
    volume int,
    address text
);
create table referee(
	name varchar(30),
    age int,
    country varchar(30),
    position varchar(10)
);