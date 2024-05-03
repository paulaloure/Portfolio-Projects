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
    api_request_channel()



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
    request = youtube.playlistItems().list(
        part = 'contentDetails',
        playlistId = channel_details['uploads_playlist_id'],
        maxResults = '2'
    )
    playlistItems_response = request.execute()

    next_page_Token = playlistItems_response['nextPageToken']
    

    # STOPPED HERE
    #iterate through the items - ADD THE TOKEN PAGE TO ITERATE THROU MORE THAN 50
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

    vidoes_details_list = []
    video_response = request.execute()
    for video in video_response['items']:
        video_duration = video['contentDetails']['duration']
        video_duration_hours =  (re.findall('[\d]+(?=H)', video_duration)[0] if re.findall('[\d]+(?=H)', video_duration) else 0 )
        video_duration_minutes =  (re.findall('[\d]+(?=M)', video_duration)[0] if re.findall('[\d]+(?=M)', video_duration) else 0)
        video_duration_seconds =  (re.findall('[\d]+(?=S)', video_duration)[0] if re.findall('[\d]+(?=S)', video_duration) else 0)
        video_published_date = re.findall('[\d-]+(?=T)',video['snippet']['publishedAt'])[0]
        video_published_time = re.findall('[\d:]+(?=Z)',video['snippet']['publishedAt'])[0]
        video_details = {
            'video_title': video['snippet']['title'],
            'video_published_date': video_published_date,
            'video_published_time': video_published_time,
            'video_duration': str(video_duration_hours)+ ":"+ str(video_duration_minutes) + ':' + str(video_duration_seconds),
            'video_views': video['statistics']['viewCount'],
            'video_likes': video['statistics']['likeCount'],
            'video_comments': video['statistics']['commentCount']
        }
        print(video_details)
        print()
        vidoes_details_list.append(video_details)



if __name__ == '__main__':
    get_videos()