# Project 1: PYTHON - YOUTUBE API - <a href="https://github.com/paulaloure/Portfolio-Projects/tree/main/Python_API" target="_blank">see the project</a>

This project contains the following steps:

**PART 1:** Connecting to Youtube API and extracting videos information\
**PART 2:** Saving channel and video information to excel and loading to the SQL Database\
**PART 3:** Connecting PowerBI Desktop to the SQL database, loading and transforming data in PowerQuery\
**PART 4:** Creating PowerBI Dashboard



**Libraries used: GoogleAPIClient, Pandas, DateTime, Dotenv**

<br>
<br>

**Main Goal**

The goal of this project was to download the list of all videos from a youtube channel with their details, and create PowerBI dashboard based on the data. The dashboard would aim to answer below questions:
 - How many views/subscribes the channel has and how far it is from reaching next benchmark?
 - Videos posted on which weekdays have most views?
 - What would be the best video lenght to optimize number of comments and likes?
 - What are best perofrming videos in terms of views, likes and comments?
 - What is the viewers engagement? Does higher number of views translates to higher number of likes and comments?

<br>
<br>

**High level design**

![Dodaj nagłówek (4)](https://github.com/paulaloure/Portfolio-Projects/assets/96730074/a41cd59a-9ad3-47e6-982a-434b5662bc8e)

<br>
<br>

**Steps**

1. Data was downloaded from Youtube using Youtube API (googleapiclient library). In order to connect to Youtube API I have created an API key and saved it to .env file.
I have created API request to connect with the below collections:
   - channel - to get the uploads playlist ID (playlist with all the videos uploaded to the channel) and other channel statistics    
   - playlistItems - to get IDs of every video from uploads playlist
   - videos - to get video details
As many pages were returned, the script loops over all of them using page tokens. Returned data was saved as a dataframe.


2. I have created a PostgreSQL database and 2 tables with in to load data for channel and for videos:
<br>
<pre>
CREATE TABLE channel_details (
	id SERIAL PRIMARY KEY,
	channels_name VARCHAR(50) NOT NULL,
	channel_id VARCHAR(50),
	uploads_playlist_id VARCHAR(50),
	view_count VARCHAR(50),
	subscriber_count VARCHAR(50),
	video_count VARCHAR(50),
	created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
</pre>
<pre>
CREATE TABLE videos_details (
	id SERIAL PRIMARY KEY,
	video_title VARCHAR(100) NOT NULL,
	video_published_date DATE,
	video_published_time TIME,
	video_duration TIME,
	video_views INT,
	video_likes INT,
	video_comments INT
);
</pre>

3. Data was loaded to the SQL database as well as saved them to excel files with timestamps. The downloaded data contains below details (example excel files can be found in this repository):
 - Youtube_channel_details - with details regarding the youtube channel:
    - channel name
    - channel id
    - uploads playlist id (playlist containing ids of all uploaded videos)
    - number of views
    - number of subscribers
    - number of videos
 - Youtube_videos_details - list of all videos posted by channel with their:
    - titles
    - published date
    - published time
    - duration
    - views
    - likes
    - comments

  4. Next, I have used PowerBI to connect with the SQL Database and load the data. I have transformed the data using PowerQuery and created the PowerBI dashboard that aimed to answer the above questions. 
<br>
<br>

**Results** 

As a result, the below PowerBI dashboad was created. The .pbix file can also be found in the project folder.
<br>
<br>
![Screenshot 2024-07-06 115935](https://github.com/paulaloure/Portfolio-Projects/assets/96730074/f2199ce9-0e87-40dc-bbc7-cb0b7f3ddef9)
