USE mavenfuzzyfactory;

/*1. Show overall volume growth. Pull overall session and order volume, trended by
 quarter for the life of the business. */

SELECT 
	YEAR (website_sessions.created_at) AS yr, 
    QUARTER (website_sessions.created_at) AS qtr, 
    COUNT(DISTINCT website_sessions.website_session_id) AS sessions, 
    COUNT(DISTINCT orders.order_id) AS orders
FROM website_sessions
	LEFT JOIN orders
		ON website_sessions.website_session_id = orders.website_session_id
GROUP BY 1, 2
ORDER BY 1 ,2; 
