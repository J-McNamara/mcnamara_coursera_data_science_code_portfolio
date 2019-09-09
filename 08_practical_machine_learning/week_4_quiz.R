# Work for week 4 quiz

#####
#Q1
#####
library(ElemStatLearn)
data(vowel.train)
data(vowel.test)
set.seed(33833)
vowel.test$y <- as.factor(vowel.test$y)
vowel.train$y <- as.factor(vowel.train$y)

rf <- train(y ~., data = vowel.train, method='rf')
bo <- train(y ~., data = vowel.train, method='gbm')

rf_eval <- confusionMatrix(vowel.test$y, predict(rf, vowel.test))
bo_eval <- confusionMatrix(vowel.test$y, predict(bo, vowel.test))
agree_eval <- confusionMatrix(predict(rf, vowel.test), predict(bo, vowel.test))

rf_eval$overall
bo_eval$overall
agree_eval$overall

##########
#Q2
##########
library(caret)
library(gbm)
set.seed(3433)
library(AppliedPredictiveModeling)
library(randomForest)
data(AlzheimerDisease)
adData = data.frame(diagnosis,predictors)
inTrain = createDataPartition(adData$diagnosis, p = 3/4)[[1]]
training = adData[ inTrain,]
testing = adData[-inTrain,]

set.seed(62433)

# Train the first models
fo <- train(diagnosis ~ ., data = training, method='rf')
bo <- train(diagnosis ~ ., data = training, method='gbm')
ld <- train(diagnosis ~ ., data = training, method='lda')

# Make primary testing predictions
fo_pre_test <- predict(fo, testing)
bo_pre_test <- predict(bo, testing)
ld_pre_test <- predict(ld, testing)

# Back predict on training data to stack
fo_pre <- predict(fo, training)
bo_pre <- predict(bo, training)
ld_pre <- predict(ld, training)

# Stack the training predictions in a random forest
stacked <- data.frame(training$diagnosis, fo_pre, bo_pre, ld_pre)
colnames(stacked)[1] <- 'diagnosis'
stacked_model <- train(diagnosis~., data= stacked, method='rf')

# Run the test data through the first set of predictors, then stack the output
stacked_tests <- data.frame(testing$diagnosis, fo_pre_test, bo_pre_test, ld_pre_test)
# Set the test colnames to what the model expects
colnames(stacked_tests) <- colnames(stacked)
# Test the model
stack_predictions <- predict(stacked_model, newdata = stacked_tests)


# Evaluate everything
confusionMatrix(testing$diagnosis, fo_pre_test)$overall[1]
confusionMatrix(testing$diagnosis, bo_pre_test)$overall[1]
confusionMatrix(testing$diagnosis, ld_pre_test)$overall[1]
confusionMatrix(testing$diagnosis, stack_predictions)$overall[1]

# It seems that the stack outperforms the initial models! Cool!

###########
#Q3
##########
library(caret)
set.seed(3523)
library(AppliedPredictiveModeling)
data(concrete)
inTrain = createDataPartition(concrete$CompressiveStrength, p = 3/4)[[1]]
training = concrete[ inTrain,]
testing = concrete[-inTrain,]

set.seed(223)
model <- train(CompressiveStrength ~., data = training, method = 'lasso')
prediction <- predict(model, testing)

library(elasticnet)
plot.enet(model$finalModel, xvar = "penalty")
# Looks like Cement comes down last



###########
#Q4
###########
library(lubridate) # For year() function below
dat = read.csv("~/Desktop/gaData.csv")
training = dat[year(dat$date) < 2012,]
testing = dat[(year(dat$date)) > 2011,]
tstrain = ts(training$visitsTumblr)

library(forecast)
model <- bats(tstrain)
fore <- forecast(model, level = 95, h = length(testing[,1]))

mean((fore$lower < testing$visitsTumblr) & (testing$visitsTumblr < fore$upper))
# Fit a model using ecast package to the training time series. Then forecast this model for the remaining time points. For how many of the testing points is the true value within the 95% prediction interval bounds?

#####
#Q5
#####
set.seed(3523)
library(e1071)
library(AppliedPredictiveModeling)
data(concrete)
inTrain = createDataPartition(concrete$CompressiveStrength, p = 3/4)[[1]]
training = concrete[ inTrain,]
testing = concrete[-inTrain,]

# Set the seed to 325 and fit a support vector machine using the e1071 package to predict Compressive Strength using the default settings. Predict on the testing set. What is the RMSE?
set.seed(325)

model <- svm(CompressiveStrength ~., data=training)


prediction <- predict(model, testing)
prediction
accuracy(prediction, testing$CompressiveStrength)

set.seed(325)
library(e1071)
mod_svm <- svm(CompressiveStrength ~ ., data = training)
pred_svm <- predict(mod_svm, testing)
accuracy(pred_svm, testing$CompressiveStrength)











