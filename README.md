## Introduction

For this project we were given a dataset from a UC Irvine human 
activity recognition study.  The data were taken using accelerometers 
and gyroscopes on smartphones for 30 volunteers (or subjects) who 
conducted six different activities (walking, standing, walking upstairs, 
walking downstairs, laying and sitting).  The data can be found at 
the UCI Machine Learning Reposity: 

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

While the data were initially separated into test and training 
subsets, we were asked to recombine those sets for this project.   

The dataset contains eight files that we will use for the assignment.  
These files are as follows:

The measurement data from the smartphones:
train/X_train.txt
test/X_test.txt

Descriptive names of the features being measured in each column:
features.txt

Numeric activity labels for each measurement:
train/y_train.txt
test/y_test.txt

Longer, descriptive activity labels that correlate with the numeric 
activity labels: 
activity_labels.txt

And, finally, numeric codes for each the subject of each measurement:
train/subject_train.txt
test/subject_test.txt

## Loading the measurement data

In the first part of the script, the measurement data files are read into 
R and merged into one dataframe called mergedDF.

## Subsetting the data

In the next part of the script, the data are subset to only include 
measures of the mean or standard deviation of a given variable.  I 
pulled these values using the grep() function and put these into 
a new dataframe called subsetDF. 

## Labeling the activities

The next piece of the script reads in the labels for the test and 
training data, as well as the activity look-up table that correlates 
acitivities with their numeric code.  The look-up table is read 
into a dataframe called activity.  The look-up table is used 
to create a new vector of descriptive labels, called labels2, 
that describes the acitivity done during each measurement. 

## Appropriately label the dataset with descriptive variable names

I used the setNames() function in the stats package to rename the 
columns to the descriptive names provided in the features.txt file. 
I named the resulting dataframe descr_colsDF.  I also had to add back 
in the activity labels column.

## Create a tidy dataset with the average of each variable for each activity and each subject. 

To subset by subject I have read the subject_test/train.txt files 
into R, merged these into one column and added these to the descr_colsDF 
dataframe.  Then I used the group_by function in the dplyr package to 
add groups to the dataframe based on the activity type and subject number.  
Finally, I have used the summarise_each function to take the mean of each 
subset column and I have written this dataframe to a text file using 
the write.table() function as described in the project description.  
