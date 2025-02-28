-- 서브쿼리 고급
-- 4-12 Orders 테이블 평균 주문금액 이하의 주문에 대해 주문번호와 금액을 나타내시오
-- 집계함수는 GROUP BY가 없어도 테이블 전체를 집계할 수 있음
SELECT orderid
	 , saleprice
  FROM Orders
  WHERE saleprice <= (
						SELECT AVG(saleprice)
                          FROM Orders
					  );
                      
-- 4-14 대한민국에 거주하는 고객에게 판매한 도서의 총판매액을 구하시오
SELECT SUM(saleprice) AS '총 판매액'
  FROM Orders
 WHERE custid IN (					  
					SELECT custid
					  FROM Customer
                    WHERE address LIKE '%대한민국%'
				   );
                   
-- 4-15 3번 고객이 주문한 도서의 최고 금액보다 더 비싼 도서를 구입한 주문의
-- 주문번호와 판매금액을 보이시오.
-- 비교 연산자만 쓰면 서브쿼리의 값이 단일값이 아니어도 상관없음
-- SELECT *

-- aLL|SOME|ANY
-- SELECT MAX(saleprice)
--   FROM Orders
--  WHERE custid =3;
 

SELECT AVG(saleprice)
  FROM Orders;
  
-- 2010년 중반이후부터 사용 예상
SELECT *
FROM Orders
WHERE(custid, orderid) IN (
							SELECT custid, orderid
                              FROM Orders
                              WHERE custid = 2
							);
                            
-- SELECT 서브쿼리. 스칼라값(단일행, 단일열) 한 컬럼에 데이터 1개
-- 4-17 고객별 판매액을 나타내시오.(고객이름과 고객별 판매액 출력)
SELECT o.custid
	 , (SELECT name FROM Customer WHERE custid = o.custid) AS 고객명
	 , SUM(o.saleprice) '판매액'
  FROM Orders AS o
 GROUP BY o.custid;
 
SELECT name FROM Customer WHERE custid = 2;

-- FROM절 서브쿼리, 인라인뷰
-- 4-19 고객번호가 2이하인 고객의 판매액을 나타내시오(고객이름, 고객별 판매액 출력)
-- 이 테이블이 하나의 가상의 테이블이 됨
SELECT custid
	 , name
  FROM Customer
 WHERE custid <= 2;
 
 SELECT cs.*
 FROM (SELECT custid
			, name
		 FROM Customer
		WHERE custid <= 2) AS cs;
 
 -- 3. 가상테이블 cs와 Orders테이블을 조인
 SELECT cs.name, SUM(o.saleprice) '구매액'
 FROM (SELECT custid
			, name
		 FROM Customer
		WHERE custid <= 2) AS cs, Orders AS o
 WHERE cs.custid = o.custid;
 GROUP BY cs.name;
 