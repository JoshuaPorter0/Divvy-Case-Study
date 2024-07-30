import pandas as pd
import glob


# Define the path to your CSV files
csv_files_path = r'D:\Documents_And_Data\Data\Google_data_analytics_course\Cyclistic\June2023-June2024_DivvyBikeTrips\*.csv'

# Get a list of all CSV files in the directory
#csv_files = glob.glob(os.path.join(csv_directory, "*.csv"))


# Specify the desired column order
#desired_columns = ['ride_id', 'rideable_type', 'started_at', 'ended_at', 'start_station_name', 'start_station_id', 'end_station_name', 'end_station_id', 'start_lat', 'start_lng', 'end_lat', 'end_lng', 'member_casual', 'ride_length', 'day_of_week']

# Load all CSV files, clean them, and concatenate into a single DataFrame
all_files = glob.glob(csv_files_path)
df_list = []


for file in all_files:
    df = pd.read_csv(file)
    
    df_list.append(df)

df_combined = pd.concat(df_list, ignore_index=True)

# Save the cleaned and combined data
df_combined.to_csv(r'D:\Documents_And_Data\Data\Google_data_analytics_course\Cyclistic\combined_data.csv', index=False)


