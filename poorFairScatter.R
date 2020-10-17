library(tidyverse)

finalData <- read_csv("derivedData/finalData.csv")

figure <- finalData %>% ggplot(aes(x = allowable_count, y = percent_poor_health)) + 
  geom_point(color = "darkorchid1", alpha = 0.35) + 
  geom_smooth(method='lm') + 
  labs(title = "Poor/Fair Health vs Allowable CAFO Count of All Counties", 
       x="CAFO Count", y="Percent Poor/Fair Health") + 
  theme_minimal() + 
  theme(axis.text.y = element_text(size = 6))

ggsave("figures/poorFairScatter.png", plot=figure)