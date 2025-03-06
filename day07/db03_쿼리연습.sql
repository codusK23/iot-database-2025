-- WorkBook : SQL Practice
/* toavmf - Employee에서 사원번호, 이름, 급여, 업무, 입사일, 상사의 사원번호를 출력하시오.
			이 때 이름과 성을 연결하여 Full Name이라는 별칠으로 출력하시리 (107행)
*/

/*
SELECT employee_id
	 , CONCAT(first_name, ' ', last_name) AS 'Name'
     , job_id AS 'Job'
     , hire_data
     , manahar_id
     from employees;
 */    
/* 문제1 employee레ㅛㅏ */
SELECT CONCAT(first_name, ' ', last_name) AS 'Name'
	 , job_id AS 'Job'
     , salary AS 'Salary'
     , (salary * 12) + 100 AS 'Increased Ann_Salary'
     , (salary + 100) * 12 AS 'Increased Salary'
  FROM employees;

/* 문제2 - Employees에서 모든 사원의 last_name과 연봉을 '이름: 1 Year Salary = $연봉' 형식으로 출력하고 1 Year Salary라는 별칭을 붙이세요.(107행)
*/
SELECT CONCAT(last_name, '1 Year Salary = $', (salary * 12)) AS '1 Year Salary'
  FROM employees;
  
/* 문제3 - 부서에 담당하는 업무를 한번씩만 출력하시오.(20행)
*/
SELECT DISTINCT department_id, job_id
  FROM employees;

-- WHERE, ORDER BY
/* 샘플 - hr부서 예산 편성 문제로 급여 정보 보고서를 작성한다. employees에서 salary가 7000 ~ 10000달러 범위 이외의 사람의
		  성과 이름을 Name 해서 급여가 작은 순서로 출력하시오.(75행) */
          
SELECT CONCAT(first_name, ' ', last_name) AS 'name'
	 , salary
  FROM employees
 WHERE salary NOT BETWEEN 7000 AND 10000
 ORDER BY salary;
 
/* 문제1 - 사원의 last_name 중 e나 o글자를 포함한 사원을 출력하시오. 이때 컬럼명은 e AND o NAME 이라고 출력하시오. (10행)
*/
SELECT last_name AS 'e AND o NAME'
  FROM employees
 WHERE last_name LIKE '%e%' AND last_name LIKE '%o%';
 
/* 문제2 - 현재 날짜 타입을 날짜함수를 통해 확인, 1995년 5월 20일 ~ 1996년 5월 20일 사이 입사한 사원의 이름 Name으로 별칭
			사원번호, 고용일자를 출력하시오. 단, 입사일이 빠른 순으로 정렬하시오.(8행)
*/
SELECT date_add(sysdate(), INTERVAL 9 HOUR) AS 'sysdate()';

DESC employees;

SELECT last_name AS 'name'
	 , employee_id
     , hire_date
  FROM employees
 WHERE hire_date BETWEEN '1995-05-20' AND '1996-05-20' -- date타입은 문자열처럼 조건연산을 해도 됨
 ORDER BY hire_date ASC;
 
-- 단일행 함수 및 변환 함수
/* 문제1 - 이름이 s로 시작하는 각 사원의 업무를 아래의 예와 같이 출력하고 함.(18행)
			머리글은 Employee JOBs.로 표시할 것.
*/
SELECT CONCAT(first_name, ' ', last_name, ' is a ', UPPER(job_id)) AS 'Employee JOBs'
  FROM employees
 WHERE last_name LIKE '%S';

/* 문제3 - 사원의 성과 이름을 NAME으로 별칭, 입사일, 입사항 요일을 출력하시오. 이때 주(week) 시작인 일요일부터 출력되도록 정렬(107행)
*/
SELECT CONCAT(first_name, ' ', last_name) AS 'name'
	 , hire_date
     , DATE_FORMAT(hire_date, '%W') AS 'Day of the week'
  FROM employees
 ORDER BY DATE_FORMAT(hire_date, '%W') ASC, hire_date;

-- 집계함수
/* 문제1 - 사원이 소속된 부서별 급여 합계, 급여 평균, 급여 최대값, 급여 최소값을 집계.
			출력값은 여섯자리와 세자리 구분기호, $표시 포함, 부서번호를 오름차순
			단, 부서에 소속되지 않는 사원은 정보에서 제외, 출력시 머리글은 아래처럼 별칭으로 처리(11개행)
*/
SELECT department_id
	 , CONCAT('$', FORMAT(ROUND(SUM(salary), 0), 0)) AS 'Sum Salary'
     , CONCAT('$', FORMAT(ROUND(AVG(salary), 0), 0)) AS 'AVG Salary' -- ROUND(값, 1), 소수점 1자리에서 반올림, FORMAT(값, 1) 소수점표현 및 1000단위 (,)표시
     , CONCAT('$', FORMAT(ROUND(MAX(salary), 0), 0)) AS 'MAX Salary'
     , CONCAT('$', FORMAT(ROUND(MIN(salary), 0), 0)) AS 'MIN Salary'
  FROM employees
 WHERE department_id IS NOT NULL
 GROUP BY department_id; -- 그룹바이 속한 컬럼만 SELECT 절에 사용할 수 있음!

-- 조인
/* 문제2 - job_grade 테이블을 사용, 각 사원의 급여에 따른 급여등급을 보고한다. 이름과 성을 name으로, 업무, 부서명, 입사일, 급여, 급여등급을 출력 (106행)
*/
DESC job_grades;
DESC employees;

SELECT *
  FROM departments AS d, employees AS e
 WHERE d.department_id = e.department_id; -- ANSI Standard SQL 쿼리
 
SELECT CONCAT(e.first_name, ' ', e.last_name) AS 'name'
	 , e.job_id
     , d.department_name
     , e.hire_date
     , e.salary
     , (SELECT grade_level FROM job_grades
		 WHERE e.salary BETWEEN lowest_sal AND highest_sal) AS 'grade_level'
  FROM departments AS d, employees AS e
 WHERE d.department_id = e.department_id
 ORDER BY e.salary DESC;

-- 서브쿼리 테스트
SELECT *
  FROM job_grades;
  
/* 문제3 - 각 사원의 상사와의 관계를 이용, 보고서 작성을 하려고 함
			예를 보고 출력하시오.(107행)
*/
SELECT CONCAT(e2.first_name, ' ', e2.last_name) AS 'Employee'
	 , 'report to'
     , UPPER(CONCAT(e1.first_name, ' ', e1.last_name)) AS 'Manager'
  FROM employees AS e1 RIGHT JOIN employees AS e2
	ON e1.employee_id = e2.manager_id;
    
-- 서브쿼리
/* 문제3 - 사원들의 지역별 근무현화을 조회. 도시 이름이 영문 'O'로 시작하는 지역에 살고
			사번, 이름, 업무, 입사일 출력하시오 (34행)
*/
SELECT e.employee_id
	 , CONCAT(e.first_name, ' ', e.last_name) AS 'name'
     , e.job_id
     , e.hire_date
  FROM employees AS e, departments AS d
 WHERE e.department_id = d.department_id
   AND d.location_id = (SELECT location_id
						  FROM locations
						 WHERE city LIKE 'o%');
                         
-- 서브쿼리 테스트
SELECT location_id
  FROM locations
 WHERE city LIKE 'o%';
    
    
    