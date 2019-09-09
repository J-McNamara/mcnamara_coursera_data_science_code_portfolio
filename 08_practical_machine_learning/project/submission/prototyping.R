ptm <- proc.time()
# Set up the environment
library(caret)
library(beepr)
#library(ggpolot2)
#library(ElemStatLearn)
#library(dplyr)
#library(e1071)
set.seed(25246)

# Load the data
df <- read.csv('pml-training.csv')
validation <- read.csv('pml-testing.csv')

# Get rid of junk data
used <- !is.na(validation[4,])
df <- df[,used] # Only include variables used in val
validation <- validation[,used] # get rid of empties
df <- df[,2:60] # The data are sorted- get rid of index!
validation <- validation[,2:60] #  The data are sorted- get rid of index!

# Generate a test set
inTrain = createDataPartition(df$classe, p = 0.75)[[1]]
training <- df[inTrain,]
testing <- df[-inTrain,]

# Center and scale the values
pre_proc <- preProcess(training, method = c("center", "scale"))
training_processed <- predict(pre_proc, training)
testing_processed <- predict(pre_proc, testing)
validation_processed <- predict(pre_proc, validation)

# Train ML model
model <- train(classe~., data=training_processed, method='gbm')#, na.action = na.pass)
saveRDS(file='model_03.Rda', model)
        #load(file='model_03.Rda', model)
# Evaluate model on test set
test_preds <- predict(model, testing_processed)
test_matrix <- confusionMatrix(test_preds, testing_processed$classe)

# Make predictions for validation set
val_preds <- predict(model, validation_processed)
val_preds
save(val_preds, file='val_preds.Rda')
beep()
proc.time() - ptm
