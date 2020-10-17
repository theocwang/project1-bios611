library(tidyverse)

finalData <- read_csv("derivedData/finalData.csv")

figure <- finalData %>% ggplot(aes(x = allowable_count, y = food_environment_index)) + 
  geom_point(color = "darkorchid1", alpha = 0.35) + 
  geom_smooth(method='lm') + 
  labs(title = "Food Environment Index vs Allowable CAFO Count of All Counties", 
       x="CAFO Count", y="Food Index") + 
  theme_minimal() + 
  theme(axis.text.y = element_text(size = 6))

ggsave("figures/foodIndexScatter.png", plot=figure)