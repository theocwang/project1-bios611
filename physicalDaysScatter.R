library(tidyverse)

finalData <- read_csv("derivedData/finalData.csv")

figure <- finalData %>% ggplot(aes(x = allowable_count, y = physically_unhealthy_days)) + 
  geom_point(color = "darkorchid1", alpha = 0.35) + 
  geom_smooth(method='lm') + 
  labs(title = "Physically Unhealthy Days vs Allowable CAFO Count of All Counties", 
       x="Allowable Count", y="Average Number of Physically Unhealthy Days") + 
  theme_minimal() + 
  theme(axis.text.y = element_text(size = 6))

ggsave("figures/physicalDaysScatter.png", plot=figure)