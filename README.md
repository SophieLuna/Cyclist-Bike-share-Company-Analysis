# Introduction
Cyclistic is a Chicago-based Bike-Sharing company with more than 5,800 bicycles and 600 docking stations. The majority of Cyclistic users ride their bikes for recreational purposes, but over 30% also use them to commute for work every day. Up until now, Cyclistic’s marketing strategy has focused on raising public awareness and appealing to a wide range of consumer groups. The company offers single day passes, full day passes for a price for casual users, and provide an annual subscription fee for its members. Casual riders are those who buy one-ride or all-day passes. Cyclistic(annual) members are customers who purchase annual membership.
<br/>
<br/>
According to Cyclistic, annual members are significantly more profitable than casual users. Therefore, increasing the number of annual membership will be essential for future growth. They think that developing a marketing campaign that is targeted at casual users would help convert them into members rather than creating a marketing campaign that targets. The company has a clear objective to create marketing strategies that would persuade casual users to become members. In order to do this, they must have a deeper understanding of the difference between casual users and subscribed members, as well as an interest in analyzing the previous cycling data to help identify trends.
# Problem Statements
The Company's experts have concluded that annual members are significantly more profitable for the company than casual users, thus they believe that increasing the number of annual memberships is crucial for the company’s future.
The business-related problem statements that might be raised to increase the company's growth rate and success is shared below:
1.	How different are Cyclistic Bikes used by annual members and casual users?
2.	How can we create new marketing strategies that will encourage potential casual users to become an annual member?
# Preparing Data for Analisys
For this study, I used the 13 trip-data datasets files, which range in date from August 2021 to August 2022. To access the website and download the datasets as .zip files, click on this [link](https://divvy-tripdata.s3.amazonaws.com/index.html). The data provided is made available to access to the public.
<br/>
<br/>
In order to analyze the datasets, I’m utilizing Microsoft SQL Server Management Studio.
First, make sure to import the entire dataset to the database server as a .csv file. To merge all the datasets, make sure that each column’s data type is the same in each dataset. 
1.	Create a table in for combining all 13 tables for easier usage in order to prepare the data for future analysis.
```sql
CREATE TABLE all_data (
ride_id varchar(255),
rideable_type varchar(50),
started_at datetime,
ended_at datetime,
start_station_name varchar(100),
start_station_id varchar(50),
end_station_name varchar(100),
end_station_id varchar(50),
start_lat varchar(50),
start_lng varchar(50),
end_lat varchar(50),
end_lng varchar(50),
member_casual varchar(50)
)
```
2.	Insert the information from 13 tables using UNION
```sql
INSERT INTO dbo.all_data (ride_id, rideable_type, started_at, ended_at, start_station_name, start_station_id, end_station_name, end_station_id, start_lat, start_lng, end_lat, end_lng, member_casual)
Select ride_id, rideable_type, started_at, ended_at, start_station_name, start_station_id, end_station_name, end_station_id, start_lat, start_lng, end_lat, end_lng, member_casual
From CyslisticProject.dbo.[202108-divvy-tripdata]
UNION ALL
Select ride_id, rideable_type, started_at, ended_at, start_station_name, start_station_id, end_station_name, end_station_id, start_lat, start_lng, end_lat, end_lng, member_casual
From CyslisticProject.dbo.[202109-divvy-tripdata]
UNION ALL
Select ride_id, rideable_type, started_at, ended_at, start_station_name, start_station_id, end_station_name, end_station_id, start_lat, start_lng, end_lat, end_lng, member_casual
From CyslisticProject.dbo.[202110-divvy-tripdata]
UNION ALL
Select ride_id, rideable_type, started_at, ended_at, start_station_name, start_station_id, end_station_name, end_station_id, start_lat, start_lng, end_lat, end_lng, member_casual
From CyslisticProject.dbo.[202111-divvy-tripdata]
UNION ALL
Select ride_id, rideable_type, started_at, ended_at, start_station_name, start_station_id, end_station_name, end_station_id, start_lat, start_lng, end_lat, end_lng, member_casual
From CyslisticProject.dbo.[202112-divvy-tripdata]
UNION ALL
Select ride_id, rideable_type, started_at, ended_at, start_station_name, start_station_id, end_station_name, end_station_id, start_lat, start_lng, end_lat, end_lng, member_casual
From CyslisticProject.dbo.[202201-divvy-tripdata]
UNION ALL
Select ride_id, rideable_type, started_at, ended_at, start_station_name, start_station_id, end_station_name, end_station_id, start_lat, start_lng, end_lat, end_lng, member_casual
From CyslisticProject.dbo.[202202-divvy-tripdata]
UNION ALL
Select ride_id, rideable_type, started_at, ended_at, start_station_name, start_station_id, end_station_name, end_station_id, start_lat, start_lng, end_lat, end_lng, member_casual
From CyslisticProject.dbo.[202203-divvy-tripdata]
UNION ALL
Select ride_id, rideable_type, started_at, ended_at, start_station_name, start_station_id, end_station_name, end_station_id, start_lat, start_lng, end_lat, end_lng, member_casual
From CyslisticProject.dbo.[202204-divvy-tripdata]
UNION ALL
Select ride_id, rideable_type, started_at, ended_at, start_station_name, start_station_id, end_station_name, end_station_id, start_lat, start_lng, end_lat, end_lng, member_casual
From CyslisticProject.dbo.[202205-divvy-tripdata]
UNION ALL
Select ride_id, rideable_type, started_at, ended_at, start_station_name, start_station_id, end_station_name, end_station_id, start_lat, start_lng, end_lat, end_lng, member_casual
From CyslisticProject.dbo.[202206-divvy-tripdata]
UNION ALL
Select ride_id, rideable_type, started_at, ended_at, start_station_name, start_station_id, end_station_name, end_station_id, start_lat, start_lng, end_lat, end_lng, member_casual
From CyslisticProject.dbo.[202207-divvy-tripdata]
UNION ALL
Select ride_id, rideable_type, started_at, ended_at, start_station_name, start_station_id, end_station_name, end_station_id, start_lat, start_lng, end_lat, end_lng, member_casual
From CyslisticProject.dbo.[202208-divvy-tripdata]
```
# Processing and Analyzing of Data
Here, I will be processing and organizing data by creating new columns, extracting data, and removing inaccurate and redundant information.
1.	Add a new column calculating the ride length
```sql
 ALTER TABLE dbo.all_data
  ADD ride_length int

  UPDATE dbo.all_data
  SET ride_length = DATEDIFF(MINUTE, started_at, ended_at)
```
2.	Extract month and year from datetime and add them as new columns
```sql
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
```
3.	Delete rows where (NULL values, ride_length <= 0, ride_length > 1440 mins)
```sql
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
```
4.	Calculate average ride length for each user type and create a view
```sql
CREATE View avg_ride_length as
 SELECT member_casual as user_type, AVG(ride_length) as avg_ride
 FROM [CyslisticProject].[dbo].[all_data]
 GROUP BY member_casual
```
5.	Calculate user traffic every month 
```sql
SELECT month_num, month_m, year_y, 
COUNT(CASE WHEN member_casual = 'member' THEN 1 ELSE NULL END) as num_members,
COUNT(CASE WHEN member_casual = 'casual' THEN 1 ELSE NULL END) as num_casual,
COUNT(member_casual) as total_num
FROM CyslisticProject.dbo.all_data
GROUP BY year_y, month_num, month_m
ORDER BY year_y, month_num, month_m
```
6.	Calculate daily traffic (weekday)
```sql
SELECT day_of_week, 
COUNT(CASE WHEN member_casual = 'member' THEN 1 ELSE NULL END) as num_members,
COUNT(CASE WHEN member_casual = 'casual' THEN 1 ELSE NULL END) as num_casual,
COUNT(member_casual) as total_num
FROM CyslisticProject.dbo.all_data
GROUP BY day_of_week
ORDER BY total_num desc
```
7.	Calculate the popular hours
```sql
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
```
8.	Calculate most popular stations for casual users (limit top 10)
```sql
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
```

# Visualizing Data
In this stage, I use Tableau Public to see the analyzed data and tables that I created.
Click [here](https://public.tableau.com/app/profile/sofia2842/viz/CyclistProject_16644487594700/Dashboard1) to review.
<br/>
<br/>
Average Ride Duration:
From bar chart below we can draw a conclusion that casual members often ride bikes longer than annual members.
<br/>
<br/>
User Traffic during the week:
According to the data, casual users are more likely to use the bikes on the weekends, while members are more likely to do so during the workweek.
<br/>
<br/>
Traffic Analysis by Hour:
Even though both groups appear to prefer rides in the evening between 3:00PM - 6:00PM, members also appear to use service more frequently in the morning between 6:00AM - 9:00AM.
<br/>
<br/>
Monthly User Traffic:
The graph shows that both types of users prefer to use bikes mostly in summer months, while in winter months it is observed the least amount of traffic.

# Conclusion
After collecting, transforming, cleaning, organizing, and analyzing the 13 datasets provided, we have gathered enough factual data to make suggestions for the business-related questions posed.
We can deduce that casual users are more likely to ride longer. The majority of casual users prefer to ride on weekends, and they are also more likely to do so in the evenings between 3:00PM – 6:00PM. While summertime is when both types of user traffic are at their pick, both types of user traffic experience declines considerably during the winter.
<br/>
<br/>
We need to make use of the presented data and keep all details in mind in order to develop new marketing strategy that better target casual users and encourage them to purchase the subscription. There are some suggestions that might help to resolve this business problem:
1.	Use billboards and ads around the top 10 most visited stations where casual users spend the most time to advertise annual membership.
2.	Offer a discount on annual membership during the month with least traffic.
3.	Have regular social media commercials during the busy times of the day and peak seasons.
4.	Think about offering some amount of free minutes after 30 minutes of ride on weekdays.
5.	Think about increasing prices for casual members on weekends to encourage them to ride on workdays too.




