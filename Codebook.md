# CodeBook

## Input Data

The run_analysis.R script read data present in 'UCI HAR Dataset' sub-directory.

## Output Data

The run_analysis.R script generates a tidy data set written in the output file 'avg_dataset.txt' containing the average of the mean and standard deviation for each measurements, originally sampled from the 3-axial accelerometer and gyroscope, grouped by activity and subject.

The output file contains the following variables:

1. the subject id of the person that performed the activity
2. a description of the activity that was performed
3. the mean and standard deviation for each of the following measurements:

* tBodyAcc
* tBodyAccJerk
* tBodyGyro
* tBodyGyroJerk
* tGravityAcc
* fBodyAcc
* fBodyAccJerk      
* fBodyGyro

where each variable has the three components along the x,y,z axis and the corresponding magnitude.

Moreover the magnitude of the following variable is provided in the final data set along with its mean and standard deviation:

* fBodyGyroJerk

A total of 66 variables are present in the final data set.

All the above features has been normalized and bounded within [-1,1] in the original data set, so no unit of measurements is applicable to them.

## Transformations

The script performs the following operations stating from the original UCI data:

1. The training and test set is merged to obtain one bigger tidy data set containing the subject id of the person that carried out the experiment, a description of the activity that was performed and all the measurements recorded from the sensors of the smartphone.

2. For each measurement it is extracted the mean and standard deviation. All the measurements were obtained matching the variable names against the "mean()" and "std()" patterns. This , for example, excluded the variables ending in "meanFreq()"

3. The original variable names were cleaned to obtain names suitable for later analysis in R, i.e. 
a. the minus signs were substituted by underscores and the parenthesis were removed. For example the variable name "tBodyAcc-mean()-X" becomes "tBodyAcc_mean_X".
c. it is corrected the 'Body' duplication in some of the original names, for examples in 'fBodyBodyAccJerkMag_std'.

4. Finally a tidy data set with the average of each variable for each activity and each subject was written in the output file.
The format of the output file is described in the 'Output Data' section of this CodeBook. 
To perform this task it was used the melt and dcast functions present in reshape2 library
