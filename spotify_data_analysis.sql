-- Create a table for spotify data analysis
CREATE TABLE spotify (
    ArtistName TEXT,
    EndTime DATETIME,
    TrackName TEXT,
    MsPlayed BIGINT,
    Date DATE,
    Year BIGINT,
    Month TEXT,
    DayName TEXT,
    Hour INT,
    MinutesPlayed DOUBLE,
    IsSkipped TEXT
);


-- Total number of tracks played
select count(*) as total_track
from spotify;

-- Show Start & End Date
select 
min(date) as start_date,
max(date) as end_date
from spotify; 


-- Total minutes listened
select round(sum(MinutesPlayed),2) as total_minutes
from spotify;


-- Total unique artists
select count(distinct(ArtistName)) as Unique_Artists
from spotify;


-- Total unique TrackName
select count(distinct(TrackName)) as Unique_track
from spotify;


-- Average listening time per track
select round(avg(MinutesPlayed),2) as avg_listening_time
from spotify;


-- Top 10 most played TrackName
select TrackName,
round(sum(MinutesPlayed),2) as Total_Minutes
from spotify
group by TrackName
order by Total_Minutes desc
limit 10;


-- Top 10 Artists
select ArtistName,
round(sum(MinutesPlayed),2) as total_minutes
from spotify
group by ArtistName
order by total_minutes desc 
limit 10;


-- Which day do I listen most?
select DayName,
round(sum(MinutesPlayed),2) as total_minutes
from spotify
group by DayName
order by total_minutes desc;


-- Which hour is peak listening?
select Hour,
round(sum(MinutesPlayed),2) as total_minutes
from spotify
group by Hour
order by total_minutes desc;


-- Skipped vs Not Skipped
SELECT 
    IsSkipped,
    COUNT(*) AS total_plays,
    ROUND(SUM(MinutesPlayed),2) AS total_minutes
FROM spotify
GROUP BY IsSkipped;


-- Top song per artist
select ArtistName, TrackName, total_minutes
from (
      select ArtistName, 
      TrackName, 
      round(sum(MinutesPlayed),2) as total_minutes,
      row_number() over(
      partition by ArtistName order by sum(MinutesPlayed) desc )as row_no
      from spotify
      group by ArtistName, TrackName
      )t
      Where row_no =1;