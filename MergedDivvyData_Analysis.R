library(dplyr)
library(ggplot2)
library(tibble)

data=read.csv("D:/Documents_And_Data/Data/Google_data_analytics_course/Cyclistic/June2023_to_June2024_DivvyBikeShareData.csv")


# Remove rows with any null values
cleaned_data <- Divvy %>%
  na.omit()

# Check the structure of the data
# str(data)

# Check for any non-standard values in ride_length
unique(data$ride_length)

# Function to convert hh:mm to total minutes, returning NA for invalid formats
convert_to_minutes <- function(time_str) {
  if (grepl("^\\d{1,2}:\\d{2}$", time_str)) {
    parts <- strsplit(time_str, ":")[[1]]
    return(as.numeric(parts[1]) * 60 + as.numeric(parts[2]))
  } else {
    return(NA)
  }
}

# Apply the conversion function to the ride_length column
cleaned_data <- data %>%
  mutate(ride_length = sapply(ride_length, convert_to_minutes)) %>%
  na.omit()  # Remove rows with NA values introduced by the conversion

# Summary statistics for ride length
summary_stats <- cleaned_data %>%
  group_by(member_casual) %>%
  summarise(
    average_ride_length = mean(ride_length),
    median_ride_length = median(ride_length),
    max_ride_length = max(ride_length),
    min_ride_length = min(ride_length)
  )
print(summary_stats)


# Ensure ride_length is numeric and convert day_of_week to a factor
cleaned_data <- cleaned_data %>%
  mutate(
    ride_length = as.numeric(ride_length),
    day_of_week = factor(day_of_week, levels = c("1", "2", "3", "4", "5", "6", "7"),
                         labels = c("Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"))
  )

# Calculate the average ride length per member type and day of the week
average_ride_length_per_day <- cleaned_data %>%
  group_by(member_casual, day_of_week) %>%
  summarise(average_ride_length = mean(ride_length, na.rm = TRUE))

# Create the bar chart using ggplot2
ggplot(average_ride_length_per_day, aes(x = day_of_week, y = average_ride_length, fill = member_casual)) +
  geom_bar(stat = "identity", position = "dodge") +
  labs(
    title = "Average Ride Length by Day of the Week",
    x = "Day of the Week",
    y = "Average Ride Length (minutes)",
    fill = "Rider Type"
  ) +
  theme_minimal()





# Usage by day of the week
day_of_week_usage <- cleaned_data %>%
  group_by(day_of_week, member_casual) %>%
  summarise(
    ride_count = n()
  ) %>%
  ungroup()

# Plot usage by day of the week
ggplot(day_of_week_usage, aes(x = day_of_week, y = ride_count, fill = member_casual)) +
  geom_bar(stat = "identity", position = "dodge") +
  labs(title = "Cyclistic Usage by Day of the Week",
       x = "Day of the Week",
       y = "Number of Rides",
       fill = "Rider Type")