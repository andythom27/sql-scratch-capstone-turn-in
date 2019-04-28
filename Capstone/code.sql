--Task 1:

SELECT COUNT(DISTINCT utm_campaign) AS 'campaigns'
FROM page_visits;

SELECT COUNT(DISTINCT utm_source) AS 'sources'
FROM page_visits;

SELECT DISTINCT utm_campaign, utm_source
FROM page_visits;

--Task 2:

SELECT DISTINCT page_name
FROM page_visits;

--Task 3:

WITH first_touch AS (
  WITH first_touch AS (
    SELECT user_id,
        MIN(timestamp) as first_touch_at
    FROM page_visits
    GROUP BY user_id)
SELECT ft.user_id,
    ft.first_touch_at,
    pv.utm_source,
        pv.utm_campaign
FROM first_touch ft
JOIN page_visits pv
    ON ft.user_id = pv.user_id
    AND ft.first_touch_at = pv.timestamp),
ft_attr AS (
  SELECT ft.user_id,
         ft.first_touch_at,
         pv.utm_source,
         pv.utm_campaign
  FROM first_touch ft
  JOIN page_visits pv
    ON ft.user_id = pv.user_id
    AND ft.first_touch_at = pv.timestamp
)
SELECT ft_attr.utm_source AS ‘source’,
       ft_attr.utm_campaign AS ‘campaign’,
       COUNT(*) AS ‘count’
FROM ft_attr
GROUP BY 1, 2
ORDER BY 3 DESC;

--Task 4:

WITH last_touch AS (
  WITH last_touch AS (
    SELECT user_id,
        MAX(timestamp) as last_touch_at
    FROM page_visits
    GROUP BY user_id)
SELECT lt.user_id,
    lt.last_touch_at,
    pv.utm_source,
        pv.utm_campaign
FROM last_touch lt
JOIN page_visits pv
    ON lt.user_id = pv.user_id
    AND lt.last_touch_at = pv.timestamp),
lt_attr AS (
  SELECT lt.user_id,
         lt.last_touch_at,
         pv.utm_source,
         pv.utm_campaign
  FROM last_touch lt
  JOIN page_visits pv
    ON lt.user_id = pv.user_id
    AND lt.last_touch_at = pv.timestamp
)
SELECT lt_attr.utm_source AS 'source',
       lt_attr.utm_campaign AS 'campaign',
       COUNT(*) AS 'count'
FROM lt_attr
GROUP BY 1, 2
ORDER BY 3 DESC;

--Task 5:

SELECT DISTINCT COUNT(user_id) AS 'completed_purchases'
FROM page_visits
WHERE page_name = '4 - purchase';

--Task 6:

WITH last_touch AS (
  WITH last_touch AS (
    SELECT user_id,
        MAX(timestamp) as last_touch_at
    FROM page_visits
    WHERE page_name = '4 - purchase'
    GROUP BY user_id)
SELECT lt.user_id,
    lt.last_touch_at,
    pv.utm_source,
        pv.utm_campaign
FROM last_touch lt
JOIN page_visits pv
    ON lt.user_id = pv.user_id
    AND lt.last_touch_at = pv.timestamp),
lt_attr AS (
  SELECT lt.user_id,
         lt.last_touch_at,
         pv.utm_source,
         pv.utm_campaign
  FROM last_touch lt
  JOIN page_visits pv
    ON lt.user_id = pv.user_id
    AND lt.last_touch_at = pv.timestamp
)
SELECT lt_attr.utm_source AS 'source',
       lt_attr.utm_campaign AS 'campaign',
       COUNT(*) AS 'count'
FROM lt_attr
GROUP BY 1, 2
ORDER BY 3 DESC; 
