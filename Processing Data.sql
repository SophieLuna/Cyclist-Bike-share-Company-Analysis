/****** Скрипт для команды SelectTopNRows из среды SSMS  ******/
SELECT TOP (1000) [ride_id]
      ,[rideable_type]
      ,[started_at]
      ,[ended_at]
      ,[start_station_name]
      ,[start_station_id]
      ,[end_station_name]
      ,[end_station_id]
      ,[start_lat]
      ,[start_lng]
      ,[end_lat]
      ,[end_lng]
      ,[member_casual]
  FROM [CyslisticProject].[dbo].[all_data]

  --Add new column for calculating ride_length
  
  ALTER TABLE dbo.all_data
  ADD ride_length int

  UPDATE dbo.all_data
  SET ride_length = DATEDIFF(MINUTE, started_at, ended_at)

  --Extract month and year from datetime and create a new columns for them

 ALTER TABLE dbo.all_data
 ADD day_of_week varchar(50),
 month_m varchar(50),
 month_num int,
 year_y int,
 date_yyyy_mm_dd date

 UPDATE dbo.all_data
 SET day_of_week = DATENAME(WEEKDAY, started_at),
 month_m = DATENAME(MONTH, started_at),
 month_num = DATEPART(MONTH, started_at),
 year_y = YEAR(started_at),
 date_yyyy_mm_dd = CAST(started_at as date)

-- Delete rows where (NULL values), (ride length  <= 0), (ride_length > 1440 mins)
 
 DELETE FROM dbo.all_data
 WHERE ride_id IS NULL OR
 start_station_name IS NULL OR
 ride_length IS NULL OR
 ride_length <= 0 OR
 ride_length > 1440

 --Check for duplicants

 SELECT COUNT(DISTINCT(ride_id)) as uniq,
 COUNT(ride_id) as total
 FROM dbo.all_data

 --Calculate Number of Riders each day by User Type and create a view to store data for further visualization

 CREATE View users_per_day as
 SELECT COUNT(CASE WHEN member_casual = 'member' THEN 1 ELSE NULL END) as num_members, 
 COUNT(CASE WHEN member_casual = 'casual' THEN 1 ELSE NULL END) as num_casual, 
 COUNT(*) as num_users, 
 day_of_week
 FROM dbo.all_data
 GROUP BY day_of_week

 --Calculate average ride length for each user type and create a view

 CREATE View avg_ride_length as
 SELECT member_casual as user_type, AVG(ride_length) as avg_ride
 FROM [CyslisticProject].[dbo].[all_data]
 GROUP BY member_casual

 --Create temporary table for Casual users and Members

 CREATE TABLE #members (
ride_id varchar(255),
rideable_type varchar(50),
member_casual varchar(50),
ride_lenth int,
day_of_week varchar(50),
month_m varchar(50),
year_y int
)

INSERT INTO #members (ride_id, rideable_type, member_casual, ride_lenth, day_of_week, month_m, year_y)
(SELECT ride_id, rideable_type, member_casual, ride_length, day_of_week, month_m, year_y
FROM [CyslisticProject].[dbo].all_data
WHERE member_casual = 'member'
)

 CREATE TABLE #casual (
ride_id varchar(255),
rideable_type varchar(50),
member_casual varchar(50),
ride_lenth int,
day_of_week varchar(50),
month_m varchar(50),
year_y int
)

INSERT INTO #members (ride_id, rideable_type, member_casual, ride_lenth, day_of_week, month_m, year_y)
(SELECT ride_id, rideable_type, member_casual, ride_length, day_of_week, month_m, year_y
FROM [CyslisticProject].[dbo].all_data
WHERE member_casual = 'casual'
)

--Calculate each user traffic every month by month

SELECT month_num, month_m, year_y, 
COUNT(CASE WHEN member_casual = 'member' THEN 1 ELSE NULL END) as num_members,
COUNT(CASE WHEN member_casual = 'casual' THEN 1 ELSE NULL END) as num_casual,
COUNT(member_casual) as total_num
FROM CyslisticProject.dbo.all_data
GROUP BY year_y, month_num, month_m
ORDER BY year_y, month_num, month_m

--Calculate traffic by day of the week

SELECT day_of_week, 
COUNT(CASE WHEN member_casual = 'member' THEN 1 ELSE NULL END) as num_members,
COUNT(CASE WHEN member_casual = 'casual' THEN 1 ELSE NULL END) as num_casual,
COUNT(member_casual) as total_num
FROM CyslisticProject.dbo.all_data
GROUP BY day_of_week
ORDER BY total_num desc

--Calculate the popular hours

ALTER TABLE CyslisticProject.dbo.all_data
ADD hour_h int

UPDATE CyslisticProject.dbo.all_data
SET hour_h = DATEPART(HOUR, started_at)

SELECT hour_h,
COUNT(CASE WHEN member_casual = 'member' THEN 1 ELSE NULL END) as num_members,
COUNT(CASE WHEN member_casual = 'casual' THEN 1 ELSE NULL END) as num_casual,
COUNT(member_casual) as total_num
FROM CyslisticProject.dbo.all_data
GROUP BY hour_h
ORDER BY hour_h

--Calculate most popular stations for casual users (limit top 10)
SELECT 
TOP 10 start_station_name as station_name,
SUM(CASE WHEN member_casual = 'casual' THEN 1 ELSE NULL END) as num_casual
FROM CyslisticProject.dbo.all_data
GROUP BY start_station_name
ORDER BY num_casual desc

--Here I understand that there are a lot of rows without station name, probably blank or using space, so I deleted them
SELECT *
FROM CyslisticProject.dbo.all_data
WHERE start_station_name is null

SELECT distinct start_station_name 
FROM CyslisticProject.dbo.all_data
ORDER BY start_station_name

DELETE FROM CyslisticProject.dbo.all_data
WHERE start_station_name = '' OR
start_station_name = ' '