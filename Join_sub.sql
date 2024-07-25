use practice_sql;
create table employee(
	employee_number int primary key auto_increment,
    name varchar(10),
    age int,
    department_code varchar(2)
    
);

create table department(
	department_code varchar(2) primary key,
    name varchar(30),
    tel_number varchar(15)
);

alter table employee add constraint department_code_fk 
foreign key (department_code) references department(department_code);

alter table employee drop constraint department_code_fk;

insert into department values ('A', '영업부', '123456');
insert into department values ('B', '재무부', '123457');
insert into department values ('C', '행정부', '123458');

insert into employee(name, age, department_code) values ('홍길동', 23, 'A');
insert into employee(name, age, department_code) values ('이영희', 15, 'A');
insert into employee(name, age, department_code) values ('고길동', 34, 'C');
insert into employee(name, age, department_code) values ('김둘리', 20, 'D');
insert into employee(name, age, department_code) values ('이도', 17, 'D');

select * from employee;
select * from department;

-- Alias : 쿼리문에서 사용되는 별칭
-- 컬럼 및 테이블에서 사용 가능
-- 사용하는 컬럼의 이름을 바꾸고 싶을 때 적용
select 
	department_code as '부서코드',
	name as '부서명',
	tel_number as '부서 전화번호'
from department;

-- as 키워드 생략 가능
select 
	dpt.department_code '부서코드',
	dpt.name '부서명',
	dpt.tel_number '부서 전화번호'
from department dpt;

-- join : 두 개 이상의 테이블을 특정 조건에 따라 조합하여 결과를 조회하고자 할 때 사용하는 명령어

-- INNER JOIN : 두 테이블에서 조건이 일치하는 레코드만 반환
-- select column, ... from 기준테이블 inner join 조합테이블 on 조인조건
select * 
from employee as E inner join department as D 
on E.department_code = D.department_code;

select 
	E.employee_number '사번',
    E.name '사원이름',
    E.age '나이',
    E.department_code '부서코드',
    D.name '부서명',
    D.tel_number '부서 전화번호'
from employee E inner join department D
on E.department_code = D.department_code;

-- left outer join(left join) : 기준 테이블의 모든 레코드와 조합할 테이블 중 조건에 일치하는 레코드만 반환
-- 만약에 조합할 테이블에 조건에 일치하는 레코드가 존재하지 않으면 null로 표현
select 
	E.employee_number '사번',
    E.name '사원이름',
    E.age '나이',
    E.department_code '부서코드',
    D.name '부서명',
    D.tel_number '부서 전화번호'
from employee E left join department D
on E.department_code = D.department_code;

-- right outer join(right join) : 조합할 테이블의 모든 레코드와 기준 테이블 중 조건에 일치하는 레코드만 반환
-- 만약에 기준 테이블에 조건에 일치하는 레코드가 존재하지 않으면 널로 반환 
select 
	E.employee_number '사번',
    E.name '사원이름',
    E.age '나이',
    E.department_code '부서코드',
    D.name '부서명',
    D.tel_number '부서 전화번호'
from employee E right join department D
on E.department_code = D.department_code;

-- full outer join(full join) : 기준 테이블의 모든 레코드와 조합할 테이블의 모든 레코드를 합쳐서 반환
-- 만약 기준 테이블 혹은 조합할 테이블에 조건에 일치하는 레코드가 존재하지 않으면 널로 반환
-- mysql에서는 full join을 문법상 제공하지 않음
-- full join = left join + right join 
select 
	E.employee_number '사번',
    E.name '사원이름',
    E.age '나이',
    E.department_code '부서코드',
    D.name '부서명',
    D.tel_number '부서 전화번호'
from employee E left join department D
on E.department_code = D.department_code
union (select 
	E.employee_number '사번',
    E.name '사원이름',
    E.age '나이',
    E.department_code '부서코드',
    D.name '부서명',
    D.tel_number '부서 전화번호'
from employee E right join department D
on E.department_code = D.department_code);

-- cross join : 기준 테이블의 각 레코드를 조합할 테이블의 모든 레코드에 조합하여 반환
-- cross join 결과 레코드 수 = 기준 테이블 레코드 수 * 조합할 테이블의 레코드 수
-- mysql에서 기본 조인이 cross join 형태임
select * from employee E cross join department D;
select * from employee E join department D;
select * from employee E, department D;
-- 셋다 같은 표현

-- 부서코드가 A인 사원에 대해 사번, 이름, 부서명을 조회하시오
select 
	E.employee_number '사번', 
    E.name '이름', 
    D.name '부서명'
from employee E inner join department D
on E.department_code = D.department_code
where E.department_code = 'A';

-- 부서명이 '영업부'인 사원에 대해 사번, 이름, 나이를 조회하시오
select 
	E.employee_number '사번',
    E.name '이름',
    E.age '나이'
from employee as E inner join department as D
on E.department_code = D.department_code
where D.name = '영업부';

-- 서브쿼리 : 쿼리 내부에 존재하는 또 다른 쿼리
-- 쿼리 결과를 조건이나 테이블로 사용할 수 있도록 함

-- where 절에서 서브쿼리 : 쿼리 결과를 조건으로 사용하여 조건을 동적으로 지정할 수 있음
-- where 절에서 비교 연산 등으로 사용할 때 조회하는 컬럼의 개수 및 레코드의 개수 주의
select employee_number, name, age
from employee
where department_code in (
	select department_code
    from department
);

select employee_number, name, age from employee 
where department_code = (
	select department_code
	from department
	where name = '영업부'
);

-- from 절에서 서브쿼리 : 조회 결과 테이블을 다시 from 절에서 재사용
select * from department where name = '영업부'; 
select 
	E.employee_number '사번',
    E.name '이름',
    E.age '나이'
from employee E inner join (
	select * from department
    where name = '영업부'
) D
on E.department_code = D.department_code;

-- 서브쿼리를 from 절에서 사용할 땐 반드시 별칭을 사용해야 함
select * 
from (
	select * from department
) D 
where name = '영업부';