use practice_sql;
create table sale(
	sequence_number int primary key auto_increment,
    date DATE,
    amount int,
    employee_number int
);
insert into sale(date, amount, employee_number) values ('2024-07-01', 100000, 1);
insert into sale(date, amount, employee_number) values ('2024-07-01', 120000, 2);
insert into sale(date, amount, employee_number) values ('2024-07-01', 60000, 1);
insert into sale(date, amount, employee_number) values ('2024-07-03', 200000, 1);
insert into sale(date, amount, employee_number) values ('2024-07-03', 170000, 3);
insert into sale(date, amount, employee_number) values ('2024-07-06', 100000, 2);
insert into sale(date, amount, employee_number) values ('2024-07-06', 160000, 3);
insert into sale(date, amount, employee_number) values ('2024-07-07', 80000, 1);
insert into sale(date, amount, employee_number) values ('2024-07-08', 90000, 2);
insert into sale(date, amount, employee_number) values ('2024-07-08', 110000, 3);
select * from sale;

-- 집계 함수 : 여러 행의 레코드를 종합하여 하나의 결과값을 반환

-- count() : 특정 조건에 해당하는 레코드의 개수 반환
select count(*) from sale;
select count(*) from sale where amount <= 100000;
select count(amount) from sale;

-- sum() : 특정 조건에 해당하는 컬럼의 값을 모두 더한 결과를 반환
select sum(amount) from sale;
select sum(amount) from sale where employee_number = 1;

-- avg() : 특정 조건에 해당하는 컬럼의 값의 평균을 반환
select avg(amount) from sale;
select avg(amount) from sale where employee_number = 1;

-- max(), min() : 특정 조건에 해당하는 컬럼값의 최대 최소값을 반환
select max(amount), min(amount) from sale;

-- 그룹화(group by) : 조회 결과에 대해 레코드를 하나 이상의 컬럼으로 그룹화하여 결과를 도출하는 것
-- 일반적으로 집계함수와 함께 사용됨
select avg(amount), employee_number
from sale
group by employee_number;

-- 집계 함수가 포함되어 있는 쿼리 혹은 그룹화가 되어 있는 쿼리에서는 
-- 그룹화한 컬럼과 집계함수를 제외한 컬럼은 select 절에서 사용이 불가능
select avg(amount), date
from sale
group by employee_number;

-- 필터링(having) : 그룹화된 결과에 필터링 작업 수행
-- 주의!! where 절과 사용 방법이 비슷하지만, where 절은 조회할 때 사용, having 절은 조회 결과에 사용
select 
	avg(amount) '평균', 
    employee_number '사번' 
from sale
group by employee_number
having avg(amount) < 110000;

-- 결과 테이블에 존재하지 않는 컬럼은 having 절에서 사용할 수 없음
select 
	avg(amount) '평균', 
    employee_number '사번' 
from sale
where date < '2024-07-05'
group by employee_number;
