/*2. Showcase efficiency improvements. Show quarterly figures since launch. 
From session-to-order conversion rate, revenue per order and revenue per session. */
USE Mavenfuzzyfactory;
SELECT 
	YEAR(website_sessions.created_at) AS yr, 
    QUARTER(website_sessions.created_at) AS qtr, 
    COUNT(DISTINCT orders.order_id)/ COUNT(DISTINCT website_sessions.website_session_id)
			AS session_to_order_conv_rate, 
	SUM(price_usd)/ COUNT(DISTINCT orders.order_id) AS revenue_per_order, 
    SUM(price_usd)/ COUNT(DISTINCT website_sessions.website_session_id) AS revenue_per_session
FROM website_sessions
	LEFT JOIN orders
		ON website_sessions.website_session_id = orders.website_session_id
GROUP BY 1, 2
ORDER BY 1, 2;