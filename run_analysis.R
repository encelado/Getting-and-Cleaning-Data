#
# Coursera: Getting and Cleaning Data, 
#           by Jeff Leek, Bloomberg School of Public Health
#
# Course Project
#
# File: run_analysis.R
#

# This R script does the following:
# 
# 1. Merges the training and the test sets to create one data set.
# 2. Extracts only the measurements on the mean and standard deviation 
#    for each measurement. 
# 3. Uses descriptive activity names to name the activities in the data set
# 4. Appropriately labels the data set with descriptive variable names. 
# 5. Creates a second, independent tidy data set with the average of 
#    each variable for each activity and each subject. 

# set the path to the data set
path <- 'UCI HAR Dataset/'

# load the data sets
activity.labels <- read.table(paste0(path, 'activity_labels.txt'))

features <- read.table(paste0(path, 'features.txt'))

train.subject <- read.table(paste0(path, 'train/subject_train.txt'))
train.y <- read.table(paste0(path, 'train/y_train.txt'))
train.x <- read.table(paste0(path, 'train/X_train.txt'))

test.subject <- read.table(paste0(path, 'test/subject_test.txt'))
test.y <- read.table(paste0(path, 'test/y_test.txt'))
test.x <- read.table(paste0(path, 'test/X_test.txt'))

# merge into partial data sets
dataset.subject <- rbind(train.subject, test.subject)
dataset.y <- rbind(train.y, test.y)
dataset.x <- rbind(train.x, test.x)

# merge into one data set
dataset.all <- cbind(dataset.subject, dataset.y, dataset.x)

# give descriptive names to the dataset variables
names(features) <- c('id', 'name')
names(dataset.all) <- c('subject', 'label', as.vector(features$name))

# extract mean and std from measurements
extracted_feature_index <- grep("mean\\(\\)|std\\(\\)", names(dataset.all))
dataset.all <- dataset.all[,c(1,2,extracted_feature_index)]

# give descriptive activity names to the activities
dataset.all[2] <- activity.labels[dataset.all[2][,1],2]

# clean the measurement names
names(dataset.all) <- sapply(names(dataset.all), function(x) { gsub("\\(", "", x) })
names(dataset.all) <- sapply(names(dataset.all), function(x) { gsub("\\)", "", x) })
names(dataset.all) <- sapply(names(dataset.all), function(x) { gsub("-", "_", x) })

names(dataset.all) <- sapply(names(dataset.all), function(x) { gsub("BodyBody", "Body", x) })

# create the final data set averaging each variable grouping by subject and activity
library(reshape2)

dataset.melt <- melt(dataset.all, id.var=c('subject', 'label'))
dataset.avg <- dcast(dataset.melt, subject + label ~ variable, mean)

# write the final data set
write.table(dataset.avg, file='dataset_avg_2.txt', sep=',')
