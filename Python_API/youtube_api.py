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
    # api_request_channel()
    api_requests_playlistItems()
    #api_request_videos()




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
    return channel_details



def api_requests_playlistItems():
     #defining the service:
    request = youtube.playlistItems().list(
        part = 'contentDetails',
        playlistId = api_request_channel()['uploads_playlist_id'],
        maxResults = '2'
    )
    playlistItems_response = request.execute()
    next_page_Token = playlistItems_response['nextPageToken']

    # for i in playlistItems_response['items']:
    #     print(playlistItems_response['items'][0]['contentDetails']['videoId'])
    #     print('-----')
    # video_id = playlistItems_response['items'][0]['contentDetails']['videoId']
    # print(video_id)


    # STOPPED HERE
    #iterate through the items
    for i in range()
    for k in playlistItems_response['items']:
        print(playlistItems_response['items'][0]['contentDetails']['videoId'])
        # print(v)
        print('---')
    #contentDetails - video ID

def api_request_videos():

    #defining the service:
    request = youtube.videos().list(
        part = 'snippet, contentDetails, statistics',
        id = 'kRUz_gaUJSo'
    )
    # snippet - contains title:'snippet': {'title':'Jak teorie spiskowe niszczą ludzi'}
    # contentDetails - contains lenght
    # statistics - contains views, likes, comments

    response = request.execute()
    print(response)

if __name__ == '__main__':
    get_videos()