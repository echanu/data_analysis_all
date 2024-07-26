### 테이블 생성쿼리
CREATE TABLE T1(
아이디 VARCHAR(100),
도시개발사 VARCHAR(100),
위치 VARCHAR(100))

INSERT INTO T1 VALUES
('A01','하울팀','영등포'),
('A02','카울팀','구로'),
('A03','진아팀','시흥'),
('A04','건아팀','잠실')

SELECT * 
FROM T1

SELECT * 
FROM T1 
WHERE 도시개발사 IN ('하울팀','카울팀');

SELECT * 
FROM T1 
WHERE 도시개발사 LIKE '%하울%' OR 도시개발사 LIKE '%카울%';

SELECT avg(C.TEMPERATURE) 
FROM CHEON C 
WHERE SUBSTR(C.GET_TIME, 2, 5) = 2024 ;

SELECT 
	AVG(temperature) AS avg_temp
FROM(
	SELECT A.*,
		SUBSTR( REPLACE(get_time,'"',''), 1,4) AS year
	FROM CHEON A
)B
WHERE YEAR = '2024'

SELECT COUNT(B.*)
FROM
	SELECT DISTINCT A.REGIONID 
	FROM KOPO_CHANNEL_SEASONALITY_NEW A
)B

##[KOPO_CHANNEL_SEASONALITY_NEW] A62 법인의  PRODUCT59의 평균 실적은?
SELECT A.REGIONID,
	A.PRODUCT,
	AVG(QTY) AS AVG_QTY
FROM KOPO_CHANNEL_SEASONALITY_NEW A
WHERE REGIONID = 'A62'
AND PRODUCT = 'PRODUCT59'
GROUP BY A.REGIONID, A.PRODUCT
	



### 2023 11월 5일 14시 30분 측정
### 2023 11월 6일 15시 30분 측정

CASE WHEN -> FEATURE ENGINEERING!!!

-- 오전/오후/저녁/밤(새벽) 분리!!
-- 09:00 ~ 11:00 오전
-- 11:00 ~ 16:00 오후
-- 이 이후는 ELSE..






