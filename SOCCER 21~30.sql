-- SOCCER_SQL_021
-- 이현 선수 소속팀의 선수명단 출력
SELECT PLAYER_NAME 선수명,POSITION 포지션,BACK_NO 백넘버
FROM PLAYER 
     WHERE TEAM_ID = (SELECT TEAM_ID 
                            FROM PLAYER 
                            WHERE PLAYER_NAME = '이현')
ORDER BY PLAYER_NAME; 


-- SOCCER_SQL_022
-- NULL 처리에 있어
-- SUM(NVL(SAL,0)) 로 하지말고
-- NVL(SUM(SAL),0) 으로 해야 자원낭비가 줄어든다
 
-- 팀별 포지션별 인원수와 팀별 전체 인원수 출력
 
-- Oracle, Simple Case Expr 

-- SOCCER_SQL_023
-- GROUP BY 절 없이 전체 선수들의 포지션별 평균 키 및 전체 평균 키 출력

-- SOCCER_SQL_024 
-- 소속팀별 키가 가장 작은 사람들의 정보
SELECT P.TEAM_ID 팀아이디,TEAM_NAME 팀명,P.PLAYER_NAME 선수,
                            P.POSITION 포지션,P.BACK_NO 백넘버,P.HEIGHT 키 
FROM PLAYER P
        JOIN TEAM T 
            ON P.TEAM_ID LIKE T.TEAM_ID
WHERE (P.TEAM_ID,P.HEIGHT) IN(SELECT TEAM_ID ,MIN(HEIGHT)
                                 FROM PLAYER
                                 GROUP BY TEAM_ID ) 
;
SELECT TEAM_ID ,HEIGHT 
FROM PLAYER;


-- SOCCER_SQL_025 
-- K-리그 2012년 8월 경기결과와 두 팀간의 점수차를 ABS 함수를 사용하여
-- 절대값으로 출력하기

-- SOCCER_SQL_026 
-- 20120501 부터 20120602 사이에 경기가 있는 경기장 조회

-- SOCCER_SQL_027 
-- 선수정보와 해당 선수가 속한  팀의 평균키 조회
-- 단, 정렬시 평균키 내림차순

-- SOCCER_SQL_028 
-- 평균키가 삼성 블루윙즈 팀이 평균키보다 작은 팀의 
-- 이름과 해당 팀의 평균키

-- SOCCER_SQL_029 
-- 드래곤즈,FC서울,일화천마 각각의 팀 소속의 GK, MF 선수 정보

-- SOCCER_SQL_030 
-- 29번에서 제시한 팀과 포지션이 아닌 선수들의 수
