-- **SPOTIFY DATA ANALYSIS (EDA) **

--CREATE TABLE NAMED SPOTIFY

CREATE TABLE spotify (
    artist VARCHAR(255),
    track VARCHAR(255),
    album VARCHAR(255),
    album_type VARCHAR(50),
    danceability FLOAT,
    energy FLOAT,
    loudness FLOAT,
    speechiness FLOAT,
    acousticness FLOAT,
    instrumentalness FLOAT,
    liveness FLOAT,
    valence FLOAT,
    tempo FLOAT,
    duration_min FLOAT,
    title VARCHAR(255),
    channel VARCHAR(255),
    views FLOAT,
    likes BIGINT,
    comments BIGINT,
    licensed BOOLEAN,
    official_video BOOLEAN,
    stream BIGINT,
    energy_liveness FLOAT,
    most_played_on VARCHAR(50)
);


--COUNT OF ROWS
SELECT COUNT(*) FROM SPOTIFY


-- COUNT OF INDIVIDUAL ARTIST
SELECT COUNT(DISTINCT ARTIST) FROM SPOTIFY


-- COUNT OF ALBUM TYPES
SELECT DISTINCT ALBUM_TYPE FROM SPOTIFY


--MAXIMUM SONG DURATION 
SELECT MAX(DURATION_MIN) FROM SPOTIFY


--MINIMUM SONG DURATION
SELECT MIN(DURATION_MIN) FROM SPOTIFY


-- SONG CAN'T BE HAVING 0.00 DURATION... THAT MUST BE AN ERROR. WE HAVE TO REMOVE THOSE ROWS. TO DO THAT...
DELETE FROM SPOTIFY
WHERE DURATION_MIN =0;


--MINIMUM SONG DURATION
SELECT MIN(DURATION_MIN) FROM SPOTIFY


-- FINDING UNIQUE CHANNEL  
SELECT DISTINCT CHANNEL FROM SPOTIFY

----------------------------------------------------------------------------------------

-- EXPLORATORY DATA ANALYSIS BASED ON CONDITIONS --


--1) Retrieve the names of all tracks that have more than 1 billion streams.

SELECT * FROM SPOTIFY
WHERE STREAM >= 10^9


--2) List all albums along with their respective artists.

SELECT DISTINCT ALBUM , ARTIST FROM SPOTIFY


--3) Get the total number of comments for tracks where `licensed = TRUE`.

SELECT SUM(COMMENTS) AS TOTAL_COMMENTS
FROM SPOTIFY
WHERE LICENSED = 'true'


--4) Find all tracks that belong to the album type `single`.

SELECT * FROM SPOTIFY
WHERE ALBUM_TYPE ilike 'single'


--5) Count the total number of tracks by each artist.

SELECT ARTIST, COUNT(TRACK) AS TOTAL_TRACKS
FROM SPOTIFY
GROUP BY ARTIST 
ORDER BY 2;



--6) Calculate the average danceability of tracks in each album.

SELECT ALBUM, AVG(DANCEABILITY) AS AVG_DANCE
FROM SPOTIFY
GROUP BY 1
ORDER BY 2 DESC;


--7) Find the top 5 tracks with the highest energy values.

SELECT TRACK , MAX(ENERGY) AS HIGH_ENERGY_VALUES
FROM SPOTIFY
GROUP BY 1
ORDER BY 2 DESC
LIMIT 5;


--8) List all tracks along with their views and likes where `official_video = TRUE`.

SELECT TRACK,
SUM(VIEWS) AS TOTAL_VIEWS,
SUM(LIKES) AS TOTAL_LIKES
FROM SPOTIFY
WHERE OFFICIAL_VIDEO = TRUE
GROUP BY 1
ORDER BY 2 DESC;


--9) For each album, calculate the total views of all associated tracks.

SELECT DISTINCT ALBUM,SUM(VIEWS)
FROM SPOTIFY
GROUP BY 1
ORDER BY 2 DESC;


--10) Retrieve the track names that have been streamed on Spotify more than YouTube.

SELECT * FROM
(SELECT TRACK,
COALESCE(SUM(CASE WHEN MOST_PLAYED_ON = 'Youtube' THEN STREAM END),0) AS STREAM_YOUTUBE,
COALESCE(SUM(CASE WHEN MOST_PLAYED_ON = 'Spotify' THEN STREAM END),0) AS STREAM_SPOTIFY
FROM SPOTIFY
GROUP BY 1
) AS T1

WHERE STREAM_SPOTIFY>STREAM_YOUTUBE
AND STREAM_YOUTUBE <>0;


--11) Find the top 3 most-viewed tracks for each artist using window functions.

WITH RANKING_ARTIST
AS (
SELECT ARTIST,TRACK,SUM(VIEWS) AS TOTAL_VIEWS,
DENSE_RANK() OVER(PARTITION BY ARTIST ORDER BY SUM(VIEWS) DESC) AS RANK
FROM SPOTIFY
GROUP BY 1,2
ORDER BY 1,3 DESC
)

SELECT * FROM RANKING_ARTIST
WHERE RANK <=3;


--12) Write a query to find tracks where the liveness score is above the average.

SELECT TRACK,ARTIST,LIVENESS FROM SPOTIFY
WHERE LIVENESS > (SELECT AVG(LIVENESS) FROM SPOTIFY)


--13) Use a `WITH` clause to calculate the difference between the highest and lowest energy values for tracks in each album.

WITH CTE AS
(
SELECT 
	ALBUM,
	MAX(ENERGY) AS HIGH_ENERGY,
	MIN(ENERGY) AS LOW_ENERGY
FROM SPOTIFY
GROUP BY 1
)

SELECT ALBUM,HIGH_ENERGY - LOW_ENERGY AS DIFF
FROM CTE
ORDER BY 2 DESC;


--14) Find tracks where the energy-to-liveness ratio is greater than 1.2

SELECT DISTINCT ALBUM,TRACK,(ENERGY / LIVENESS) AS ENERGY_TO_LIVENESS_RATIO
FROM SPOTIFY
WHERE (ENERGY / LIVENESS) > 1.2;


--15) Calculate the cumulative sum of likes for tracks ordered by the number of views, using window functions.

SELECT ARTIST,TRACK,ALBUM,VIEWS,LIKES,
SUM(LIKES) OVER (ORDER BY VIEWS DESC) AS CUMULATIVE_LIKES
FROM SPOTIFY
ORDER BY Views DESC;

--+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-
