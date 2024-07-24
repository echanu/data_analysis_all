################### 복원한 데이터베이스에서 작업 ####################
############## 1.사용자 테이블 조회하기
# MYSQL 전용 데이터베이스 테이블 목록 조회
SHOW TABLES

############## 2.전체 데이터 조회하기
SELECT REGIONID, PRODUCTGROUP, YEARWEEK, VOLUME
FROM KOPO_PRODUCT_VOLUME

############## 3.EXPRESSION 사용하기
# 테이블 기본조회 (EXPRESSION)
SELECT
	'수요예측결과' AS MEASURE_ID,
	A.YEARWEEK * A.VOLUME AS NEW_COL,
	A.*
FROM KOPO_PRODUCT_VOLUME A

############## 4. 중복제거(DISTINCT) 사용하기
## 실적중에 상품이 어떤거 팔리고 있어?
SELECT DISTINCT PRODUCTGROUP AS PRODUCT
FROM KOPO_PRODUCT_VOLUME

############## 5. 조건절(WHERE) 사용하기
## 조건절
### PRODUCTGROUP = 'ST0001' 이면서
### YEARWEEK >= "201501"
SELECT *
FROM KOPO_PRODUCT_VOLUME
WHERE PRODUCTGROUP = 'ST0001'
AND YEARWEEK = 201510

##KOPO_PRODUCT_VOLUME 테이블에서
##ST0002 상품의 201515, 201516주차 제품만 조회하세요
SELECT *
FROM KOPO_PRODUCT_VOLUME
WHERE PRODUCTGROUP = 'ST0001'
AND(YEARWEEK = 201515 OR YEARWEEK = 201516)

############## 6. 산술연산자 사용하기
SELECT
   REGIONID, PRODUCTGROUP, YEARWEEK, VOLUME,
   ROUND(VOLUME * 1.1, 0) AS WEIGHTED_VOL
FROM KOPO_PRODUCT_VOLUME
WHERE 1=1
AND PRODUCTGROUP = 'ST0001'
AND YEARWEEK >= '201501'


############## 7. 연산자 리스트 (핵심)
##### 하지만 IN, 등을 활용하자!!!!!!!!#######
### 조건절 IN  BETWEEN 사용법 테스트 테이블 생성
SELECT *
FROM KOPO_PRODUCT_VOLUME
WHERE PRODUCTGROUP = 'ST0001'
AND YEARWEEK IN(201515,201516)

SELECT *
FROM KOPO_PRODUCT_VOLUME
WHERE PRODUCTGROUP = 'ST0001'
AND YEARWEEK BETWEEN 201515 AND 201516

### STEP UP !!! 실제로는 아래 형태로 쓰임 (서브쿼리 개념)
CREATE TABLE RECALL_PERIOD(
YEARWEEK VARCHAR(6),
VALID VARCHAR(20)
)

INSERT INTO RECALL_PERIOD
VALUES('201520','Y'),('201521','Y'),('201522','N')	


SELECT A.*
FROM KOPO_PRODUCT_VOLUME A
WHERE A.PRODUCTGROUP = 'ST0002'
AND A.YEARWEEK NOT IN (
					 SELECT B.YEARWEEK
					 FROM RECALL_PERIOD B 
					 WHERE B.VALID = 'Y'
					)
					

### NULL 조회
INSERT INTO KOPO_PRODUCT_VOLUME
(REGIONID,PRODUCTGROUP, YEARWEEK)
VALUES('A99','','202410')

WHERE PRODUCTGROUP IS NULL

INSERT INTO KOPO_PRODUCT_VOLUME
(REGIONID,PRODUCTGROUP, YEARWEEK)
VALUES('A99','ST0003','202401')

INSERT INTO KOPO_PRODUCT_VOLUME
VALUES('A99',NULL,'202406', 1000 )

### NULL 은 IN에서 커버안됨 따로 해야함!!! 아래 참고
SELECT PRODUCTGROUP
FROM KOPO_PRODUCT_VOLUME
WHERE PRODUCTGROUP IS NULL 
OR PRODUCTGROUP IN ('', 'None','-');

############## 9. 데이터 정렬하기
SELECT * 
FROM KOPO_PRODUCT_VOLUME
ORDER BY REGIONID, PRODUCTGROUP, YEARWEEK

SELECT A.*
FROM KOPO_PRODUCT_VOLUME A
WHERE NOT A.PRODUCTGROUP = 'ST0002'




