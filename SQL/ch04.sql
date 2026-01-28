-- ch04.sql
-- 집계함수(여러행 함수) : count(),sum(),avg(),min(),max(),stddev()
SELECT count(*)
FROM 고객

-- 집계함수는 null값은 연산에서 제외한다.
SELECT count(고객번호),count(도시),count(지역)
FROM 고객;

SELECT sum(마일리지),avg(마일리지),MIN(마일리지),MAX(마일리지),TRUNCATE(STDDEV(마일리지),-1) AS 표준편차
FROM 고객
WHERE 도시 = '서울특별시';

-- GROUP BY절 : 특정컬럼에 대한 그룹(묶어서)으로 집계할때
SELECT 도시,COUNT(*) AS '도시별 고객수'
	,AVG(마일리지)AS '도시별 평균마일리지'
FROM 고객
GROUP BY 도시,마일리지

-- HAVING 절 : SELECT 문에 들어가는 컬럼과 집계함수에만 적용가능
 			-- 	: GROUP BY절과 함께 사용한다.
SELECT 도시,COUNT(*)AS '도시별 고객수'
FROM 고객
GROUP BY 도시
HAVING COUNT(*)>= 10
ORDER BY 2 DESC;

SELECT 도시 ,COUNT(*)AS '도시별 고객수'
	,AVG(마일리지)AS 평균마일리지
FROM 고객
WHERE 도시 LIKE '%광역시' -- 집계에 참여할 행을 미리 선별한다.
GROUP BY 도시  -- 도시를 기준으로 집계하자.
HAVING COUNT(*) >= 5;  -- 집계 후의 결과물에서 선별한다.


SELECT 도시, 담당자직위, SUM(마일리지)
FROM 고객
WHERE 고객번호 LIKE 'T%'
-- GROUP절에는 SELECT문의 컬럼명을 모두 적어야 됨.(집계함수 제외!)
GROUP BY 1, 2
HAVING SUM(마일리지) >= 1000;

-- 연습문제
SELECT 담당자직위,도시,MAX(마일리지)
FROM 고객
WHERE 도시 LIKE '%광역시%'
GROUP BY 담당자직위,도시
HAVING MAX(마일리지)>=10000;

-- 답안
SELECT 담당자직위
,MAX(마일리지)AS 최대마일리지
FROM 고객
WHERE 도시 LIKE '%광역시%'
GROUP BY 담당자직위
HAVING MAX(마일리지)	>=10000;

SELECT 담당자직위,마일리지
FROM 고객
WHERE 담당자직위 = '영업 과장';

-- count()함수에 distinct 예약어를 추가
-- count(distinct 도시): 중복값을 한 번씩만 센다.
SELECT 도시,count(도시),count(DISTINCT 도시),sum(distinct 도시)
FROM 고객
GROUP BY 도시;

SELECT count(도시) AS 전체데이터수  -- 93(전체고객수)
, count(DISTINCT 도시)AS 거래도시수 -- 27  お前の血は何色だ！
FROM 고객;

-- 주문년도별로 직계를 해보자
SELECT year(주문일) AS 주문년도
,count(*)AS 주문건수
FROM 주문
GROUP BY year(주문일);

-- 분기별,소계(rollup)를 집계 해보자.
SELECT year(주문일)AS 주문연도,
QUARTER(주문일)AS 분기,
count(*)AS 주문건수
FROM 주문
GROUP BY year(주문일),quarter(주문일)
WITH ROLLUP; -- 분류별 소계, 총계를 내주는 구문

--  주문 테이블에서 요청일보다 발송이 늦어진 주문을
-- 월별로 집계(요약)해 보자.
SELECT MONTH(주문일)AS 주문월,count(*)AS 주문건수
FROM 주문
WHERE 요청일 < 발송일
GROUP BY month(주문일)
ORDER BY month(주문일)ASC; -- 기본값

-- 제품 테이블에서 제품명에 '아이스크림'이 들어간 제품들의 재고합을 집계하여 출력하시오.
SELECT 제품명, SUM(재고) AS 재고합
FROM 제품
WHERE 제품명 LIKE '%아이스크림%'
GROUP BY 제품명
WITH ROLLUP;

-- 실전문제
SELECT SUM(주문수량),FLOOR(SUM(단가 *주문수량))AS '주문금액?'
FROM 주문세부;

-- 2 
SELECT 주문번호,제품번호,SUM(주문수량*단가)AS 주문금액합
FROM 주문세부
GROUP BY 주문번호,제품번호
WITH ROLLUP
ORDER BY 주문번호 ;

SELECT 고객번호,COUNT(*) AS 주문건수
FROM 주문
WHERE YEAR(주문일)= 2021
GROUP BY 고객번호
ORDER BY 주문건수 DESC
LIMIT 3;

 -- GROUP_CONCAT()함수 : 여러행의 문자열을 결행해 줌.
SELECT 직위,GROUP_CONCAT(이름 SEPARATOR', ')
FROM 사원
GROUP BY 직위
ORDER BY 직위


















