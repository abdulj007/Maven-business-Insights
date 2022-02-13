/* 7. 4th product available as a primary product on 05-12-2014 
(it was previously only a cross-sell item) We Pull sales data since then and show how well each 
product cross-sells from one another.*/

USE mavenfuzzyfactory;
CREATE TEMPORARY TABLE primary_products
SELECT 
	order_id,
    primary_product_id, 
    created_at AS ordered_at
FROM orders
WHERE created_at > '2014-12-05' -- when 4th product was added. 
 ;   
SELECT 
	 primary_product_id, 
     COUNT(DISTINCT order_id) AS total_orders, -- The Metrics needed per primary_product_id
     COUNT(DISTINCT CASE WHEN cross_sell_product_id = 1 THEN order_id ELSE NULL END) AS _xsold_p1,
	 COUNT(DISTINCT CASE WHEN cross_sell_product_id = 2 THEN order_id ELSE NULL END) AS _xsold_p2,
     COUNT(DISTINCT CASE WHEN cross_sell_product_id = 3 THEN order_id ELSE NULL END) AS _xsold_p3,
     COUNT(DISTINCT CASE WHEN cross_sell_product_id = 1 THEN order_id ELSE NULL END) AS _xsold_p4,
     COUNT(DISTINCT CASE WHEN cross_sell_product_id = 1 THEN order_id ELSE NULL END)/
     COUNT(DISTINCT order_id) AS p1_xsell_rt, 
     COUNT(DISTINCT CASE WHEN cross_sell_product_id = 2 THEN order_id ELSE NULL END)/
     COUNT(DISTINCT order_id) AS p2_xsell_rt, 
     COUNT(DISTINCT CASE WHEN cross_sell_product_id = 3 THEN order_id ELSE NULL END)/
     COUNT(DISTINCT order_id) AS p3_xsell_rt, 
     COUNT(DISTINCT CASE WHEN cross_sell_product_id = 4 THEN order_id ELSE NULL END)/
     COUNT(DISTINCT order_id) AS p4_xsell_rt
FROM
(
SELECT 
	primary_products.*,
    order_items.product_id AS cross_sell_product_id
FROM primary_products
	LEFT JOIN order_items
		ON order_items.order_id = primary_products.order_id
        AND order_items.is_primary_item = 0 -- only bringing in cross-sells;
  ) AS primary_w_cross_sell
  GROUP BY 1