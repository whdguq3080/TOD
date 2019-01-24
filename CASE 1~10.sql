SELECT * FROM EMP;
-- EMPNO 사원
-- ENAME 사원명
-- JOB 업무
-- MGR 매니저
-- HIREDATE 입사일
-- SAL 월급
-- COMM 커미션
-- DEPTNO 부서코드

SELECT * FROM DEPT;

-- DEPTNO 부서코드
-- DNAME 부서명
-- LOC 회사위치


--문법
--CASE WHEN 조건식
-- THEN 참일 경우
-- ELSE 거짓일 경우
-- END 컬럼명으로 처리

-- EMP_TEST_01
-- CASE 표현
SELECT ENAME,
    CASE WHEN SAL >= 2000
        THEN SAL
        ELSE 2000
    END REVISED_SALARY
FROM EMP;
--EMP TEST_02
--부서정보에 부서위치를 미국의 동부,중부,서부로 구분하라
--뉴욕 -EAST, 보스턴 - EAST , 시카고 - CENTER, 달라스 -CENTER
--컬럼명 - AREA
SELECT LOC,
   CASE WHEN LOC = 'NEW YORK' THEN 'EAST' 
        WHEN LOC = 'BOSTON' THEN 'EAST' 
        ELSE 'CENTER'
    END AS AREA
FROM DEPT
ORDER BY AREA;
--EMP TEST_03
--급여가 3000이상이면 HIGH, 1000 이상이면 MID , 미만이면 LOW

SELECT ENAME,SAL,
    CASE WHEN SAL >= 3000 THEN 'HIGH'
         WHEN SAL >= 1000 THEN 'MID'
            ELSE 'LOW'
            END REVISED_SALARY
    FROM EMP;  
--EMP TEST_04
--급여가 2000이상이면 보너스 1000,
-- 1000 이상이면 500,
--1000 미만이면 0으로 계싼하시오
-- 컬럼명은 BONUS
SELECT ENAME,SAL,
    CASE WHEN SAL >= 2000 THEN '1000'
         WHEN SAL >= 1000 THEN '500'
         ELSE '0' 
         END BONUS
    FROM EMP
    ORDER BY SAL;     
-- EMP_TEST_05
-- 매니저가 "BLAKE" 이면 NULL 표시, 같지 않으면 MGR 표시

SELECT ENAME, EMPNO, MGR,
    CASE WHEN MGR = (SELECT MGR 
                    FROM EMP 
                    WHERE EMPNO LIKE 7698)
         THEN NULL
         ELSE MGR
    END NUIF
FROM EMP; 

-- EMP_TEST_06
-- 개별 입사정보에서 월별 데이터를 추출하기
-- EXTRACT() 
SELECT ENAME,DEPTNO,
    EXTRACT(MONTH FROM HIREDATE) 입사월 ,SAL
FROM EMP;
--EMP_TEST_07
-- 추출된  MONTH 데이터를 12개의 월별 칼럼으로 구분하기

SELECT ENAME,DEPTNO,
        EXTRACT(MONTH FROM HIREDATE) 월
FROM EMP;




-- EMP_TEST_08
-- 추출된 MONTH 데이터를 12개의 월별 칼럼으로 구분한 후
-- 부서별로 구분하기


--EMP TEST 09
--계층형 쿼리
--LEVEL : 루트 데이터이면 1, 그 하위 데이터이면 2이다.
--리프(LEAF) 데이터까지 1씩 증가한다.
--CONNECT_BY_ISLEAF 전개 과정에서 해당 데이터가 리프데이터이면
--1, 그렇지 않으면 0이다
--
SELECT LEVEL, 
        LPAD(' ',4 *(LEVEL-1)) || EMPNO 사원,
        MGR 관리자,
        CONNECT_BY_ISLEAF ISLEAF
FROM EMP
START WITH MGR IS NULL
CONNECT BY PRIOR EMPNO LIKE MGR;

--EMP TEST 10
--셀프 조인

SELECT E1.EMPNO 사번 , E1.MGR 관리자, E2.MGR "상위 관리자"
FROM EMP E1
    LEFT JOIN EMP E2
        ON E1.MGR LIKE E2.EMPNO
ORDER BY E2.MGR DESC, E1.MGR,E1.EMPNO
; 
-- 자신과 자신의 직속관리자는 동일한 행에서 구할수 있으나
-- 차상위 관리자는 바로 구할수 없다.
-- 차상위 관리자를 구하기 위해서는 자신의 직속 관리자를
-- 기준으로 셀프 조인을 수행해야 된다.
-- 그러나, INNER JOIN을 사용함으로써 자신의 관리자가
-- 존재하지 않는 경우에는 E2테이블에서 조인할 대상이
-- 존재하지 않기 때문에 해당 데이터는 결과에서 누락된다.
-- 이를 방지하기 위해서는 아우터 조인을 사용한다.

--EMP_TEST 11
--GROUP FUNCTION 그룹함수
--일반적인 GROUP BY 함수


--ANSI 에서 정의한 함수 세가지
--AGGREBATE FUNCTION 집계함수 SUM(), MIN(), ...
--GROUP FUNCTION 그룹함수 
--특정항목에 대한 소계를 하는 함수
--ROLLUP : 소그룹간의 소계를 계산하는 함수
SELECT DNAME 부서명,
    JOB 업무,
    COUNT(*) "전체 사원",
    SUM(SAL) "전체 급여"
FROM EMP E, DEPT D
WHERE E.DEPTNO = D.DEPTNO
GROUP BY ROLLUP(DNAME,JOB);
--CUBE : 다차원적인 소계를 계산하는 함수 
SELECT CASE GROUPING(DNAME)
            WHEN 1 THEN 'ALL DEPTS'
            ELSE DNAME 
            END "부서명",
        CASE GROUPING(JOB)
            WHEN 1 THEN 'ALL JOBS'
            ELSE JOB 
        END "업무",
        COUNT(*) "전체 사원",
        SUM(SAL) "전체 급여"        
FROM EMP E, DEPT D
WHERE E.DEPTNO = D.DEPTNO
GROUP BY CUBE(DNAME,JOB);
--WINDOW FUNCTION 윈도우함수..RANK(), ROW_NUMBER() 

