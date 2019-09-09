# Week 3 quiz
library(AppliedPredictiveModeling)
data(segmentationOriginal)
df <- segmentationOriginal
library(caret)
library(rattle)
library(ggplot2)
library(rpart)
library(rpart.plot)

# Set up data for training (Case variable native to set stipulates which)
set.seed(125)
inTrain <- createDataPartition(df$Case, p = 0.5)
training <- df[df$Case =='Train', ]
testing <- df[df$Case !='Train', ]

# Train the model
model <- train(Class ~., data = training, method='rpart')
fancyRpartPlot(model$finalModel)

# Then just eyeball the chart and determine which way each case goes

#TotalIntench2 <- c(23,000, 50000, 57000, NA)
#FiberWidthCh1 <- c(10, 10, 8, 8)
#PerimStatusCh1 <- c(2, NA, NA, 2)
#VarIntenCh4 <- c(NA, 100, 100, 100)
#Q inp <- rbind(TotalIntench2, FiberWidthCh1, PerimStatusCh1, VarIntenCh4)
# call <- predict(model, inp)


#####
#Q2 
#####
Bias larger, vaiance smaller, k = sample size


##########
#Q3
##########
library(pgmm)
data(olive)
olive = olive[,-1]

# Fit a classification tree where Area is the outcome variable. Then predict the value of area for the following data frame using the tree command with all defaults

model <- train(Area ~., data = olive, method='rpart')

newdata = as.data.frame(t(colMeans(olive)))
newdata
predict(model, newdata = newdata)
fancyRpartPlot(model$finalModel)

#####
#Q4
#####
library(ElemStatLearn)
data(SAheart)
# SAheart$chd <- as.factor(SAheart$chd)
set.seed(8484)
train = sample(1:dim(SAheart)[1],size=dim(SAheart)[1]/2,replace=F)
trainSA = SAheart[train,]
testSA = SAheart[-train,]

set.seed(13234)

model <- train(chd ~  age + alcohol + obesity + tobacco + typea + ldl, data = trainSA, method='glm', family='binomial')


#Then set the seed to 13234 and fit a logistic regression model (method="glm", be sure to specify family="binomial") with Coronary Heart Disease (chd) as the outcome and age at onset, current alcohol consumption, obesity levels, cumulative tabacco, type-A behavior, and low density lipoprotein cholesterol as predictors. Calculate the misclassification rate for your model using this function and a prediction on the "response" scale:

missClass = function(values,prediction){sum(((prediction > 0.5)*1) != values)/length(values)}

missClass(testSA$chd, predict(model, newdata = testSA))
missClass(trainSA$chd, predict(model, newdata = trainSA))

#####
#Q5
#####
library(ElemStatLearn)
library(caret)
library(randomForest)
data(vowel.train)
data(vowel.test)
vowel.test$y <- as.factor(vowel.test$y)
vowel.train$y <- as.factor(vowel.train$y)
set.seed(33833)

model <- train(y ~., data = vowel.train, method='rf')
fore <- randomForest(y ~., data = vowel.train)

ii <- varImp(fore)
# None of the proper answers are available, just picked the closest. It was wrong.

