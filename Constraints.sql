use practice_sql;

-- 제약조건 : 데이터베이스 테이블 컬럼의 삽입/수정/삭제 시 적용되는 규칙

-- not null 제약조건 : 해당 컬럼에 null을 포함하지 못하도록 제약
create table not_null_table(
	null_column int null,
    not_null_cloumn int not null
);

-- not null 제약 조건이 걸린 컬럼의 값을 지정하지 않음
insert into not_null_table (null_column) values(1);
-- not null 제약 조건이 걸린 컬럼에 null을 지정함
insert into not_null_table values(null, null);

insert into not_null_table values(1, 1);
insert into not_null_table values(null, 2);
insert into not_null_table (not_null_cloumn) values(2);

-- not null 제약조건이 걸린 컬럼은 null로 수정할 수 없음
-- (자기 자신 테이블 insert, update)
update not_null_table set not_null_cloumn = null;

-- unique 제약 조건 : 해당 컬럼에 중복된 데이터를 포함할 수 없도록 하는 제약 조건
create table unique_table(
	unique_column int unique,
    not_unique_column int
);

insert into unique_table values(1, 1);
-- unique로 지정된 컬럼은 중복된 데이터를 삽입할 수 없음
insert into unique_table values(1, 1);
insert into unique_table values(2, 1);

-- unique로 지정된 컬럼은 중복된 데이터로 수정할 수 없음
update unique_table set unique_column = 3;
update unique_table set unique_column = 1 where unique_column = 2;

-- not null + unique = 후보키
-- 키 : 테이블에서 각 레코드를 고유하기 식별할 수 있는 속성들
-- 기본키 : 테이블에서 각 레코드를 고유하게 식별하기 위해 후보키에서 선택한 속성
-- 대체키 : 후보키에서 기본키를 제외한 나머지 속성들

-- primary key 제약조건 : 특정 컬럼을 기본키로 지정
-- (insert, update)
create table key_table (
	primary_column int primary key,
    surrogate_column int not null unique
);

-- 기본키 제약 조건 : not null + unique 모두 만족해야 함
insert into key_table values(1, 1);
insert into key_table values (1, 2);

-- 기본키 제약을 두 개 이상 지정 불가
create table composite_table(
	primary1 int primary key,
    primary2 int primary key
);

create table composite_table(
	primary1 int,
    primary2 int,
    constraint primary_key primary key (primary1, primary2)
);

-- foreign key 제약 조건 : 특정 컬럼을 다른 테이블 혹은 같은 테이블의 기본키 컬럼과 연결하는 제약
-- 외래키 제약 조건을 특정 컬럼에 적용할 때는 반드시 데이터 타입이 참조 하고자 하는 컬럼의 타입과 일치해야 한다.
create table foreign_table(
	primary1 int primary key,
    foreign1 int,
    constraint foreign_key foreign key(foreign1)
    references key_table(primary_column)
);

-- 외래키 제약조건이 적용된 컬럼에는 참조하고 있는 테이블의 컬럼에 값이 존재하지 않으면 삽입, 수정이 불가능
insert into foreign_table values (1, 0);
insert into foreign_table values (1, 1);

update foreign_table set foreign1 = 2 where primary1 = 1;

-- 참조되어지고 있는 테이블의 레코드는 수정/삭제가 불가능
update key_table set primary_column = 2 where primary_column = 1;
delete from key_table where primary_column = 1;

-- 외래키 제약조건으로 참조되어지고 있는 테이블의 구조 변경 작업 불가능
drop table key_table;
alter table key_table modify column primary_column varchar(10);

-- on update / on delete 옵션
-- on update : 참조하고 있는 테이블의 기본키가 변경될 때 동작
-- on delete : 참조하고 있는 테이블의 기본키가 삭제될 때 동작

-- cascade : 참조되고 있는 테이블의 데이터가 삭제 또는 수정된다면, 참조하고 있는 테이블에서도 삭제/수정이 함께 일어남
-- set null : 참조하고 있는 테이블의 데이터가 삭제 또는 수정된다면, 참조하고 있는 테이블의 데이터는 널로 지정
-- restrict : 참조되고 있는 테이블의 데이터의 삭제 또는 수정을 불가능하게 함
create table optional_foreign_table(
	primary_column int primary key,
    foreign_column int,
    foreign key (foreign_column) references key_table (primary_column)
    on update cascade
    on delete set null
);

insert into optional_foreign_table values(1, 1);
select * from optional_foreign_table;

drop table foreign_table;

update key_table set primary_column = 2;

delete from key_table;

-- check 제약 조건 : 해당 컬럼에 값을 제한
create table check_table(
	primary_column int primary key,
    check_column varchar(5) check(check_column in('남', '여'))
);
-- check 제약 조건이 걸린 컬럼에 조건에 해당하지 않은 값을 삽입, 수정할 수 없다.
insert into check_table values (1, '남');
insert into check_table values (2, '남자');
update check_table set check_column = '여자';

-- default 제약 조건 : 해당 컬럼에 삽입시 값이 지정되지 않으면 기본값으로 지정하는 제약
create table default_table(
-- auto_increment : 기본키가 정수형일 때, 기본키의 값을 1씩 증가하는 값으로 자동 지정
	primary_column int primary key auto_increment,
    column1 int,
    default_column int default 10
);

insert into default_table (column1) values (99);