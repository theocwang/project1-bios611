library(tidyverse)

finalData <- read_csv("derivedData/finalData.csv")

figure <- finalData %>% ggplot(aes(x = allowable_count)) + 
  geom_histogram(fill="cyan3") + 
  labs(title = "Histogram of Allowable CAFO Counts in all Counties") + 
  theme_minimal() + 
  facet_wrap(~county_name)

ggsave("figures/cafoHistogramCounty.png", plot=figure)