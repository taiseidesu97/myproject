-- ch03.sql
-- 내장 함수 : mysql에서 기본적으로 지원하는 함수
-- 1.단일행 함수
-- 2.여러행 함수(집계 함수)

-- char_length, length 문자열의 길이
-- char_length: 글자길이 (몇 글자)
-- length : 바이트 수(영문자 - ascII, 한글(중,일)-유니코드)
select char_length('hello') -- 5
,length('hello'); -- 5
select char_length('한글') -- 2
,length('한글'); -- 6 (한글자 3바이트)

-- 문자열 연결
select concat('dreams','come','true');
-- ws : with Seperator 약자
select concat_ws('-','2016','01','21');

-- 문자열 일부 가져오기
select left ('sql 완전정복',3);
select right ('sql 완전정복',4);
SELECT SUBSTR('sql 완전정복',2, 5); -- 시작 인덱스 1부터 시작, 갯수
select SUBSTR('sql 완전정복',2);

-- 문자열 일부 가져오기(구분자 이용)
-- 2번째 구분자 이후를 지우고 가져온다.
select SUBSTRING_index('서울시 동작구 흑성동', ' ',2);
 -- 2번째 구분자 이전을 지우고 가져온다. 즉 역으로 가져옴
select SUBSTRING_index('서울시 동작구 흑성동', ' ',-2); --

-- 자릿수 채움
select LPAD('SQL',10,"#"); -- #######SQL
select RPAD('sql',5,"*"); -- SQL**
select LPAD(123, 10,' '); --         123
select LPAD(123, 10,'0');-- 0000000123

-- 공백 제거
SELECT length(LTRIM(' SQL '));-- 왼쪽 공백을 제거
select LENGTH(RTRIM(' SQL ')); -- 오른쪽 공백을 제거
select LENGTH(TRIM(' SQL ')); -- 양쪽 공백을 제거
SELECT REPLACE(' I    LIKE    SQ L',' ',''); -- 모든 공백 제거

-- 특정 문자 제거(TRIM)
select TRIM(both '###' from '###SQL###');
select TRIM(both '#' from '###SQL###');
select TRIM(both '##' from '###SQL###');  -- #SQL#

select TRIM(both 'ABC' from 'ABCSQLLABABC');
select TRIM(LEADING 'ABC' from 'ABCSQLLABABC');
select TRIM(TRAILING 'ABC' from 'ABCSQLLABABC');

-- 문자열 인덱스 찾기
select FIELD('JAVA', ,'SQL', 'JAVA','C'); -- 2인덱스(두번째)
select FIND_IN_SET('JAVA', 'SQL,JAVA,C'); -- 2인덱스
select INSTR('네 인생을 살아라', '인생'); -- 3인덱스
select ELT(2, 'SQL','JAVA','C'); -- 인덱스 2 인 JAVA 반환

-- 문자열 중복
SELECT REPEAT('*',5);
SELECT CONCAT(repeat('*',5),'STAR');

-- 문자열 치환
select REPLACE('010.5226.3868','.','-')

-- 문자열 거꾸로
select REVERSE('OLLEH');
use mydb;
-- 소숫점 관련 함수들
-- 올림 0 이상이면 자릿수 증가, 버림 소수점 버림,반올림 0.5이상이면 올림
select CEILING(123.56); -- 소숫점 첫째자리에서 올림
select FLOOR(123.56); -- 소숫점 첫째자리에서 버림
select ROUND(123.56); -- 소숫점 첫째자리에서 반올림

select ROUND(123.56, 1); -- 소숫점 둘째자리에서 반올림
select ROUND(123.56, 2); -- 소숫점 셋째자리에서 반올림
select ROUND(3456.1234, -1); -- 일의 자리에서 반올림
select ROUND(3456.1234, -2); -- 십의 자리에서 반올림

-- floor()에서는 두번째 매개변수(인자)를 쓸 수 없음.
select TRUNCATE(3456.1234,1); -- 소숫점 둘째자리에서 버림
select TRUNCATE(3456.1234,2); -- 소숫점 셋째자리에서 버림
select TRUNCATE(3456.1234,-1); -- 일의 자리에서 버림
select TRUNCATE(3456.1234,-2); -- 십의 자리에서 버림

-- 절대값
select ABS( -120);
select ABS( 120);
-- 부호 
select sign( -120); -- 음수이므로 -1을 리턴
select sign( 120); -- 양수이므로 1을 리턴

-- 나누기 함수
select 203 % 5;
select 203 mod 5;
select mod(203,5);
-- 제곱승
select power(2,3);
-- 제곱-근-
select SQRT(16);
-- 랜덤값
select RAND(); -- js의 random()함수와 유사.0.0~0.99999999...
-- 1~100사이의 랜덤 정수
select FLOOR(RAND()*100)+1

-- 현재 날짜 가져오기
-- now(): 쿼리가 시작된 시각
-- sysdate():함수가 호출된 실시간(찰나)

select now(),SLEEP(2),SYSDATE();
-- 현재 날짜 가져오기
select CURDATE();
-- 현재 시간 가져오기
select curtime();

