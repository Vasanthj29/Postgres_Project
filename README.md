--Spotify Data Analysis-- 


Project Overview;

This SQL project performs Exploratory Data Analysis (EDA) on a Spotify dataset containing track, artist, and album information along with audio features and engagement metrics.

Dataset Structure;

The dataset contains the following columns:

Artist: Track performer

Track: Song title

Album: Album name

Audio Features: Danceability, Energy, Loudness, Speechiness, Acousticness, etc.

Engagement Metrics: Views, Likes, Comments, Streams

Metadata: Album type, Licensing status, Official video flag

Key Analyses Performed;

1. Data Quality Checks
Removed invalid records (0 duration tracks)

Verified data completeness

Identified unique values in categorical columns

2. Basic Aggregations
Track counts by artist

Album type distribution

Min/max duration analysis

Channel/platform analysis

3. Advanced Analytics
Streaming Platform Comparison: Spotify vs YouTube performance

Top Tracks Identification: Per artist based on views

Audio Feature Analysis: Energy, danceability, liveness correlations

Engagement Trends: Cumulative likes by view count

4. Business Insights
Most successful albums by total views

High-energy tracks identification

Licensed content performance

Official video impact analysis

SQL Techniques Used
✔ Aggregate Functions: COUNT(), SUM(), AVG(), MAX(), MIN()
✔ Window Functions: DENSE_RANK(), SUM() OVER()
✔ Conditional Logic: CASE WHEN, WHERE filters
✔ Data Cleaning: Invalid record removal
✔ Subqueries & CTEs: For complex calculations


How to Use ; 

Install PostgreSQL and pgAdmin (if not already installed).

Run the CREATE TABLE statement to set up the database structure

Import your Spotify dataset

Execute queries sequentially:

Start with data quality checks

Proceed to basic aggregations

Run advanced analytics queries

Modify filters/parameters as needed for your analysis

License ;

This project was inspired by the tutorial from "Zero Analyst" YouTube channel.
The dataset and analysis approach are based on their Netflix Data Analysis tutorial.




