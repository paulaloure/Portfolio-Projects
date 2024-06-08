# Project 5: PYTHON - YOUTUBE API 

This project contains the following steps:\
**PART 1:** Connecting to Youtube API and extracting videos information\
**PART 2:** Saving channel and video information to excel\


**Libraries used: GoogleAPIClient, Pandas, DateTime, Dotenv**

The goal of this project was to download the list of all videos from a youtube channel, with their details and export to Excel.
As a result, 2 excel files are created (examples can be found in this repository):
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

The data may be used for further analysis of channel statistics, such as:
 - video length vs views (to make sure videos of optimal duration are posted)
 - video published day/time vs views (to see how posting date/time impacts views)
 - views vs likes vs comments (how number of views translates into likes or comments so user engagement)


**How to run on your machine**

1. Clone or download the source code
2. Make sure to create your API key here:[ console.cloud.google.com](https://console.cloud.google.com/) 
2. Save your API key to .env file as api_key (.env file is included in .gitignore file)
3. Install Google API Client by following (for Mac/Linux/Windows): https://github.com/googleapis/google-api-python-client
4. Run 'main.py' file 
