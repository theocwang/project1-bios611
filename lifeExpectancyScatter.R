library(tidyverse)

finalData <- read_csv("derivedData/finalData.csv")

figure <- finalData %>% ggplot(aes(x = allowable_count, y = life_expectancy)) + 
  geom_point(color = "darkorchid1", alpha = 0.35) + 
  geom_smooth(method='lm') + 
  labs(title = "Life Expectancy vs Allowable CAFO Count of All Counties", 
       x="CAFO Count", y="Life Expectancy (Years)") + 
  theme_minimal() + 
  theme(axis.text.y = element_text(size = 6))

ggsave("figures/lifeExpectancyScatter.png", plot=figure)