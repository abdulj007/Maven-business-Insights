/*4. Overall session to order conversion rate trends for the same channels, by quarter.
 Also made note of any periods where we the business made major improvements and optimizations. */
 USE Mavenfuzzyfactory;
 SELECT 
	  YEAR(website_sessions.created_at) AS yr,
      QUARTER(website_sessions.created_at) AS qtr, 
      COUNT(DISTINCT CASE WHEN utm_source = 'gsearch' AND utm_campaign = 'nonbrand' THEN orders.order_id ELSE NULL END)
      / COUNT(DISTINCT CASE WHEN utm_source = 'gsearch' AND utm_campaign = 'nonbrand' THEN website_sessions.website_session_id ELSE NULL END) AS gsearch_nonbrand_conv_rt, 
 
	  COUNT(DISTINCT CASE WHEN utm_source = 'bsearch' AND utm_campaign = 'nonbrand' THEN orders.order_id ELSE NULL END)
      / COUNT(DISTINCT CASE WHEN utm_source = 'bsearch' AND utm_campaign = 'nonbrand' THEN website_sessions.website_session_id ELSE NULL END) AS bsearch_nonbrand_conv_rt, 
      
      COUNT(DISTINCT CASE WHEN utm_campaign = 'brand' THEN orders.order_id ELSE NULL END) / 
      COUNT(DISTINCT CASE WHEN utm_campaign = 'brand' THEN website_sessions.website_session_id ELSE NULL END) AS brand_search_conv_rt, 
      
      COUNT(DISTINCT CASE WHEN utm_source IS NULL AND http_referer IS NOT NULL THEN orders.order_id ELSE NULL END) / 
      COUNT(DISTINCT CASE WHEN utm_source IS NULL AND http_referer IS NOT NULL THEN website_sessions.website_session_id ELSE NULL END) AS organic_search_conv_rt, 
      
      COUNT(DISTINCT CASE WHEN utm_source IS NULL AND http_referer IS  NULL THEN orders.order_id ELSE NULL END) / 
      COUNT(DISTINCT CASE WHEN utm_source IS NULL AND http_referer IS  NULL THEN website_sessions.website_session_id ELSE NULL END) AS direct_type_in_conv_rt
      
FROM website_sessions
	LEFT JOIN orders
		ON website_sessions.website_session_id = orders.website_session_id
GROUP BY 1, 2
ORDER BY 1, 2;