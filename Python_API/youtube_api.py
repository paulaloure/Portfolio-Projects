from googleapiclient.discovery import build
from dotenv import load_dotenv

import os


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
        id = 'UCXdxta-h8zDUc8dhGiOsi9g' 
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
        maxResults = '5'
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
        part = 'snippet',
        id = video_id_list
    )
    # snippet - contains title:'snippet': {'title':'Jak teorie spiskowe niszczą ludzi'}
    # contentDetails - contains lenght
    # statistics - contains views, likes, comments
    j=0
    video_response = request.execute()
    for video in video_response['items']:
        print(video_response['items'][j]['snippet']['title'])
        j +=1

if __name__ == '__main__':
    get_videos()