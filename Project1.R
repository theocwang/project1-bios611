library(tidyverse)
library(readxl)
library(janitor)

countyData4 <- read_excel("./2020 County Health Rankings North Carolina Data - v1_0.xlsx", sheet = 4, skip = 1)

countyVariables <- countyData4 %>% select(c("County", "Average Number of Mentally Unhealthy Days", "Average Daily PM2.5", "Food Environment Index", "# Mental Health Providers")) %>% 
  rename("Air Quality Score Rating" = "Average Daily PM2.5") %>% rename("County Name" = "County") %>% 
  rename("Number of Mental Health Providers" = "# Mental Health Providers" ) %>% clean_names(case = "snake") %>% drop_na("county_name")
head(countyVariables)

countyVariables %>% ggplot(aes(x = air_quality_score_rating)) + geom_histogram(fill="maroon") + labs(title = "Histogram of Air Quality Score Ratings") + theme_minimal()

countyVariables %>% ggplot(aes(x = air_quality_score_rating, y = food_environment_index)) + geom_point(color="maroon") + geom_smooth() +
  labs(title = "Scatter Plot of Air Quality versus Food Index Scores") + theme_minimal()

countyVariables %>% ggplot(aes(x = number_of_mental_health_providers, y = average_number_of_mentally_unhealthy_days))  + geom_point(color="maroon") + geom_smooth() + 
  labs(title = "Scatter Plot of Mentally Unhealthy Days versus Number of Mental Health Providers") + theme_minimal()