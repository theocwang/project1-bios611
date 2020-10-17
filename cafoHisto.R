library(tidyverse)

finalData <- read_csv("derivedData/finalData.csv")

figure <- finalData %>% ggplot(aes(x = allowable_count)) + 
  geom_histogram(fill="cyan3") + 
  labs(title = "Histogram of Allowable CAFO Counts") + 
  theme_minimal()

ggsave("figures/cafoHistogram.png", plot=figure)