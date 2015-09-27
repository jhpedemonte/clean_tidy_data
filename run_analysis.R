################################################################################
#
#  Manipulates the UCI wearables datasets and generates a tidy dataset
#  containing the average of all of the "mean" and "standard deviation"
#  measurements, grouped by subject (user) and activity type.
#
#  NOTE: Assumes that UCI data is available as directory labeled
#  "UCI HAR Dataset" in the working directory.
#
################################################################################

library(dplyr)


### merge training and test sets

# read feature data
features <- read.table('UCI HAR Dataset/features.txt')
test <- tbl_df( read.table('UCI HAR Dataset/test/X_test.txt', col.names = features[,2]) )
train <- tbl_df( read.table('UCI HAR Dataset/train/X_train.txt', col.names = features[,2]) )

# bind columns for activity label and subjects
activity <- read.table('UCI HAR Dataset/test/y_test.txt')
subject <- read.table('UCI HAR Dataset/test/subject_test.txt')
test <- bind_cols(data.frame(subject[,1]), data.frame(activity[,1]), test)
colnames(test)[1] <- "subject"
colnames(test)[2] <- "activity"

activity <- read.table('UCI HAR Dataset/train/y_train.txt')
subject <- read.table('UCI HAR Dataset/train/subject_train.txt')
train <- bind_cols(data.frame(subject[,1]), data.frame(activity[,1]), train)
colnames(train)[1] <- "subject"
colnames(train)[2] <- "activity"

### merge test & train datasets
merged <- bind_rows(train, test)


### extract only measurements on mean and standard deviation for each measurement
data <- select(merged, subject, activity,
	contains("mean..", ignore.case = FALSE),
	contains("std", ignore.case = FALSE))


### use descriptive activity names for activities in the data set
labels <- read.table('UCI HAR Dataset/activity_labels.txt')
data$activity <- factor(data$activity, labels = labels[,2])


### create tidy data set with average of each variable for each activity and each subject
tidy_df <- aggregate(. ~ subject + activity, data = data, mean)
