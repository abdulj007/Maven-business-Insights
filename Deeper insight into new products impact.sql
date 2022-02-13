/*6. We dive deeper into the impact of introducing new products by pulling monthly sessions to the /products page and showing how 
the % of those sessions clicking through another page has changed over time, along with a view of how conversion 
from /products to placing an order has improved*/
-- This is a multi step analysis 
USE Mavenfuzzyfactory;
WITH products_pageviews AS (
SELECT 
	website_session_id, 
    website_pageview_id, 
    created_at AS saw_product_page_at
    
FROM website_pageviews
WHERE pageview_url = '/products' ) 

SELECT 
	YEAR(saw_product_page_at) AS yr, 
    MONTH(saw_product_page_at) AS mo, 
    COUNT(DISTINCT products_pageviews.website_session_id) AS sessions_to_product_page, 
    COUNT(DISTINCT website_pageviews.website_session_id) AS clicked_to_next_page, 
    COUNT(DISTINCT website_pageviews.website_session_id)/
    COUNT(DISTINCT products_Pageviews.website_session_id) AS clickthrough_rt, 
    COUNT(DISTINCT orders.order_id) AS orders, 
    COUNT(DISTINCT orders.order_id)/COUNT(DISTINCT products_pageviews.website_session_id) 
    AS products_to_order_rt 
FROM products_pageviews
	LEFT JOIN website_pageviews
		ON website_pageviews.website_session_id = products_pageviews.website_session_id
        AND website_pageviews.website_pageview_id > products_pageviews.website_pageview_id
	LEFT JOIN orders
		ON orders.website_session_id = products_pageviews.website_session_id
GROUP BY 1, 2; 