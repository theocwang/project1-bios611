library(tidyverse)

finalData <- read_csv("derivedData/finalData.csv")

figure <- finalData %>% ggplot(aes(x = allowable_count, y = percent_physical_distress)) + 
  geom_point(color = "darkorchid1", alpha = 0.35) + 
  geom_smooth(method='lm') + 
  labs(title = "Physical Distress vs Allowable CAFO Count of All Counties", 
       x="CAFO Count", y="Percent Physical Distress") + 
  theme_minimal() + 
  theme(axis.text.y = element_text(size = 6))

ggsave("figures/percentPhysicalDistress.png", plot=figure)