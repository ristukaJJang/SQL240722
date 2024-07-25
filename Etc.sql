use practice_sql;

-- 조건문
-- case : 특정 값을 비교하여 일치하는 작업을 수행
-- case 컬럼 
-- when 비교값1 then 비교값1과 컬럼이 일치할 때 결과
-- when 비교값2 then 비교값2와 컬럼이 일치할 때 결과
-- else 비교값1과 비교값2가 모두 컬럼과 일치하지 않을 때
-- end

-- case
-- 	when 조건1 then 조건1이 참일 때 결과	
--  when 조건2 then 조건2가 참일 때 결과
--  when 조건1과 조건2가 모두 거짓일 때 결과
--  end

select date, (
	case
		when amount > 100000 then '고액'
        else '소액'
	end
) '금액'
from sale;

-- if 함수 : 첫번째 매개변수로 전달한 표현식에 따라 결과를 반환하는 함수
-- if (조건, 참일 때 결과, 거짓일 때 결과)
select date, if(amount > 100000, '고액', '소액') '금액' from sale;

-- ifnull 함수 : 첫번째 매개변수의 값이 널인지에 따라 결과를 반환하는 함수
-- ifnull (값, 값이 널일때 반환할 결과) 
select 사번, 사원 이름, ifnull(부서명, '없음') from employee_view;

-- 문자열 함수 : 문자열 조작을 도와주는 함수들

-- length(문자열) : 문자열의 길이를 반환
select length(name) from employee;

-- concat(문자열, ...) : 매개변수로 전달받은 문자열들을 결합
-- 매개변수 중 하나라도 널이면 널을 반환
select concat(사원 이름, 부서명) from employee_view;

-- left(문자열), right(문자열) : 문자열을 왼쪽, 오른쪽에서부터 추출
select left(name, 2), right(name, 2) from employee;

-- replace(기존문자열, 바꿀문자열) : 특정 문자열을 지정한 문자열로 변경하는 함수
select replace(name, '길동', '순자') from employee;