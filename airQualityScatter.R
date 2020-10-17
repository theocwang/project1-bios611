library(tidyverse)

finalData <- read_csv("derivedData/finalData.csv")

figure <- finalData %>% ggplot(aes(x = allowable_count, y = air_quality_score_rating)) + 
  geom_point(color = "darkorchid1", alpha = 0.35) + 
  geom_smooth(method='lm') + 
  labs(title = "Air Quality vs Allowable CAFO Count of All Counties", 
       x="CAFO Count", y="Air Quality Score (avg Daily PM2.5)") + 
  theme_minimal() + 
  theme(axis.text.y = element_text(size = 6))

ggsave("figures/airQualityScatter.png", plot=figure)