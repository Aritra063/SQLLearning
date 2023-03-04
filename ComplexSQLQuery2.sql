create table customer_orders (
order_id integer,
customer_id integer,
order_date date,
order_amount integer
);
select * from customer_orders
insert into customer_orders values(1,100,cast('2022-01-01' as date),2000),(2,200,cast('2022-01-01' as date),2500),(3,300,cast('2022-01-01' as date),2100)
,(4,100,cast('2022-01-02' as date),2000),(5,400,cast('2022-01-02' as date),2200),(6,500,cast('2022-01-02' as date),2700)
,(7,100,cast('2022-01-03' as date),3000),(8,400,cast('2022-01-03' as date),1000),(9,600,cast('2022-01-03' as date),3000)
;

/*Required Output
order_date|new_customer_count|repeat_customer_count
*/

-- Solution
;WITH CTE_FirstTimeOrders
AS
(
SELECT DISTINCT
    customer_id, 
    order_date,
    ROW_NUMBER() OVER (PARTITION BY customer_id ORDER BY order_date) AS RN
FROM customer_orders
)
SELECT
    order_date,
    SUM(NewCustFlag) AS new_customer,
    COUNT(order_date) - SUM(NewCustFlag) AS repeat_customer
FROM 
(SELECT 
    CO.order_date,
    CO.customer_id,
    CASE WHEN CO.order_date = CT.order_date
            THEN 1
        ELSE 0
    END NewCustFlag
FROM CTE_FirstTimeOrders CT
JOIN customer_orders CO
ON
    CT.customer_id = CO.customer_id
WHERE CT.RN = 1) A
GROUP BY order_date