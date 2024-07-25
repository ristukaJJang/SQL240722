use practice_sql; 

-- 인덱스(index) : 테이블에서 원하는 컬럼을 빠르게 조회하기 위해 사용하는 구조

-- 인덱스 생성 : create index 인덱스이름 on 테이블명(컬럼, ...);
create index employee_name_idx on employee(name);
create index employee_name_age_idx on employee(name, age);
create index employee_name_desc_idx on employee(name desc);

-- 테이블에 인덱스 추가
-- alter table 테이블명 add index 인덱스명(컬럼명);
alter table sale add index amount_index(amount);

-- 인덱스 삭제
-- drop index 인덱스명 on 테이블명;
drop index employee_name_idx on employee;

-- 테이블에서 인덱스 삭제
-- alter table 테이블명 drop index 인덱스명;
alter table employee drop index employee_name_age_idx;

-- 뷰(View) : 물리적으로 존재하지 않는 읽기 전용 가상 테이블
-- 조회문을 미리 작성해서 재사용하는 용도, 컬럼에 대한 제한된 보기를 제공하는 용도

-- 뷰 생성
-- create view 뷰이름 as select ... ;
create view employee_view as 
select
	E.employee_number '사번',
	E.name '사원 이름',
    E.department_code '부서 코드',
    D.name '부서명',
    D.tel_number '부서 전화번호'
from employee E left join department D
on E.department_code = D.department_code
order by 부서명;

select * from employee_view;
-- view는 물리적으로 데이터가 저장되는 것이 아니기 때문에 insert, update, delete, 인덱스 생성 불가

-- view 수정
-- alter view 뷰이름 as select ... ;
alter view employee_view as
select
	E.employee_number '사번',
	E.name '사원 이름',
    D.name '부서명',
    D.tel_number '부서 전화번호'
from employee E left join department D
on E.department_code = D.department_code
order by 부서명;

-- view 삭제
drop view 뷰이름;
drop view employee_view;