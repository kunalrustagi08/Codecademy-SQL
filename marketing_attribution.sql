-- Getting familiar with coolTshirts
SELECT COUNT(DISTINCT utm_campaign)
FROM page_visits;
 
SELECT COUNT (DISTINCT utm_source)
FROM page_visits;
 
SELECT DISTINCT utm_source, utm_campaign
FROM page_visits;

--Finding distinct pages
SELECT DISTINCT page_name
FROM page_visits;
 
--First touches
WITH first_touch AS
(
   SELECT user_id,
       MIN(timestamp) as first_touch_at
   FROM page_visits
   GROUP BY user_id
),
join_table_first AS
(
SELECT ft.user_id,
    ft.first_touch_at,
    pv.utm_source,
    pv.utm_campaign
FROM first_touch ft
JOIN page_visits pv
    ON ft.user_id = pv.user_id
    AND ft.first_touch_at = pv.timestamp
)
SELECT jtf.utm_campaign, COUNT(jtf.first_touch_at)
FROM join_table_first AS 'jtf'
GROUP BY 1
ORDER BY 2 DESC;

--Last touches
WITH last_touch AS
 (
    SELECT user_id,
        MAX(timestamp) as last_touch_at
    FROM page_visits
    GROUP BY user_id
 ),
join_table_last AS
(
SELECT lt.user_id,
    lt.last_touch_at,
    pv.utm_source,
    pv.utm_campaign
FROM last_touch lt
JOIN page_visits pv
    ON lt.user_id = pv.user_id
    AND lt.last_touch_at = pv.timestamp
  )
SELECT jtl.utm_campaign, COUNT(jtl.last_touch_at)
FROM join_table_last AS 'jtl'
GROUP BY 1
ORDER BY 2 DESC;

--Visitor Count
SELECT page_name, COUNT(DISTINCT user_id)
FROM page_visits
GROUP BY 1;

--Last touches for purchase page
WITH last_touch AS
 (
    SELECT user_id,
        MAX(timestamp) as last_touch_at
    FROM page_visits
    GROUP BY user_id
 ),
join_table_last AS
(
SELECT lt.user_id,
    lt.last_touch_at,
    pv.utm_source,
    pv.utm_campaign,
    pv.page_name
FROM last_touch lt
JOIN page_visits pv
    ON lt.user_id = pv.user_id
    AND lt.last_touch_at = pv.timestamp
  )
SELECT page_name, jtl.utm_campaign, COUNT(jtl.last_touch_at)
FROM join_table_last AS 'jtl'
WHERE page_name LIKE '4%';

--Re investment
SELECT utm_campaign, COUNT(utm_campaign)
FROM page_visits
GROUP BY 1 
ORDER BY 2 DESC
LIMIT 5;
 
