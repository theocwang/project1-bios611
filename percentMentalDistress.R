library(tidyverse)

finalData <- read_csv("derivedData/finalData.csv")

figure <- finalData %>% ggplot(aes(x = allowable_count, y = percent_mental_distress)) + 
  geom_point(color = "darkorchid1", alpha = 0.35) + 
  geom_smooth(method='lm') + 
  labs(title = "Mental Distress vs Allowable CAFO Count of All Counties", 
       x="CAFO Count", y="Percent Mental Distress") + 
  theme_minimal() + 
  theme(axis.text.y = element_text(size = 6))

ggsave("figures/percentMentalDistress.png", plot=figure)