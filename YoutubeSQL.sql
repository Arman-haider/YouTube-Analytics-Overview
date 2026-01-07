CREATE TABLE youtube(
Title VARCHAR(200),
channel_title VARCHAR(200),
published_date DATE,
published_time TIMESTAMP,
view_count INT,
like_count INT,
comment_count INT,
favorite_count INT,
duration INT,
definition VARCHAR(30),
caption	BOOLEAN,
engagement_rate	FLOAT8,
likes_to_views_ratio FLOAT8,
comments_to_views_ratio	FLOAT8,
duration_seconds INT,
video_age_days INT
);


ALTER TABLE youtube
ALTER COLUMN duration TYPE TEXT;


COPY youtube
FROM 'D:\Data Analysis Project\YouTube\youtube.csv'
DELIMITER ','
CSV HEADER;




--1️ Dataset me total kitne videos hain?
SELECT COUNT(*) FROM youtube;
--2 Kitne unique channels hain?
	SELECT  COUNT(DISTINCT channel_title) FROM youtube;
--3 Kya koi important column missing hai? (views, duration, date)
	SELECT 
		COUNT(*) FILTER(WHERE view_count is NULL ) AS missing_views,
		COUNT(*) FILTER(WHERE duration_seconds is NULL) AS missing_duration,
		COUNT(*) FILTER(WHERE published_date is NULL) AS missing_date
	FROM youtube;

--4 Total views kitni hain?
	SELECT SUM(view_count) AS total_views FROM youtube;

--5 Average views per video kya hain?
	SELECT AVG(view_count) AS avg_views_per_vdo FROM youtube;

--6 Sabse zyada views wali videos kaun si hain?
	SELECT title, view_count AS highest_view
	FROM youtube 
	ORDER BY view_count
	DESC LIMIT 1;



--7 Average video duration kya hai?
	SELECT AVG(duration_seconds) AS avg_vdo_duration FROM youtube;

--8 Short vs long videos me kaun zyada views laata hai?
	
	SELECT
		CASE
			WHEN duration_seconds <300 THEN 'Shorts'
			WHEN duration_seconds BETWEEN 300 AND 900 THEN 'Medium'
			ELSE 'Long'
		END AS Video_type,
		COUNT(*) AS total_vdo,
		SUM(view_count) AS Total_views,
		AVG(view_count) AS Avg_views
		FROM youtube
		GROUP BY Video_type
		ORDER BY Video_type DESC;


--9 Kya zyada lambi videos kam ya zyada perform karti hain?
	SELECT
		CASE
			WHEN duration_seconds <300 THEN 'Shorts'
			WHEN duration_seconds BETWEEN 300 AND 900 THEN 'Medium'
			ELSE 'Long'
		END AS Video_type,
		COUNT(*) AS total_vdo,
		SUM(view_count) AS Total_views,
		AVG(view_count) AS Avg_views
		FROM youtube
		GROUP BY Video_type
		ORDER BY Video_type DESC;

--10 Kaun sa channel sabse zyada views la raha hai?
	SELECT channel_title,SUM(view_count) AS max_views 
	FROM youtube
	GROUP BY channel_title
	ORDER BY SUM(view_count) DESC
	LIMIT 1;

--11 Kaun sa channel average me better perform karta hai?
	SELECT channel_title, AVG(view_count) AS avg_views
	FROM youtube
	GROUP BY channel_title
	ORDER BY avg_views DESC
	LIMIT 1;



--12 Kaun se channels kam videos me zyada views la rahe hain?
	SELECT channel_title, SUM(view_count)/COUNT(title) AS lack_vdo_max_views
	FROM youtube
	GROUP BY channel_title
	ORDER BY lack_vdo_max_views DESC;

--13 Har saal kitne videos publish hue?
	SELECT 
		EXTRACT(YEAR FROM published_date) AS year,
		COUNT(*) AS total_videos		
	FROM youtube
	GROUP BY year
	ORDER BY total_videos DESC;

--14 Time ke saath views ka trend kya hai?
	SELECT 
		EXTRACT(YEAR FROM published_date) AS Year,
		SUM(view_count) AS views_trend
	FROM youtube
	GROUP BY Year
	ORDER BY Year;
	
--15 Kaun sa publish year sabse zyada successful raha?
	SELECT 
		EXTRACT (YEAR FROM published_date) AS Year,
		SUM(view_count) AS total_yearly_views
	FROM youtube
	GROUP BY Year
	ORDER BY total_yearly_views DESC
	LIMIT 1;
	


--16 Kya short videos zyada viral hote hain?
	SELECT 
		CASE
			WHEN duration_seconds<300 THEN 'Shorts'
			WHEN duration_seconds BETWEEN 300 AND 900 THEN 'Mediumn'
			ELSE 'Long'
		END AS Video_type,
		SUM(view_count) AS total_views,
		AVG(view_count) AS avg_views
	FROM youtube
	GROUP BY Video_type
	ORDER BY total_views DESC;

	SELECT * FROM youtube;
--17 Kya frequently upload karne wale channels better perform karte hain?
	SELECT channel_title,COUNT(DISTINCT title) AS Total_videos,
		SUM(view_count)/COUNT(DISTINCT title) AS avg_views_per_vdo	
	FROM youtube
	GROUP BY channel_title
	ORDER BY avg_views_per_vdo DESC;

--18 Kya duration ka effect views pe significant hai?
SELECT
		CASE
			WHEN duration_seconds <300 THEN 'Shorts'
			WHEN duration_seconds BETWEEN 300 AND 900 THEN 'Medium'
			ELSE 'Long'
		END AS Video_type,
		COUNT(*) AS total_vdo,
		SUM(view_count) AS Total_views,
		AVG(view_count) AS Avg_views
		FROM youtube
		GROUP BY Video_type
		ORDER BY Video_type DESC;

--19 
