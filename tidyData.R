# Preparation
library(tidyverse)
library(readxl)
library(janitor)


# IMPORTING DATA
## Loading in CAFO and County Health Data
# Load in CAFO data
cafoData <- read_excel("./sourceData/List_Of_Permitted_Animal_Facilities2019-11-06.xls", sheet = 1, skip = 2)

# Load in county health data, 4th sheet
countyHealthFour <- read_excel("./sourceData/2020_County_Health_Rankings_North_Carolina_Data_-_v1_0.xlsx", sheet = 4, skip = 1)

# Load in county health data, 5th sheet
countyHealthFive <- read_excel("./sourceData/2020_County_Health_Rankings_North_Carolina_Data_-_v1_0.xlsx", sheet = 5, skip = 1)


# TIDYING AND TRANSFORMING DATA
## CAFO Data
# Dropping NAs
cafoNoNA <- drop_na(cafoData)

# Selecting only two variables from this data set; no need to focus on others
cafoVariables <- cafoNoNA %>% select(c("County Name", "Allowable Count")) %>% clean_names(case = "snake")

# "Collapsing" data rows together; 'aggregate()' will combine repeated rows together to create one sum of CAFO allowable count per county
cafoVariables <- aggregate(allowable_count~county_name, data = cafoVariables, FUN = sum)


## County Health Data
# Selecting the data variables I specified earlier using 'select()'; also renaming certain data columns using 'rename()' and cleaning them with 'clean_names()'
countyVariablesFour <- countyHealthFour %>% select(c("County", "Average Number of Physically Unhealthy Days", 
                                                     "Average Number of Mentally Unhealthy Days", "Average Daily PM2.5", 
                                                     "Food Environment Index", "% Fair or Poor Health",)) %>% 
  rename("Air Quality Score Rating" = "Average Daily PM2.5") %>% 
  rename("County Name" = "County") %>% 
  rename("Physically Unhealthy Days" = "Average Number of Physically Unhealthy Days") %>% 
  rename("Mentally Unhealthy Days" = "Average Number of Mentally Unhealthy Days") %>% 
  rename("Percent Poor Health" = "% Fair or Poor Health") %>% clean_names(case = "snake")

head(countyVariablesFour)

# Selecting the rest of the health variables from the fifth sheet
countyVariablesFive <- countyHealthFive %>% select(c("County", "Life Expectancy", "% Frequent Physical Distress", 
                                                     "% Frequent Mental Distress")) %>% 
  rename("County Name" = "County") %>% 
  rename("Percent Physical Distress" = "% Frequent Physical Distress") %>% 
  rename("Percent Mental Distress" = "% Frequent Mental Distress") %>% clean_names(case = "snake")

head(countyVariablesFive)

## Joining Data
# Joining together the county variable datasets
countyVariables <- countyVariablesFour %>% left_join(countyVariablesFive, by = c("county_name" = "county_name"))

# Joining together the county variable and CAFO datasets
finalData <- countyVariables %>% left_join(cafoVariables, by="county_name")

# Clean up the final joined dataset; replace the NA values in the CAFO data portion with 0 and drop rows without county names
finalData <- finalData %>% replace_na(list("allowable_count" = 0)) %>% drop_na("county_name")


# Write out the final dataset as a .csv file
write_csv(finalData, "derivedData/finalData.csv")