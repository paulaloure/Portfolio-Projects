import schedule #install in venv
import time
import pandas as pd


from youtube_api import get_videos




def change_time_format(time_in_seconds):
    duration_hours = int(time_in_seconds//3600)
    time_in_seconds %= 3600 # we take out the hours, and leave only the remainder (time_in_seconds = time_in_seconds % 3600)
    duration_minutes = int(time_in_seconds//60)
    duration_seconds = int(time_in_seconds%60) #remainder - what remains after calculating minutes, for example 123s = 2 minutes and 3 seconds
    return f'Task took {duration_hours} hours, {duration_minutes} minutes and {duration_seconds} seconds to complete'





# if I run this script, only main will run
# def get_YT_data():
#     start_time = time.time()
#     #total time that the function run:
#     videos_dic_list = get_videos()
#     stop_time = time.time()
#     duration = stop_time - start_time
#     print(change_time_format(duration)) #printing how much time task took to complete
#     return videos_dic_list

def convert_to_df(video_data):
    videos_table = pd.DataFrame(video_data)
    return videos_table

# def save_df_to_excel(df_videos):
#     file_name = "Youtube_videos.xlsx"
#     df_videos.to_excel(file_name)



def export_videos():
    start_time = time.time()
    #total time that the function run:
    video_data = get_videos()
    stop_time = time.time()
    duration = stop_time - start_time
    print(change_time_format(duration)) #printing how much time task took to complete
    # print(video_data)
    df_videos = convert_to_df(video_data)
    print("Export completed")
    return df_videos






if __name__ == '__main__': 
    #scheduling the task
    #schedule.every().monday.at('15:00:00').do(get_YT_data)
    df_videos = export_videos()
    file_name = "Youtube_videos.xlsx"
    df_videos.to_excel(file_name)
    # save_df_to_excel(df_videos)
    # schedule.every(5).hours.do(save_df_to_excel, df_videos)

    # #running scheduled tasks
    # while True:
    #     schedule.run_pending()
    #     time.sleep(1)