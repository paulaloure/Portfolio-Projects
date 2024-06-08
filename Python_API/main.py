import time
import pandas as pd

from datetime import datetime
from youtube_api import get_videos

#Creating file names that will be used to save excel files with data
channel_file_name = "Youtube_channel_details_" + datetime.now().strftime("%Y-%m-%d_%I-%M") + ".xlsx"
videos_file_name = "Youtube_videos_details_" + datetime.now().strftime("%Y-%m-%d_%I-%M") + ".xlsx"

#changing the time format
def change_time_format(time_in_seconds):
    duration_hours = int(time_in_seconds//3600)
    time_in_seconds %= 3600 # we take out the hours, and leave only the remainder (time_in_seconds = time_in_seconds % 3600)
    duration_minutes = int(time_in_seconds//60)
    duration_seconds = int(time_in_seconds%60) #remainder - what remains after calculating minutes, for example 123s = 2 minutes and 3 seconds
    return f'Task took {duration_hours} hours, {duration_minutes} minutes and {duration_seconds} seconds to complete'

#converting exported data to dataframe
def convert_to_df(video_data):
    videos_table = pd.DataFrame(video_data)
    return videos_table

#exporting channel data
def export_videos():
    start_time = time.time()
    #total time that the function run:
    channel_data, video_data = get_videos()
    print("Saving as dataframes")
    df_channel = convert_to_df([channel_data])
    df_videos = convert_to_df(video_data)
    print("Saving to excel")
    df_channel.to_excel(channel_file_name)
    df_videos.to_excel(videos_file_name)
    stop_time = time.time()
    duration = stop_time - start_time
    print("Task completed successfully")
    print(change_time_format(duration)) #printing how much time task took to complete




if __name__ == '__main__': 
    export_videos()

