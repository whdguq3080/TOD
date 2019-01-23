-- SOCCER_SQL_011
-- 팀과 스타디움을 조인하여
-- 팀이름, 스타디움 이름 출력

SELECT T.TEAM_NAME 팀, S.STADIUM_NAME 스타디움
FROM TEAM T
    JOIN STADIUM S
        ON T.STADIUM_ID LIKE S.STADIUM_ID;

-- SOCCER_SQL_012
-- 팀과 스타디움, 스케줄을 조인하여
-- 2012년 3월 17일에 열린 각 경기의 
-- 팀이름, 스타디움, 어웨이팀 이름 출력
-- 다중테이블 join 을 찾아서 해결하시오.
SELECT T.TEAM_NAME 홈팀, S.STADIUM_NAME 스타디움, C.AWAYTEAM_ID 원정팀ID, C.SCHE_DATE 스케쥴날짜
FROM STADIUM S
    JOIN TEAM T
        ON T.STADIUM_ID LIKE S.STADIUM_ID
    JOIN SCHEDULE C
        ON S.STADIUM_ID LIKE C.STADIUM_ID
WHERE C.SCHE_DATE LIKE '20120317';
-- SOCCER_SQL_013
-- 2012년 3월 17일 경기에 
-- 포항 스틸러스 소속 골키퍼(GK)
-- 선수, 포지션,팀명 (연고지포함), 
-- 스타디움, 경기날짜를 구하시오
-- 연고지와 팀이름은 간격을 띄우시오
SELECT P.PLAYER_NAME 선수명, 
             P.POSITION 포지션,
               T.REGION_NAME||' '||T.TEAM_NAME 팀명,
                S.STADIUM_NAME 스타디움, 
                C.SCHE_DATE 날짜
FROM STADIUM S
        JOIN SCHEDULE C
            ON C.STADIUM_ID LIKE S.STADIUM_ID
        JOIN TEAM T      
            ON T.STADIUM_ID LIKE S.STADIUM_ID
        JOIN PLAYER P
            ON P.TEAM_ID LIKE T.TEAM_ID 
WHERE C.SCHE_DATE LIKE '20120317' AND P.POSITION LIKE 'GK' AND T.TEAM_NAME LIKE '스틸러스'
;
     

-- SOCCER_SQL_014
-- 홈팀이 3점이상 차이로 승리한 경기의 
-- 경기장 이름, 경기 일정
-- 홈팀 이름과 원정팀 이름을
-- 구하시오

SELECT 
    S.STADIUM_NAME 스타디움,
    C.SCHE_DATE 경기날짜,
    HT.REGION_NAME || ' '||HT.TEAM_NAME 홈팀,
    AT.REGION_NAME || ' '||AT.TEAM_NAME 원정팀,
    C.HOME_SCORE "홈팀 점수",
    C.AWAY_SCORE "원정팀 점수"
FROM 
    SCHEDULE C 
    JOIN STADIUM S
        ON C.STADIUM_ID LIKE S.STADIUM_ID
    JOIN TEAM HT 
        ON S.HOMETEAM_ID LIKE HT.TEAM_ID
    JOIN TEAM AT
        ON C.AWAYTEAM_ID LIKE AT.TEAM_ID
WHERE C.HOME_SCORE - C.AWAY_SCORE >= 3  
ORDER BY C.SCHE_DATE ; 

-- SOCCER_SQL_015
-- STADIUM 에 등록된 운동장 중에서
-- 홈팀이 없는 경기장까지 전부 나오도록
-- 카운트 값은 20

--1단계
SELECT S.STADIUM_NAME, 
        S.STADIUM_ID,
         S.SEAT_COUNT , S.HOMETEAM_ID , T.E_TEAM_NAME
FROM STADIUM S
        LEFT JOIN TEAM T
            ON S.STADIUM_ID LIKE T.STADIUM_ID ;

--2단계
SELECT S.STADIUM_NAME, 
        S.STADIUM_ID,
         S.SEAT_COUNT , S.HOMETEAM_ID , 
         (SELECT T.E_TEAM_NAME 
          FROM TEAM T 
          WHERE S.STADIUM_ID LIKE T.STADIUM_ID)
