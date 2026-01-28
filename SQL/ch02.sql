use 세계무역;


-- *은 모든 컬럼을 의미한다.
SELECT *
from 고객


-- 행의 갯수 (별칭(alias)는 출력창에 임시로 생성되는 이름, as 생략 가능)
select count(*) as'행의 갯수' 
from 고객;

select 고객번호,담당자명,고객회사명,마일리지 as 포인트,
	마일리지 * 1.1  as '10%인상된 마일리지'
from 고객;

-- where절 조건적 조회
select 고객번호,담당자명,마일리지 as 포인트
from 고객	
where 마일리지 >=100000;



-- order by 절 정렬 (내림차순 ,오름차순)
select 고객번호,담당자명,도시,마일리지 as포인트
from 고객
where 도시 = '서울특별시'
order by 마일리지 asc; -- DESC


-- limit n : 갯수 제한
select * 
FROM 고객
limit 3;

-- 마일리지 상위 3명 / 하위 3명
select *
from 고객
order by 마일리지 desc-- /하위asc
limit 3;

-- distinct 중복 데이터 제거
select distinct 도시
from 고객;

select *
FROM  고객
where 도시 = '서울특별시'
and 담당자직위 = '영업 사원'
and 마일리지 <5200

select * 
FROM  고객
where 도시 is null

select DISTINCT 도시
from 고객;

-- 산술연산자
select 23 +5 as 더하기
, 23 - 5 as 빼기
,23*5 as 곱하기
,23/5 as '나누기의 몫(실수)'
,23 div 5 as '나누기의 몫(정수)'
,23 % 5 as 나머지1
,23 mod 5 as 나머지2

-- 비교연산자
-- Mysql vs MariaDB 불리언(Boolean)을 정수형으로 처리한다
-- 						True는 1로 False는0으로 (단 null 과의 비교는 null)
-- postgreSQL(포스트그리 - sql): true / false 텍스트형태의 불리언 값 반환
-- Orecle,MS SQL Server  - 불리언값을 직접 반환하지 않음.
select 23 >23,
23<23,
23=23,
23!=23,
23<>23 -- 같지않은가

select *
from 고객
where 담당자직위 <> '영업 사원' -- 문자열은 '' 단따옴표 추천

select *
from 고객
where 도시 = '부산광역시' and 마일리지 < 1000
-- 1번문제
select * 
from 고객
where 도시 = '서울특별시' and 마일리지 >15000 and 마일리지 <20000

-- 2번 문제 
select distinct 지역,도시 
-- distinct  컬럼이 2개이상이면 쌍으로 구분됨 즉 좀더 세분화 해서 보여짐
from 고객
order by 지역,도시 asc;

-- 고객 테이블의 지역 필드가 ''(빈문자열)로 추가되었다.
-- ''인지? '   'null인지 헷갈린다.
-- 지역 필드의 값인 빈문자열 모두를('') null로 바꿔준다.
-- 값이 없을 때는 명시적으로 null 값으로 채우는게 좋다.

UPDATE 고객
set 지역 =null  -- WHERE 절이 없으면, 모든 열의 데이터가 적용된다.
where 지역 = '';

select 지역
from 고객

-- union 연산자(2개 이상의 select 결과를 합쳐준다.)
select 고객번호,도시,마일리지
from 고객
where 도시 = '부산광역시' -- 5열
union all -- 모든 행을 더한다 -- 50열
select 고객번호,도시,마일리지 
from 고객
where 마일리지 <1000
order by 고객번호; -- 45열


-- 첫번째 select의 필드명으로 출력된다.
select 고객번호,도시,마일리지
from 고객
where 도시 = '부산광역시' -- 5열
union all -- 모든 행을 더한다 -- 50열
select 고객번호,도시,마일리지 
from 고객
where 마일리지 <1000
order by 고객번호; -- 45열
-- union all 과 union(uinon distinct)의 차이
-- union all은 중복된 행을 포함해서 모든 행을 출력(정렬없이 그대로 합친다)
-- union은 중복된 행을 제거하고 출력(내부적으로 정렬후 합친다.)

-- union 사용시 주의점
-- 1. 컬럼(필드)갯수 일치
-- 각 컬럼의 데이터 타입(숫자,문자,날짜)
-- 3 첫번째 select의 필드명으로 출력된다 ****나중에 공부****

-- is null 연산자 - null값인지?
select * from 고객
where 지역 is null; -- 66 열

select * from 고객
where 지역 is not null; -- 27 열

-- in연산자 : ~중에 하나가 있으면 true(여러개의 or를 대체)
select 고객번호, 담당자명, 담당자직위
FROM 
where 담당자직위 = '영업 과장'or 담당자직위 'ak'

-- beetwen  and : ~이상 ~이하 범위를 지정할 때
select 담당자명, 마일리지
from 고객
WHERE 100000<= 마일리지 and 마일리지<= 200000 -- 2열

select 담당자명, 마일리지
from 고객
where 마일리지 between 100000 and 200000 -- 2열

-- like연산자 : 문자(열)의 일부를 검사할 때 사용
--           : %의 여러 문자열을 대체
--           : _한 글자(문자)를 대체

select *
from 고객
where 도시 like '%광역시'
and(고객번호 like '_c%'); -- 고객번호 2번째 문자가 c인 열을 찾는다.

-- 연습문제 
-- 1. 제품 테이블에서 제품명에 '주스'가 들어가는 모든 제품을 출력하세요
select *
from 제품
where 제품명 like'%주스%'

-- 2. 제품 테이블에서 단가가 5,000원 이상 10,000원 이하인 '주스'가 제품명에 들어가는 제품들을 출력하시오
select * 
from 제품
WHERE 제품명 like'%주스%' and 단가 between 5000 and 10000

-- 3. 제품 테이블에서 제품번호가 1,2,3,4,11,20인 모든 제품을 출력하시오.
select * 
from 제품
where 제품번호 like'_1%' or 
제품번호 like'_2%'or 
제품번호 like'_3%'or 
제품번호 like'_4%'or 
제품번호 like'11%'or 제품번호 like'20%' 
-- 4. 제품 테이블에서 재고금액이 높은 상위 10개 제품에 대해 제품번호, 제품명, 
--   단가, 재고, 재고금액(단가 * 재고)을 보이시오.
select 제품번호, 제품명, 단가, 재고, 단가 * 재고 as 재고금액
from 제품
order by 재고금액 desc
limit 10

