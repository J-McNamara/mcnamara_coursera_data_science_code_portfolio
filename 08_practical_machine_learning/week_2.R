library(AppliedPredictiveModeling)
library(caret)
data(concrete)
library(caret)
library(Hmisc)
set.seed(1000)
inTrain = createDataPartition(mixtures$CompressiveStrength, p = 3/4)[[1]]
training = mixtures[ inTrain,]
testing = mixtures[-inTrain,]

ggplot(training, aes(x = x, y=y, color=training$Cement)) + geom_point()
ggplot(training, aes(x = x, y=y, color=training$Cement)) + geom_point()
col

x <- 1:length(training[,1])

for (i in 1:length(colnames(training))) {
        name <<- colnames(training)[i]
        
        a <- ggplot(training, aes(x = x, y=y, color=name)) + geom_point()
        print(a)
        print(name)
        readline(prompt="Press [enter] to continue")
        }
############
library(AppliedPredictiveModeling)
data(concrete)
library(caret)
set.seed(1000)
inTrain = createDataPartition(mixtures$CompressiveStrength, p = 3/4)[[1]]
training = mixtures[ inTrain,]
testing = mixtures[-inTrain,]
hist(log(training$Superplasticizer))

########
Q4
########
library(caret)
library(AppliedPredictiveModeling)
set.seed(3433)
data(AlzheimerDisease)
adData = data.frame(diagnosis,predictors)
inTrain = createDataPartition(adData$diagnosis, p = 3/4)[[1]]
training = adData[ inTrain,]
testing = adData[-inTrain,]

a <- grep(pattern = 'IL', colnames(testing))
training <- training[a]
preProcess(x = training, method = 'pca', thresh = 0.8)

##########
# Q5
###########
library(caret)
library(AppliedPredictiveModeling)
set.seed(3433)
data(AlzheimerDisease)
adData = data.frame(diagnosis,predictors)
inTrain = createDataPartition(adData$diagnosis, p = 3/4)[[1]]

a <- grep(pattern = 'IL', colnames(adData))
a <- append(1, a[1:12])
adData <- adData[,a]

training = adData[ inTrain,]
testing = adData[-inTrain,]

# Train the model
raw_model <- train(diagnosis ~., data = training, method='glm', na.action = 'na.pass')
# Use model to predict diagnosis for test data
raw_prediction <- predict(raw_model, testing[,2:13])
# Evaluate model with confusion matrix
raw_result <- confusionMatrix(testing[,1], raw_prediction)

# Perform PCA
pca_model <- preProcess(training, method = 'pca', thresh = 0.8)
pca_comps <- predict(pca_model, training)
pca_comps_test <- predict(pca_model, testing)

comps_model <- train(diagnosis ~ ., data = pca_comps, method = 'glm')
comps_pred <- predict(comps_model, pca_comps_test)
comps_result <- confusionMatrix(pca_comps_test[,1], comps_pred)

# Check results
raw_result
comps_result
