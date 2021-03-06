library(tidyverse)
library(gbm)
library(MLmetrics)
library(Rtsne)
library(caret)

# Q1
hwData <- read.csv(file = '/Users/Theo/Documents/Biology/BIOS 611/HW5/datasets_26073_33239_weight-height.csv', header=T)
hwData$Gender <- as.factor(hwData$Gender) %>% as.integer(hwData$Gender)
hwData[hwData == 1] <- 0
hwData[hwData == 2] <- 1

set.seed(50)
sample <- createDataPartition(y = hwData$Gender, p = 0.60, list=F)
trainData <- hwData[sample, ]
testData <- hwData[-sample, ]

model <- glm(Gender ~ Weight + Height, data = trainData, family=binomial)
model

prediction <- predict(model, newdata=testData, type="response")
sum((prediction > 0.5) == testData$Gender)/nrow(testData)

## Using the same seed generation (set to 50), this particular model scored much
## higher accuracy-wise compared to the model from HW4; this model scored 0.9195, 
## whereas the previous model scored only 0.435.


# Q2
## The case for filtering out rows in this particular dataset should be made;
## there is a significant number of heroes and villans who have placeholder
## values in place for missing values, namely the 0's and 1's in the power
## columns. Removing them from the final analysis would help reduce skew as 
## a result of incomplete data.

hwData2 <- read.csv(file = '/Users/Theo/Documents/Biology/BIOS 611/HW5/datasets_38396_60978_charcters_stats.csv', header=T)
hwData2 <- hwData2[-which(hwData2$Alignment == ""), ]
hwData2 <- hwData2 %>% filter(hwData2$Total > 5) %>% select(-Name)
hwData3 <- hwData2 %>% select(-Alignment)
pcs <- prcomp(hwData3)
summary(pcs)

## From my results, we only need PC1 (one component) to get 85% of the variation
## in the dataset. It's hard to say whether normalization is necessary; I could
## argue that it isn't necessary to normalize the columns in this case because
## each power is technically ranked on the same scale with the same units;
## however, normalizing the columns would also give each power column equal weight
## and variability. In this case, I would say normalization is not necessary.

## The "Total" column value does appear to be the summation of all other power
## column values combined.

xs <- pcs$rotation %>% t() %>% as_tibble() %>% `[[`("x")
ys <- pcs$rotation %>% t() %>% as_tibble() %>% `[[`("y")
xs
ys

ggplot(hwData3, aes(x=PC1, y=PC2)) + geom_point() + 
  geom_segment(data=tibble(x=c(0,0),y=c(0,0),xend=xs*pcs$sdev,yend=ys*pcs$sdev))

# Q3
pythonData <- read.csv(file = "/Users/Theo/Documents/Biology/BIOS 611/HW5/data.csv", header=T)
ggplot(pythonData, aes(x=X1, y=X2)) + geom_point(aes(color=Alignment))

## From my results, I see three distinct clusters; one is broadly spread over X1 
## from a range of -20 to just beyond 20 and X2 from just below -5 to just under
## 20. The two other clusters are more compact and circular in form. The larger
## of the two "circle" clusters is located from range -10 to -5 X1, -25 to -35 X2;
## the smaller of the "circle" clusters is located from range 23 to 28 X1, -17 to
## -21 X2, approximately. No one cluster is completely formed of a singular alignment,
## meaning both good, bad, and neutral heroes are spread out in each cluster.

# Q4
## In python notebook labeled "HW5.ipynb"

# Q5
trainIndex <- createDataPartition(hwData2$Alignment, p=0.8, list=F, times=1)

fitControl <- trainControl(method = "repeatedcv", number = 20)
gbm <- train(Alignment ~ ., data = hwData2 %>% slice(trainIndex), method = "gbm", 
             trControl = fitControl, verbose = F)
summary(gbm)

## Using gbm with 'caret' with a partition of 80% of our original data and running
## with 20 iterations, it appears as if intelligence and combat are the most
## influential individual parameters in determining character alignment. One thing
## to note, however, is that the "Total" column, which sums up the all the other
## parameters into one large value, is second in relative influence, just above
## combat and just below intelligence. So whereas combat is the next most 
## influential trait on an individual scale, a character's total summation of 
## their powers holds a lot of influence on their alignment as well.

# Q6
## Methods of cross validation like K-Fold cross validation is critical in determining
## the accuracy of the model on a general scale, that is, including data that the
## model has not used when it was training. If we reported our accuracy without
## cross validation, we would be only reporting how the model performs on our
## specifically selected training data.

# Q7
## Recursive feature elimination works, on a basic leve, by searching for subsets
## of features in a training dataset and removing features until our desired 
## number of features remain. Essentially, it will remove the weakest feature(s)
## until it reaches the number of our desired remaining features. It does so by 
## recursively looping the modeling process: it creates a model that fits the 
## training data, ranks features by importance/strength, removes a small number 
## of weak features, refits the model to the new data, and repeats until the
## desired number of features remain.