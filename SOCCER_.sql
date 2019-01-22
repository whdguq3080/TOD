SELECT * FROM TEAM;
-- SQL_TEST_001
-- 전체 축구팀 목록. 이름 오름차순
SELECT TEAM_NAME
FROM TEAM
ORDER BY TEAM_NAME;
-- SQL_TEST_002
-- 포지션 종류(중복제거,없으면 빈공간)
SELECT DISTINCT POSITION
FROM PLAYER;

-- SQL_TEST_003
-- 포지션 종류(중복제거,없으면 신입으로 기재)
-- nvl2()사용
SELECT DISTINCT NVL2(POSITION,POSITION,'신입') 포지션
FROM PLAYER;

-- SQL_TEST_004
-- 수원팀(ID: K02)골키퍼
SELECT PLAYER_NAME 이름
FROM PLAYER
WHERE TEAM_ID LIKE 'K02' AND POSITION LIKE 'GK';

-- SQL_TEST_005
-- 수원팀(ID: K02)키가 170 이상 선수
-- 이면서 성이 고씨인 선수
SELECT POSITION,PLAYER_NAME 이름
FROM PLAYER
WHERE TEAM_ID LIKE 'K02' AND HEIGHT>=170 AND PLAYER_NAME LIKE '고%'; 
-- SQL_TEST_006
-- 수원팀(ID: K02) 선수들 이름,
-- 키와 몸무게 리스트 (단위 cm 와 kg 삽입)
-- 키와 몸무게가 없으면 "0" 표시
-- 키 내림차순

    
-- SQL_TEST_007
-- 수원팀(ID: K02) 선수들 이름,
-- 키와 몸무게 리스트 (단위 cm 와 kg 삽입)
-- 키와 몸무게가 없으면 "0" 표시
-- BMI지수 
-- 키 내림차순

-- SQL_TEST_008
-- 수원팀(ID: K02) 과 대전팀(ID: K10)선수들 중 
--  포지션이 GK 인  선수
-- 팀명, 사람명 오름차순

-- SQL_TEST_009
-- 수원팀(ID: K02) 과 대전팀(ID: K10)선수들 중 이
-- 키가 180 이상 183 이하인 선수들
-- 키, 팀명, 사람명 오름차순



-- SOCCER_SQL_010
-- 모든 선수들 중
-- 포지션을 배정받지 못한 선수들의 팀과 이름
-- 팀명, 사람명 오름차순