FROM STADIUM S;

-- SOCCER_SQL_016
-- 평균키가 인천 유나이티스팀의 평균키 보다 작은 팀의 
-- 팀ID, 팀명, 평균키 추출
	
    --1단계
	SELECT P.TEAM_ID 팀ID,T.TEAM_NAME 팀이름, AVG(P.HEIGHT) 평균키
	 FROM TEAM T
            JOIN PLAYER P
                ON T.TEAM_ID LIKE P.TEAM_ID
     GROUP BY P.TEAM_ID,T.TEAM_NAME
     ORDER BY 평균키;
     ;

    --2단계
	SELECT P.TEAM_ID 팀ID,T.TEAM_NAME 팀이름, ROUND(AVG(P.HEIGHT),2) 평균키
	 FROM TEAM T
            JOIN PLAYER P
                ON T.TEAM_ID LIKE P.TEAM_ID
     GROUP BY P.TEAM_ID,T.TEAM_NAME
     HAVING AVG(P.HEIGHT) < (SELECT AVG(P.HEIGHT)
                               FROM TEAM T
                                 JOIN PLAYER P
                                    ON T.TEAM_ID LIKE P.TEAM_ID
                                    WHERE T.TEAM_NAME LIKE '유나이티드')
     ORDER BY 평균키;


           
-- SOCCER_SQL_017
-- 포지션이 MF 인 선수들의  소속팀명 및 선수명, 백넘버 출력
SELECT T.TEAM_NAME 소속팀명,P.PLAYER_NAME 선수,P.BACK_NO 백넘버
FROM PLAYER P
        JOIN TEAM T
            ON T.TEAM_ID LIKE P.TEAM_ID
WHERE P.POSITION LIKE 'MF'
ORDER BY P.PLAYER_NAME 
  ;

-- SOCCER_SQL_018
-- 가장 키큰 선수 5 추출, 오라클, 단 키 값이 없으면 제외
SELECT PLAYER_NAME 이름,BACK_NO 백넘버,POSITION 포지션,HEIGHT 키
FROM (SELECT PLAYER_NAME,BACK_NO,POSITION,HEIGHT
        FROM PLAYER
        WHERE HEIGHT IS NOT NULL
        ORDER BY HEIGHT DESC)
WHERE ROWNUM BETWEEN 1 AND 5
;


-- SOCCER_SQL_019
-- 선수 자신이 속한 팀의 평균키보다 작은 선수 정보 출력
SELECT *
FROM PLAYER P
    JOIN TEAM T
        ON P.TEAM_ID LIKE T.TEAM_ID;
--2단계
SELECT *
FROM PLAYER P
    JOIN TEAM T
        ON P.TEAM_ID LIKE T.TEAM_ID
WHERE P.HEIGHT<175
        ;
--3단계
SELECT T.TEAM_NAME 팀명,P.PLAYER_NAME 선수명,P.POSITION 포지션,P.BACK_NO 백넘버,P.HEIGHT 키
FROM PLAYER P
    JOIN TEAM T
        ON P.TEAM_ID LIKE T.TEAM_ID
WHERE P.HEIGHT< (SELECT AVG(P2.HEIGHT)
                            FROM PLAYER P2
                            WHERE P2.TEAM_ID LIKE P.TEAM_ID
                            
                            )
ORDER BY P.PLAYER_NAME
;

-- SOCCER_SQL_020
-- 2012년 5월 한달간 경기가 있는 경기장 조회
-- EXISTS 쿼리는 항상 연관쿼리로 상요한다.
-- 또한 아무리 조건을 만족하는 건이 여러 건이라도
-- 조건을 만족하는 1건만 찾으면 추가적인 검색을 진행하지 않는다.

SELECT S.STADIUM_ID ID , S.STADIUM_NAME 경기장명
FROM STADIUM S
WHERE EXISTS (SELECT 1
                FROM SCHEDULE C
                WHERE C.STADIUM_ID LIKE S.STADIUM_ID
                AND C.SCHE_DATE BETWEEN '20120501' AND '20120531');


