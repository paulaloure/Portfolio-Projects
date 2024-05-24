from googleapiclient.discovery import build
from dotenv import load_dotenv

import os
import re

channel_id = 'UCXdxta-h8zDUc8dhGiOsi9g'

def configure():
    load_dotenv()


def get_videos():
    configure()
    api_key = os.getenv('api_key')
    global youtube
    youtube = build('youtube','v3', developerKey=api_key)
    a = api_request_channel()
    return a



def api_request_channel():

    #defining the service:
    request = youtube.channels().list(
        part = 'contentDetails, statistics',
        id = channel_id
    )
    # statistics - returns number of subsribers and number of views
    # contentDetails - related playlists: {'uploads':'UUXdxta-h8zDUc8dhGiOsi9g'} - this is the id of uploads playlist (need to extract it from there!)
  

    channel_response = request.execute()
    #getting ID of uploads_playlist - that contains all the videos uploaded to a channel
    channel_details = {
        'uploads_playlist_id': channel_response['items'][0]['contentDetails']['relatedPlaylists']['uploads'],
        'view_count': channel_response['items'][0]['statistics']['viewCount'],
        'subscriber_count': channel_response['items'][0]['statistics']['subscriberCount'],
        'video_count': channel_response['items'][0]['statistics']['videoCount']
    }
     #defining the service:
    videos_details_list = []
    next_Page_Token = None
    while True:
        request = youtube.playlistItems().list(
            part = 'contentDetails',
            playlistId = channel_details['uploads_playlist_id'],
            maxResults = '50',
            pageToken = next_Page_Token
        )
        playlistItems_response = request.execute()

        i = 0
        video_id_list = []
        for k in playlistItems_response['items']:
            video_id = playlistItems_response['items'][i]['contentDetails']['videoId']
            video_id_list.append(video_id)
            i += 1
        # print(video_id_list)


        #defining the service:
        request = youtube.videos().list(
            part = 'snippet, contentDetails, statistics',
            id = video_id_list
        )
        # snippet - contains title
        # contentDetails - contains lenght
        # statistics - contains views, likes, comments


        video_response = request.execute()
        for video in video_response['items']:
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
            # print()
            videos_details_list.append(video_details)

        next_Page_Token = playlistItems_response.get('nextPageToken')   
        if not next_Page_Token:
            break
        # print(videos_details_list)
    return videos_details_list 
         

if __name__ == '__main__':
    a = get_videos()
    print("Returned value is:", a)