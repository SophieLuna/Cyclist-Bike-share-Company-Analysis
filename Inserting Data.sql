--Creating a table for merging tables

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

--Insert data into the table
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