-- 날짜 간격 가져오기(예- 설날까지 남은 날짜 D-day)
select now()
		,DATEDIFF('2026-02-16',now()) -- 26
		,DATEDIFF(now(),'2026-02-16'); -- -26
select now()
,TIMESTAMPDIFF(year,now(),'2027-01-30') -- 1
,TIMESTAMPDIFF(month,now(),'2027-01-30') -- 12
,TIMESTAMPDIFF(day,now(),'2027-01-30'); -- 373 오늘 2026년 1월 21일 기준

select now()
,DATEDIFF('2021-01- 15',now()) -- 자정기준
,TIMESTAMPDIFF(day,now(),'2026-01-22'); -- 만 24시 기준

-- 몇일 후 계산
select now(),
ADDDATE(NOW(),5), -- 5일 후 
ADDDATE(now(),interval 50 day), -- 50일 후
ADDDATE(now(),interval -50 day), -- 50일 전
ADDDATE(now(),interval 50 MONTH ), -- 50개월 후
ADDDATE(now(),interval 50 hour) -- 50시간 후

select now(),
last_day(now()) -- 이번달 마지막일 현재 날짜 1월 21일, 출력값 1월 31일
,DAYOFYEAR(now()) -- 올해 1월 1일에서 몇번째 날인가?
,monthNAME(NOW()) -- 이번달 영어 이름
,weekday(now()); -- 월(0)~일(6) 수요일(2)

-- 형변환 함수
select cast('1' as unsigned); -- 부호없는 숫자로 변환
select cast('-1' as unsigned); -- 오류(언더플로우 형태)
-- -1을 강제변환 시키면, 이진수 표현으로 해석해버린다.
select CAST('-1' as signed); -- 부호(-)가진 숫자로 변환

SELECT  CAST(2 as CHAR(1)); -- CHAR형(문자한자)한 자리로 변환. '2'
SELECT CONVERT('1',UNSIGNED);-- 숫자 1로 변환
select convert(2,CHAR(1));

-- CAST : ANSI 표준 가급적이면 ㅇ캐스트 함수ㅇ 를 사용하자
-- CONVERT(): MySQL 전용

-- 조건 함수 (js 삼항연산자와 유사)
select if( 10 > 20, '10','20');
SELECT if( 12500 * 450 > 500000, '초과달성','미달성') as 달성여부;

-- null 체크 함수
select IFNULL('123',0); -- 1항이 null이면, 2번째 항을 반환
						-- null이 아니면, 1번째 항을 반환 
select IFNULL(NULL ,0); -- null이므로 0을 반환
select IFNULL(NULL ,'null입니다'); -- 위에랑 똑같이 2번째 항을 반환해서 null입니다를 반환
select IFNULL(NULL ,'지역명없음');

select nullif(12*10,120); -- 1항과 2항이 같으면 null을 반환
select nullif(12*10,1200); -- 1항과 2항이 같이 않으면 1항을 반환

-- case ween (JS의 if else 구문 과 유사)
select case
	when 20>20 then '20보다 작음'
	when 20<30 then '30보다 작음'
	else '그외의 수'
end as 결과;

-- 연습문제
-- 1. 다음 조건에 따라 고객 테이블에서 고객회사명과 전화번호를 
--    다른 형태로 보이도록 함수를 사용해봅시다. 
use 세계무역;
-- 고객회사명2와 전화번호2를 만드는 조건은 아래와 같습니다.
-- 조건
 -- 1. 고객회사명2 : 기존 고객회사명 중 앞의 두 자리를 *로 변환한다.
-- 2. 전화번호2 : 기존 전화번호의 (xxx)xxx-xxxx 형식을 xxx-xxx-xxxx형식으로 변환한다.
select 고객회사명,
CONCAT('**',SUBSTR(고객회사명,'3'))as 고객회사명2
from 고객;

--답안
SELECT 고객회사명
,CONCAT('**',SUBSTR(고객회사명,'3'))AS 고객회사명2
,전화번호
,replace(substr(전화번호,2),')','-')AS 전화번호2
FROM 고객

SELECT 전화번호,
REPLACE(TRIM(BOTH'(' from 전화번호),')','-') as 전호번호2
from 고객;




-- 2. 다음 조건에 따라 주문 세부 테이블의 모든 컬럼과 주문금액, 할인금액, 실제 주문금액을 보이시오. 
-- 이때 모든 금액은 1의 단위에서 버림을 하고 10원 단위까지 보이시오.
-- 조건
-- 1. 주문금액: 주문수량 * 단가
-- 2. 할인금액 : 주문수량 * 단가 * 할인율
-- 3. 실주문금액 : 주문금액 - 할인금액
select TRUNCATE(주문수량*단가,-1) as 주문금액,
TRUNCATE(주문수량 * 단가 *할인율,-1) as 할인금액,
TRUNCATE(주문금액-할인금액,-1)as 실주문금액
from 주문세부

