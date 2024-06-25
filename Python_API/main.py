import time
import os
import pandas as pd


from dotenv import load_dotenv
from datetime import datetime
from youtube_api import get_videos
from sqlalchemy import create_engine

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


#loading DB password that is saved in .env file
def configure():
    load_dotenv()

#connecting to the database:
def connect_to_db():
    configure()
    user_name = 'postgres'
    host = 'localhost'
    database = 'youtube_channel'
    port = '5432'
    password = os.getenv('DB_password')
    engine = create_engine(f'postgresql://{user_name}:{password}@{host}:{port}/{database}')
    print("Successfully connected to the database")
    return engine

#exporting channel data and loading to database
def save_data(engine):
    #getting the data:
    channel_data, video_data = get_videos()
    print("Saving as dataframes")
    df_channel = convert_to_df([channel_data])
    df_videos = convert_to_df(video_data)
    #saving to excel:
    print("Saving to excel")
    df_channel.to_excel(channel_file_name)
    df_videos.to_excel(videos_file_name)
    #loading into database:
    print("Saving to database")
    df_channel.to_sql('channel_details', engine, if_exists='append', index=False)
    df_videos.to_sql('videos_details', engine, if_exists='replace', index=False)



def export_videos():
    #tracking the time the tasks take to complete:
    start_time = time.time()
    engine = connect_to_db()
    save_data(engine)
    engine.dispose()
    stop_time = time.time()
    duration = stop_time - start_time
    print("Task completed successfully")
    print(change_time_format(duration)) #printing how much time task took to complete


if __name__ == '__main__': 
    export_videos()

