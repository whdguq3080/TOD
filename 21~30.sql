-- Employees 테이블

--[ employee_id = 사번 ] [ first_name = 이름 ] 

--[ last_name = 성 ] [ email = 이메일 ] 

--[ phone_number = 전화번호 ] [ hire_date = 입사일 ]

--[ job_id = 업무코드 ] [ salary = 급여]

--[ commission_pct = 커미션비율 ] [ manager_id = 상사아이디]

--[ department_id = 부서코드]

--  Jobs 테이블

-- job_id 업무코드
-- job_title 업무타이틀
-- min_salary  최저급여
-- max_salary 최고급여


-- *******************
-- [문제021]
-- JOB_TITLE 가 "Programmer" 또는 "Sales Manager"인 
-- 직원의 이름, 입사일, 업무명 표시.
-- 직원의 이름을 오름차순으로 정렬하시오
-- *******************
SELECT E.FNAME 이름,E.HDATE 입사일, J.TITLE 업무명
FROM JOB J
    INNER JOIN EMP E
    ON J.JID LIKE E.JID 
WHERE J.TITLE IN('Programmer','Sales Manager')
ORDER BY E.FNAME;

-- *******************
-- [문제022]
-- 부서명 및 관리자이름 표시
-- (단, 컬럼명은 관리자 [공백] 이름 이 되도록 ...)
-- DEPARTMENTS 에서 MANAGER_ID 가 관리자 코드
-- *******************  


-- *******************
-- [문제023]
-- 마케팅(MARKETING) 부서에서 근무하는 사원의 
-- 사번, 직책 이름, 근속기간
-- (단, 근속기간은 JOB_HISTORY 에서 END_DATE-START_DATE로 구할 것)
-- EMPLOYEE_ID 사번, JOB_TITLE 직책임
-- *******************  

SELECT EMPLOYEE_ID,DEPARTMENT_NAME
FROM EMPLOYEES;

SELECT * FROM DEPT;