-- CTE(WITH절) : 모든 DBMS에서 사용가능, 단 mysql 5.x대 사용불가.
WITH 주문금액 AS (
    SELECT *, (주문수량 * 단가) AS 주문금액
    FROM 주문세부
),
할인금액 AS (
    SELECT *, TRUNCATE( 주문수량 * 단가 * 할인율, -1 ) AS 할인금액
    FROM 주문금액
)
SELECT *, (주문금액 - 할인금액) AS 실주문금액
FROM 할인금액;

-- CTE(WITH절)
WITH 주문cte AS (
    SELECT 주문수량
        ,단가
        ,할인율
        ,주문수량 * 단가 AS '주문금액'
        ,주문수량 * 단가 * 할인율 AS '할인금액'
    FROM 주문세부
)
SELECT 주문금액
    ,FLOOR(할인금액) AS 할인금액
    ,주문금액 - TRUNCATE(할인금액, -1) AS '실제 주문금액'
FROM 주문cte;


-- 3. 사원 테이블에서 전체 사원의 이름, 생일, 만나이, 입사일, 입사일수, 
-- 입사한 지 500일 후의 날짜를 보이시오.
SELECT 
이름,
생일,
ABS(TIMESTAMPDIFF(year,now(),생일))as '만나이',
입사일,
DATEDIFF(now(),입사일)as '입사일수',
DATEDIFF(now(),ADDDATE(입사일,interval 500 DAY)) as '500일 후의 날짜'
from 사원
-- 4. 고객 테이블에서 도시 컬럼의 데이터를 다음 조건에 따라 ‘대도시’와 ‘도시’로 구분하고, 
-- 마일리지 점수에 따라서 ‘VVIP’, ‘VIP’, ‘일반 고객’으로 구분하시오.
-- 조건
-- 1. 도시 구분: ‘특별시’나 ‘광역시’는 ‘대도시’로, 그 나머지 도시는 ‘도시’로 구분한다.
-- 2. 마일리지 구분 : 마일리지가 100,000점 이상이면 ‘VVIP고객’, 10,000점 이상이면 ‘VIP고객’, 그 나머지는 ‘일반고객’으로 구분한다.

SELECT CASE WHEN 도시 LIKE '%광역시' or 도시 LIKE '%특별시' then'대도시'
ELSE '도시'
END AS 'SPACE',
CASE WHEN 마일리지 >=100000 THEN 'VVIP'
WHEN 마일리지 >=10000 THEN 'VIP'
ELSE '일반고객'
END AS 'RANK'
FROM 고객;

-- 답안
SELECT 도시,
		-- 삼항연산자처럼 동작
	IF(도시 LIKE '%특별시' OR 도시 LIKE '%광역시','대도시','도시')AS 도시구분,
	마일리지,
	CASE WHEN 마일리지>=100000 THEN 'VVIP고객'
		WHEN 마일리지>=10000 THEN 'VIP고객'
		ELSE '일반고객'
		END AS 마일리지구분
FROM 고객;

-- 5번 문제
SELECT 주문번호,고객번호,주문일,YEAR(주문일)AS 주문년도,
CASE WHEN MONTH(주문일)<=3 THEN '1분기'
WHEN MONTH(주문일)<=6 THEN '2분기'
WHEN MONTH(주문일)<=9 THEN '3분기'
WHEN MONTH(주문일)<=12 THEN '4분기'
END AS '분기'
,
CONCAT(MONTH(주문일),'월') AS 월,
CONCAT(DAY(주문일),'일')AS 일,
CASE WHEN WEEKDAY(주문일) =0 THEN '월요일'
WHEN WEEKDAY(주문일) =1 THEN '화요일'
WHEN WEEKDAY(주문일) =2 THEN '수요일'
WHEN WEEKDAY(주문일) =3 THEN '목요일'
WHEN WEEKDAY(주문일) =4 THEN '금요일'
WHEN WEEKDAY(주문일) =5 THEN '토요일'
WHEN WEEKDAY(주문일) =6 THEN '일요일'
END AS 주문요일
FROM 주문

-- 문제 6
-- SELECT 요청일, 발송일	
-- CASE WHEN ADDTIME(DAY(요청일),INTERVAL DAY(발송일) DAY)  THEN ''
-- END
--- FROM 주문

-- 답안
SELECT * ,DATEDIFF(발송일, 요청일) AS 지연일수
FROM 주문
WHERE DATEDIFF(발송일,요청일) >=7;
-- 실전문제
-- 1
SELECT *
FROM 고객
WHERE 담당자명 LIKE '%정%'

-- 2
SELECT 제품번호, 제품명, 재고,
CASE WHEN 재고 >= 100 THEN '과다재고'
WHEN 재고 >=10 THEN '적정'
ELSE '제거부족'
END AS 재고구분
FROM 제품;


-- 3. 사원테이블에서 입사한 지 40개월이 지난 사원을 찾아,
-- 이름 부서번호 직워 입사일 입사일수 입사개월수를 출력하시오
SELECT 이름,부서번호,직위,입사일,
DATEDIFF(now(),입사일)AS 입사일수,
TIMESTAMPDIFF(MONTH,입사일,now())AS 입사개월수
FROM 사원
WHERE TIMESTAMPDIFF(MONTH,입사일,now())>40;