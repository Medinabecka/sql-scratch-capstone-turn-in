SELECT COUNT (DISTINCT utm_campaign) AS ‘Campaigns’
FROM page_visits;
--
SELECT COUNT (DISTINCT utm_source) AS ‘Sources’
FROM page_visits;
--

SELECT DISTINCT utm_campaign AS Campaigns,
  	utm_source AS Sources
  FROM page_visits;

--
SELECT DISTINCT page_name AS ‘Pages’
FROM page_visits;

WITH first_touch AS (
  SELECT user_id,
  	MIN(timestamp) as 'first_touch_at'
  FROM page_visits
  GROUP BY user_id)
SELECT ft.user_id,
  ft.first_touch_at,
  pv.utm_source,
	pv.utm_campaign
FROM first_touch AS 'ft'
JOIN page_visits AS 'pv'
  ON ft.user_id = pv.user_id
  AND ft.first_touch_at = pv.timestamp,
ft_attr AS (
	SELECT ft.user_id,
  	ft.first_touch_at,
  	pv.utm_source,
  	pv.utm_campaign
  FROM first_touch AS 'ft'
  JOIN page_visits AS 'pv'
  	ON ft.user_id = pv.user_id
  	AND ft.first_touch_at = pv.timestamp)
SELECT ft_attr.utm_source AS 'Source',
	ft.attr.utm_campaign AS 'Campaign',
  COUNT(*)
FROM ft_attr
GROUP BY 1, 2
ORDER BY 3 DESC;
--

WITH last_touch AS (
    SELECT user_id,
       MAX(timestamp) AS 'last_touch_at'
    FROM page_visits
    GROUP BY user_id),
ft_attr AS (
  SELECT lt.user_id,
  	lt.last_touch_at,
  	pv.utm_source,
  	pv.utm_campaign
  FROM last_touch AS 'lt'
  JOIN page_visits AS 'pv'
  	ON lt.user_id = pv.user_id
  	AND lt.last_touch_at = pv.timestamp
)
SELECT ft_attr.utm_source AS 'Source',
	ft_attr.utm_campaign AS 'Campaign'
  COUNT(*) AS 'Count'
FROM ft_attr
GROUP BY 1, 2
ORDER BY 3 DESC;


--

SELECT COUNT (DISTINCT user_id) AS 'Conversions'
FROM page_visits
WHERE page_name = '4 - purchase';

--

WITH last_touch AS (
  SELECT user_id,
    	MAX(timestamp) AS last_touch_at
  FROM page_visits
  WHERE page_name = '4 - purchase'
  	GROUP BY user_id),
ft_attr AS (
SELECT lt.user_id,
    lt.last_touch_at,
    pv.utm_source,
		pv.utm_campaign
FROM last_touch AS 'lt'
JOIN page_visits AS 'pv'
  ON ft.user_id = pv.user_id
  AND ft.first_touch_at = pv.timestamp
)
SELECT ft_attr.utm_source AS 'source',
	ft_attr.utm_campaign AS 'Campaign',
  COUNT(*) AS 'Count'
FROM ft_attr
GROUP BY 1, 2
ORDER BY 3 DESC;


--



