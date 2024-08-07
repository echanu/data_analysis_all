######################### 데이터 조인 (다중 키 및 테이블 조인)
SELECT A.*,
	B.REGIONNAME
FROM KOPO_CHANNEL_SEASONALITY_NEW A,
KOPO_REGION_MST B
ORDER BY A.REGIONID, A.PRODUCT, A.YEARWEEK

SELECT DISTINCT REGIONID
FROM(
	SELECT A.REGIONID,
		A.PRODUCT,
		A.YEARWEEK,
		A.QTY,
		B.REGIONNAME
	FROM KOPO_CHANNEL_SEASONALITY_NEW A
	-- 조인방법: INNER JOIN
	LEFT JOIN KOPO_REGION_MST B
	-- 조인키 : REGIONID
	ON A.REGIONID = B.REGIONID 
	ORDER BY A.REGIONID, A.PRODUCT
)C

-- 1건은 뭐지??????
SELECT DISTINCT REGIONID
FROM KOPO_CHANNEL_SEASONALITY_NEW
WHERE REGIONID NOT IN (SELECT REGIONID
					FROM KOPO_REGION_MST)


-- KOPO_CHANNEL_SEASONALITY_NEW: 124,658
-- INNER JOIN: 124,344 (어떤게 빠졌는지...확인했죠?)
-- RIGHT JOIN: 124,349 (뭐가 빠졌는지 확인했)
-- LEFT JOIN : 124,658

SELECT COUNT(*)
FROM(
	SELECT A.*,
		B.REGIONNAME
	FROM KOPO_CHANNEL_SEASONALITY_NEW A
	LEFT JOIN KOPO_REGION_MST B
	ON A.REGIONID = B.REGIONID
)C

SELECT DISTINCT REGIONID
from kopo_region_mst krm
where regionid not in (select distinct REGIONID
                       from kopo_channel_seasonality_new kcsn)

SELECT DISTINCT REGIONID
from kopo_channel_seasonality_new
where regionid not in (select distinct REGIONID
                       from kopo_region_mst )
                       
######################### 데이터 조인 (조인키는 컬럼이름이 같아야 하나요?)
# 아닙니다! 컬럼이 담고 있는 의미가 중요함
CREATE TABLE JOIN_SELLOUT(
	REGIONID VARCHAR(100),
	PRODUCT VARCHAR(100),
	YEARWEEK VARCHAR(100),
	QTY VARCHAR(100)
)

CREATE TABLE JOIN_MST(
	SALESID VARCHAR(100),
	SALESNAME VARCHAR(100)
)

INSERT INTO JOIN_SELLOUT
VALUES('A00','PRODUCT1','201501',4000),
('A01','PRODUCT2','201501',2000),
('A02','PRODUCT3','201501',11000),
('A03','PRODUCT4','201501',100)

INSERT INTO JOIN_MST
VALUES('A00','아프리카'),
('A01','영국')

SELECT A.*,
	B.*
FROM JOIN_SELLOUT A
LEFT JOIN JOIN_MST B
ON A.REGIONID = B.SALESID


######################### 데이터 조인 (다중 키 및 테이블 조인)
# 기준데이터 8건
# 조인한결과 8건

# 기준데이터 8건
# 조인한결과 8건
CREATE TABLE REGION_MST (
    REGIONID VARCHAR(6),
    REGION_NAME VARCHAR(20),
    PRIMARY KEY (REGIONID)
);

CREATE TABLE ACCOUNT_MST (
    ACCOUNTID VARCHAR(6),
    ACCOUNTNAME VARCHAR(20),
    PRIMARY KEY (ACCOUNTID)
);

CREATE TABLE SELLOUT_DATA (
    REGIONID VARCHAR(6),
    ACCOUNTID VARCHAR(6),
    YEARMONTH VARCHAR(6),
    SELLOUT INT,
    PRIMARY KEY (REGIONID, ACCOUNTID, YEARMONTH),
    FOREIGN KEY (REGIONID) REFERENCES REGION_MST(REGIONID),
    FOREIGN KEY (ACCOUNTID) REFERENCES ACCOUNT_MST(ACCOUNTID)
);

CREATE TABLE DISCOUNT_DATA (
    REGIONID VARCHAR(6),
    ACCOUNTID VARCHAR(6),
    YEARMONTH VARCHAR(6),
    DISCOUNT_RATE DECIMAL(5, 2),
    PRIMARY KEY (REGIONID, ACCOUNTID, YEARMONTH),
    FOREIGN KEY (REGIONID) REFERENCES REGION_MST(REGIONID),
    FOREIGN KEY (ACCOUNTID) REFERENCES ACCOUNT_MST(ACCOUNTID)
);

INSERT INTO REGION_MST (REGIONID, REGION_NAME) VALUES
('A01', '미국'),
('A02', '한국'),
('A03', '독일'),
('A04', '호주'),
('A05', '영국');

INSERT INTO ACCOUNT_MST (ACCOUNTID, ACCOUNTNAME) VALUES
('SA01', 'KOPO'),
('SA02', 'KOSTCO'),
('SA03', 'KO-MART'),
('SA04', 'KOPO-MART'),
('SA05', 'HKCODE');

INSERT INTO SELLOUT_DATA (REGIONID, ACCOUNTID, YEARMONTH, SELLOUT) VALUES
('A01', 'SA01', '202301', 1000),
('A01', 'SA02', '202301', 1500),
('A02', 'SA03', '202302', 1200),
('A02', 'SA04', '202302', 1700),
('A03', 'SA05', '202303', 1300),
('A01', 'SA01', '202304', 1100),
('A02', 'SA03', '202305', 1250),
('A03', 'SA05', '202306', 1350);

INSERT INTO DISCOUNT_DATA (REGIONID, ACCOUNTID, YEARMONTH, DISCOUNT_RATE) VALUES
('A01', 'SA01', '202301', 5.00),
('A01', 'SA02', '202301', 7.50),
('A02', 'SA03', '202302', 6.00),
('A02', 'SA04', '202302', 8.00),
('A03', 'SA05', '202303', 5.50);

#DROP TABLE IF EXISTS DISCOUNT_DATA, SELLOUT_DATA, ACCOUNT_MST, REGION_MST;
SELECT A.REGIONID,
	C.REGION_NAME,
	A.ACCOUNTID,
	D.ACCOUNTNAME,
	A.YEARMONTH,
	A.SELLOUT,
	B.DISCOUNT_RATE
FROM SELLOUT_DATA A
LEFT JOIN DISCOUNT_DATA B
ON A.REGIONID = B.REGIONID
AND A.ACCOUNTID = B.ACCOUNTID
AND A.YEARMONTH = B.YEARMONTH
LEFT JOIN REGION_MST C
ON A.REGIONID = C.REGIONID
LEFT JOIN ACCOUNT_MST D
ON A.ACCOUNTID = D.ACCOUNTID

