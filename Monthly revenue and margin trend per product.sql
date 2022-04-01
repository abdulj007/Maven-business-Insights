/*5. Monthly trend for revenue and margin by product, along with total sales Margin and revenue. 
Also check seasonality*/
USE Mavenfuzzyfactory;
SELECT * FROM order_items;
SELECT 
	YEAR(created_at) AS yr, 
    MONTH(created_at) AS mo, 
    SUM(CASE WHEN product_id = 1 THEN price_usd ELSE NULL END) AS mrfuzzy_rev, 
    SUM(CASE WHEN product_id = 1 THEN price_usd - cogs_usd ELSE NULL END) AS mrfuzzy_marg, 
    SUM(CASE WHEN product_id = 2 THEN price_usd ELSE NULL END) AS lovebear_rev,
    SUM(CASE WHEN product_id = 2 THEN price_usd - cogs_usd ELSE NULL END) AS lovebear_marg, 
    SUM(CASE WHEN product_id = 3 THEN price_usd ELSE NULL END) AS birthdaybear_rev,
    SUM(CASE WHEN product_id = 3 THEN price_usd - cogs_usd ELSE NULL END) AS birthdaybear_marg,
    SUM(CASE WHEN product_id = 4 THEN price_usd ELSE NULL END) AS minibear_rev, 
    SUM(CASE WHEN product_id = 4 THEN price_usd ELSE NULL END) AS minibear_marg, 
    SUM(price_usd) AS total_revenue, 
    SUM(price_usd - cogs_usd) AS total_margin
FROM order_items
GROUP BY 1,2 
ORDER BY 1,2;
