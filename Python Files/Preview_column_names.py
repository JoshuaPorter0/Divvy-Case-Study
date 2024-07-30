import pandas as pd
import glob
import os

csv_files_path = r'D:\Documents_And_Data\Data\Google_data_analytics_course\Cyclistic\June2023-June2024_DivvyBikeTrips\*.csv'

file_name = os.path.basename(csv_files_path)

all_files = glob.glob(csv_files_path)
df_list = []


for file in all_files:
    df = pd.read_csv(file)

    print(file_name)
    print(df.columns) # Check the actual column names
    print(df['started_at'].dtype)  # Check the data type of the column
