from googleapiclient.discovery import build
from dotenv import load_dotenv

import os
import re


# INSERT CHANNEL ID OF CHANNEL YOU WANT TO DOWNLOAD ALL VIDEOS DATA
channel_id = 'UCXdxta-h8zDUc8dhGiOsi9g'

#loading API key that is saved in .env file
def configure():
    load_dotenv()


# building an service object and getting the data 
def get_videos():
    configure()
    api_key = os.getenv('api_key')
    global youtube
    youtube = build('youtube','v3', developerKey=api_key)
    print("Successfully Connected")
    channel_details, video_details = api_request_channel()
    youtube.close()
    return channel_details, video_details


# creating api request
# using the below collections:
#    - channel - getting uploads playlist ID and other channel statistics
#    - playlistItems - getting ID of every video from uploads playlist
#    - videos - getting video details
def api_request_channel():

    #defining the service - collection - channels:
    request = youtube.channels().list(
        part = 'snippet, contentDetails, statistics',
        id = channel_id
    )
    # snippet - channel's name
    # statistics - returns number of subsribers and number of views
    # contentDetails - related playlists, also including uploads playlist
    

    channel_response = request.execute()
    print("Getting channel information...")
    #getting needed information from the request response
    channel_details = {
        'channels_name': channel_response['items'][0]['snippet']['title'],
        'channel_id': channel_id,
        'uploads_playlist_id': channel_response['items'][0]['contentDetails']['relatedPlaylists']['uploads'],
        'view_count': int(channel_response['items'][0]['statistics']['viewCount']),
        'subscriber_count':int(channel_response['items'][0]['statistics']['subscriberCount']),
        'video_count': int(channel_response['items'][0]['statistics']['videoCount'])
    }
    #print(channel_details)
    #creating the list that will be used to gather videos informations
    videos_details_list = []

    #looping over the pages with responses (max 50 results per page)
    next_Page_Token = None
    print("Getting video information...")
    while True:
        request = youtube.playlistItems().list(
            part = 'contentDetails',
            playlistId = channel_details['uploads_playlist_id'],
            maxResults = '50',
            pageToken = next_Page_Token
        )
        playlistItems_response = request.execute()
        #saving videos ids into a list
        i = 0
        video_id_list = []
        for k in playlistItems_response['items']:
            video_id = playlistItems_response['items'][i]['contentDetails']['videoId']
            video_id_list.append(video_id)
            i += 1
        # print(video_id_list)


        #defining the service - collection videos:
        request = youtube.videos().list(
            part = 'snippet, contentDetails, statistics',
            id = video_id_list
        )
        # snippet - contains title
        # contentDetails - contains video lenght
        # statistics - contains views, likes, comments


        video_response = request.execute()
        for video in video_response['items']:
            #formatting information from request response:
            video_duration = video['contentDetails']['duration']
            video_duration_hours =  (re.findall('[\d]+(?=H)', video_duration)[0] if re.findall('[\d]+(?=H)', video_duration) else 0 )
            video_duration_minutes =  (re.findall('[\d]+(?=M)', video_duration)[0] if re.findall('[\d]+(?=M)', video_duration) else 0)
            video_duration_seconds =  (re.findall('[\d]+(?=S)', video_duration)[0] if re.findall('[\d]+(?=S)', video_duration) else 0)
            video_published_date = re.findall('[\d-]+(?=T)',video['snippet']['publishedAt'])[0]
            video_published_time = re.findall('[\d:]+(?=Z)',video['snippet']['publishedAt'])[0]
            try:
                video_comments = video['statistics']['commentCount']
            except:
                video_comments = 0
            #saving video details as dictionary:
            video_details = {
                'video_title': video['snippet']['title'],
                'video_published_date': video_published_date,
                'video_published_time': video_published_time,
                'video_duration': str(video_duration_hours)+ ":"+ str(video_duration_minutes) + ':' + str(video_duration_seconds),
                'video_views': int(video['statistics']['viewCount']),
                'video_likes': int(video['statistics']['likeCount']),
                'video_comments': int(video_comments)
            }
            # print(video_details)
            #adding details of every video into a list
            videos_details_list.append(video_details)

        next_Page_Token = playlistItems_response.get('nextPageToken')   
        if not next_Page_Token:
            break
    # print(channel_details)
    return channel_details, videos_details_list 
         

if __name__ == '__main__':
    a, b = get_videos()
    print("Returned value is:", a, b)