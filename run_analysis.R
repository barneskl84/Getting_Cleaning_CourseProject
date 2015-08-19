## This is a script to clean data from a UC Irvine human 
## activity recognition dataset.

## Read the test and training data into dataframes and merge into one dataframe

train <- read.table("train/X_train.txt", nrows=7352)
test <- read.table("test/X_test.txt", nrows=2947)
mergedDF <- rbind(train,test)

## Read the features data to search for mean and standard deviation (std) labels.
## Pull a subset dataframe containing only those columns that include 
## mean or std values

features <- read.table("features.txt")
mean_cols <- grep("mean",features$V2)
std_cols <- grep("std",features$V2)
mean_std_cols <- append(mean_cols, std_cols)
subsetDF <- mergedDF[,mean_std_cols]

## Read in the labels for the test and the training datasets as well
## as the user-friendly activity labels.
## Map the user-friendly labels to the integer labels

test_labels <- read.table("test/y_test.txt", nrows=2947)
train_labels <- read.table("train/y_train.txt", nrows=7352)
subsetDF$labels <- append(train_labels$V1,test_labels$V1)
activity <- read.table("activity_labels.txt")
subsetDF$labels2 <- factor(subsetDF$labels, activity$V1, activity$V2)

## Appropriately label the dataset with descriptive variable names

descr_colsDF <- setNames(object=subsetDF[,1:79],features[mean_std_cols,2])
descr_colsDF$activities <- subsetDF$labels2

## Create a new tidy data set with the average of each variable for each 
## activity and each subject

subject_test <- read.table("test/subject_test.txt", nrows=2947)
subject_train <- read.table("train/subject_train.txt", nrows=7352)
descr_colsDF$subject <- append(subject_train$V1,subject_test$V1)
tidyDF <- group_by(descr_colsDF, subject, activities)
tidy_data <- summarise_each(tidyDF, funs(mean))
write.table(tidy_data, file = "tidy_data.txt", row.names = FALSE)