Getting and Cleaning Data Course Project CodeBook
=================================================
The present file serves as the code book for the tidy_data_set.txt data set found in this repository.
This data set is the product of Getting and Cleaning Data's Course Project (getdata-016).
The document will summarize information about the original data, any transformations conducted on it 
and the final output.

Project instructors selected data collected from the accelerometers from the Samsung Galaxy S smartphone 
(more information on: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones). 

The original data can be found in: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

1-First X_train.txt, y_train.txt & subject_train.txt were merged on a data set (trainfull), 
the same as X_test.txt, y_test.txt & subject_test (in the data ser testfull). 
Both full datasets were merged into the fulldata dataset.
The names of the variables for subject and activities were changed to subject and activities
2- Then features.txt which includes both the codes and number of the meassured deature was loaded,
both to be merged into fulldata but also to work as a subset to all mean and sd related activities.
Consequently, before the subset 2 rows were added to enable to mantain the variables activities and subject in the subset.
The product of this step was the dataset: fulldatared. The subset is a gepl function in which the pattern argument corresponds to: 'mean\\(|std\\(|subject|activities'
3-The values of the levels of activities were changed to more descriptive labels, 
based on the activity_labels.txt file found in the original data
4-The subset in step 4 was used to label the variables of fulldatared. Further cleansing were made, 
removing both the "()" and "-" and shifting "mean" to "Mean"/"std" to "StD" to make variables more readable.
A first data set was exported to .txt format: fulldatared.txt
5-Finally, a tidy dataset based in the previous one (but exported independently) was created 
with the average of each variable for each activity and each subject. An lapply + .SD/by combination was used to create this
data set: tidy_data_set.txt

Variables included in tidy_data_set.txt:
[1] Activities: Meassured Activities; Levels: "walking", "walkingupstairs", "walkingdownstairs", "sitting", "standing", "laying"
[2] Subject: The ID of the volunteers of the experiment.
-The following variables corresponding to the mean of each measurement for each activity and subject:
 [3] "tBodyAccMeanX",       
 [4] "tBodyAccMeanY"            "tBodyAccMeanZ"            "tBodyAccStDX"            
 [7] "tBodyAccStDY"             "tBodyAccStDZ"             "tGravityAccMeanX"        
[10] "tGravityAccMeanY"         "tGravityAccMeanZ"         "tGravityAccStDX"         
[13] "tGravityAccStDY"          "tGravityAccStDZ"          "tBodyAccJerkMeanX"       
[16] "tBodyAccJerkMeanY"        "tBodyAccJerkMeanZ"        "tBodyAccJerkStDX"        
[19] "tBodyAccJerkStDY"         "tBodyAccJerkStDZ"         "tBodyGyroMeanX"          
[22] "tBodyGyroMeanY"           "tBodyGyroMeanZ"           "tBodyGyroStDX"           
[25] "tBodyGyroStDY"            "tBodyGyroStDZ"            "tBodyGyroJerkMeanX"      
[28] "tBodyGyroJerkMeanY"       "tBodyGyroJerkMeanZ"       "tBodyGyroJerkStDX"       
[31] "tBodyGyroJerkStDY"        "tBodyGyroJerkStDZ"        "tBodyAccMagMean"         
[34] "tBodyAccMagStD"           "tGravityAccMagMean"       "tGravityAccMagStD"       
[37] "tBodyAccJerkMagMean"      "tBodyAccJerkMagStD"       "tBodyGyroMagMean"        
[40] "tBodyGyroMagStD"          "tBodyGyroJerkMagMean"     "tBodyGyroJerkMagStD"     
[43] "fBodyAccMeanX"            "fBodyAccMeanY"            "fBodyAccMeanZ"           
[46] "fBodyAccStDX"             "fBodyAccStDY"             "fBodyAccStDZ"            
[49] "fBodyAccJerkMeanX"        "fBodyAccJerkMeanY"        "fBodyAccJerkMeanZ"       
[52] "fBodyAccJerkStDX"         "fBodyAccJerkStDY"         "fBodyAccJerkStDZ"        
[55] "fBodyGyroMeanX"           "fBodyGyroMeanY"           "fBodyGyroMeanZ"          
[58] "fBodyGyroStDX"            "fBodyGyroStDY"            "fBodyGyroStDZ"           
[61] "fBodyAccMagMean"          "fBodyAccMagStD"           "fBodyBodyAccJerkMagMean" 
[64] "fBodyBodyAccJerkMagStD"   "fBodyBodyGyroMagMean"     "fBodyBodyGyroMagStD"     
[67] "fBodyBodyGyroJerkMagMean" "fBodyBodyGyroJerkMagStD" 

While the label are difficult to understand, the follow a basic code taken from the original data set's features_info.txt file:
"The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. These time domain signals (prefix 't' to denote time) were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ) using another low pass Butterworth filter with a corner frequency of 0.3 Hz. 

Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag). 

Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. (Note the 'f' to indicate frequency domain signals). 

These signals were used to estimate variables of the feature vector for each pattern:  
'-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.

tBodyAcc-XYZ
tGravityAcc-XYZ
tBodyAccJerk-XYZ
tBodyGyro-XYZ
tBodyGyroJerk-XYZ
tBodyAccMag
tGravityAccMag
tBodyAccJerkMag
tBodyGyroMag
tBodyGyroJerkMag
fBodyAcc-XYZ
fBodyAccJerk-XYZ
fBodyGyro-XYZ
fBodyAccMag
fBodyAccJerkMag
fBodyGyroMag
fBodyGyroJerkMag
"
