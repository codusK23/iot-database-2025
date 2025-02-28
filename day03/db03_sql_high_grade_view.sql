-- 뷰
-- DDL CREATE로 뷰를 생성
CREATE VIEW v_orders
	AS
SELECT o.orderid
     , c.custid
     , c.name
     , b.bookid
     , b.bookname
     , b.price
     , o.saleprice
     , o.orderdate
  FROM Customer AS c, Book AS b, Orders AS o
 WHERE c.custid = o.custid
   AND b.bookid = o.bookid;
  
  
-- 뷰실행 - 위의 조인쿼리 실행
-- SQL 테이블로 할 수 있는 쿼리는 다 실행가능
SELECT *
  FROM v_orders
 WHERE name ='장미란'
 
 -- 4-20 주소에 '대한민국'을 포함하는 고객들로 구성된 뷰를 만들고 조회하시오
 -- 뷰의 이름은 Vw_cuSMON 설정합니다.and
CREATE VIEW vw_Customer
AS
SELECT *
FROM Customer
WHERE address LIKE '%대한민국%';

SELECT * FROM vw_Customer;




 